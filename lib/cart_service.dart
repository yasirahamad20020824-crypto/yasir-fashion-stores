import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  /// Returns the cart sub-collection for the current user.
  /// Throws a clear error if not authenticated.
  CollectionReference get _cartCollection {
    final uid = _userId;
    if (uid == null) throw Exception('User not logged in');
    return _db.collection('users').doc(uid).collection('cart');
  }

  // ──────────────────────────────────────────────────────────────────────────
  // ADD TO CART
  // ──────────────────────────────────────────────────────────────────────────

  /// Adds a product to the cart.
  /// • If the same product (matched by name) already exists → increments qty.
  /// • Otherwise creates a new document.
  Future<void> addToCart(Map<String, dynamic> product) async {
    try {
      final col = _cartCollection;
      final query = await col
          .where('name', isEqualTo: product['name'])
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        // Product already in cart → bump quantity
        final doc = query.docs.first;
        final currentQty = (doc['qty'] as int?) ?? 1;
        await doc.reference.update({'qty': currentQty + 1});
      } else {
        // New cart item
        await col.add({
          'name': product['name'],
          'price': (product['price'] as num).toDouble(),
          'image': product['imageAsset'] ?? product['image'] ?? '',
          'qty': 1,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // STREAM CART ITEMS
  // ──────────────────────────────────────────────────────────────────────────

  /// Real-time stream of all cart items for the logged-in user.
  /// Returns an empty stream safely when the user is not authenticated.
  Stream<List<Map<String, dynamic>>> getCartItems() {
    final uid = _userId;
    if (uid == null) {
      // Not logged in → emit empty list immediately
      return Stream.value([]);
    }

    return _db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .orderBy('addedAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return <String, dynamic>{
                ...data,
                'id': doc.id,
                // Ensure numeric types are correct
                'price': (data['price'] as num?)?.toDouble() ?? 0.0,
                'qty': (data['qty'] as int?) ?? 1,
              };
            }).toList());
  }

  // ──────────────────────────────────────────────────────────────────────────
  // UPDATE QUANTITY
  // ──────────────────────────────────────────────────────────────────────────

  /// Updates the quantity of a cart item.
  /// • If newQty < 1 the item is removed automatically.
  Future<void> updateQuantity(String docId, int newQty) async {
    try {
      if (newQty < 1) {
        await _cartCollection.doc(docId).delete();
      } else {
        await _cartCollection.doc(docId).update({'qty': newQty});
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // REMOVE ITEM
  // ──────────────────────────────────────────────────────────────────────────

  /// Removes a single item from the cart.
  Future<void> removeFromCart(String docId) async {
    try {
      await _cartCollection.doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to remove item: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // CLEAR CART
  // ──────────────────────────────────────────────────────────────────────────

  /// Deletes all items from the cart in a single batch write.
  /// Called automatically after a successful order.
  Future<void> clearCart() async {
    try {
      final snapshot = await _cartCollection.get();
      if (snapshot.docs.isEmpty) return;
      final batch = _db.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // CART COUNT (helper for badge display)
  // ──────────────────────────────────────────────────────────────────────────

  /// Stream of the total number of items (sum of qty) in the cart.
  Stream<int> getCartItemCount() {
    return getCartItems().map(
      (items) => items.fold<int>(0, (sum, item) => sum + ((item['qty'] as int?) ?? 1)),
    );
  }
}
