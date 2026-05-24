import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  CollectionReference get _favCollection {
    if (_userId == null) throw Exception('User not logged in');
    return _db.collection('users').doc(_userId).collection('favorites');
  }

  /// Toggles a product's favorite status.
  Future<void> toggleFavorite(Map<String, dynamic> product) async {
    try {
      final query = await _favCollection
          .where('name', isEqualTo: product['name'])
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();
      } else {
        await _favCollection.add({
          'name': product['name'],
          'price': product['price'],
          'image': product['imageAsset'] ?? product['image'],
          'addedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  /// Streams the user's favorite products.
  Stream<List<Map<String, dynamic>>> getFavorites() {
    return _favCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => {
        ...(doc.data() as Map<String, dynamic>),
        'id': doc.id,
      }).toList();
    });
  }

  /// Streams IDs of favorite products for UI checks.
  Stream<Set<String>> getFavoriteNames() {
    return _favCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String).toSet();
    });
  }
}
