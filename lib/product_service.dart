import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch products for a given category from Firestore.
  /// Category values: 'tops', 'bottoms', 'shoes', 'all', 'bags', 'beauty', 'clothes'
  Future<List<Map<String, dynamic>>> fetchProducts(String category) async {
    try {
      final query = await _db
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      return query.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
