import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  /// Saves an order to Firestore.
  Future<String> placeOrder({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double total,
    required Map<String, dynamic> deliveryDetails,
    required String paymentMethod,
  }) async {
    try {
      final uid = _userId;
      if (uid == null) throw Exception('User not logged in');

      final orderData = {
        'userId': uid,
        'items': items,
        'subtotal': subtotal,
        'total': total,
        'deliveryDetails': deliveryDetails,
        'paymentMethod': paymentMethod,
        'status': 'Processing',
        'orderDate': FieldValue.serverTimestamp(),
        'orderNumber': 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      };

      final docRef = await _db.collection('orders').add(orderData);
      
      // Also save to a subcollection under the user for easier access
      await _db.collection('users').doc(uid).collection('orders').doc(docRef.id).set(orderData);

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  /// Streams the user's order history.
  Stream<List<Map<String, dynamic>>> getOrderHistory() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);

    return _db
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return {
                ...data,
                'id': doc.id,
              };
            }).toList());
  }
}
