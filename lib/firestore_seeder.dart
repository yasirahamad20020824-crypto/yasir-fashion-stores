import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final List<Map<String, dynamic>> _products = [
    // ─── TOPS ─────────────────────────────────────────────────────────────────
    {'name': 'Floral Lace Top',        'price': 45.00, 'imageAsset': 'lib/assets/images/top/download_1.jpg',   'category': 'tops'},
    {'name': 'Silk V-Neck Blouse',     'price': 58.00, 'imageAsset': 'lib/assets/images/top/download_2.jpg',   'category': 'tops'},
    {'name': 'Casual Cotton Tee',      'price': 22.00, 'imageAsset': 'lib/assets/images/top/download_3.jpg',   'category': 'tops'},
    {'name': 'Summer Tank Top',        'price': 18.50, 'imageAsset': 'lib/assets/images/top/download_4.jpg',   'category': 'tops'},
    {'name': 'Elegant Evening Top',    'price': 65.00, 'imageAsset': 'lib/assets/images/top/download_5.jpeg',  'category': 'tops'},
    {'name': 'Boho Embroidered Top',   'price': 42.00, 'imageAsset': 'lib/assets/images/top/download_6.jpeg',  'category': 'tops'},
    {'name': 'Ruffle Sleeve Blouse',   'price': 38.00, 'imageAsset': 'lib/assets/images/top/download_7.jpeg',  'category': 'tops'},
    {'name': 'Classic Button-Up',      'price': 48.00, 'imageAsset': 'lib/assets/images/top/download_8.jpg',   'category': 'tops'},
    {'name': 'Peplum Waist Top',       'price': 52.00, 'imageAsset': 'lib/assets/images/top/download_1.jpg',   'category': 'tops'},
    {'name': 'Chiffon Layered Top',    'price': 49.00, 'imageAsset': 'lib/assets/images/top/download_2.jpg',   'category': 'tops'},
    {'name': 'Striped Jersey Top',     'price': 24.00, 'imageAsset': 'lib/assets/images/top/download_3.jpg',   'category': 'tops'},
    {'name': 'Polka Dot Cami',         'price': 20.00, 'imageAsset': 'lib/assets/images/top/download_4.jpg',   'category': 'tops'},
    {'name': 'Velvet Wrap Top',        'price': 70.00, 'imageAsset': 'lib/assets/images/top/download_5.jpeg',  'category': 'tops'},
    {'name': 'Denim Shirt',            'price': 55.00, 'imageAsset': 'lib/assets/images/top/download_6.jpeg',  'category': 'tops'},
    {'name': 'Knit Sweater Top',       'price': 62.00, 'imageAsset': 'lib/assets/images/top/download_7.jpeg',  'category': 'tops'},
    {'name': 'Off-Shoulder Blouse',    'price': 44.00, 'imageAsset': 'lib/assets/images/top/download_8.jpg',   'category': 'tops'},

    // ─── BOTTOMS ──────────────────────────────────────────────────────────────
    {'name': 'Slim Fit Jeans',         'price': 55.00, 'imageAsset': 'lib/assets/images/bottom/download_1.jpg',  'category': 'bottoms'},
    {'name': 'High-Waist Trousers',    'price': 62.00, 'imageAsset': 'lib/assets/images/bottom/download_2.jpg',  'category': 'bottoms'},
    {'name': 'Casual Chinos',          'price': 48.00, 'imageAsset': 'lib/assets/images/bottom/download_3.jpg',  'category': 'bottoms'},
    {'name': 'Linen Shorts',           'price': 35.00, 'imageAsset': 'lib/assets/images/bottom/download_4.jpg',  'category': 'bottoms'},
    {'name': 'Cargo Pants',            'price': 50.00, 'imageAsset': 'lib/assets/images/bottom/download_5.jpg',  'category': 'bottoms'},
    {'name': 'Pleated Skirt',          'price': 45.00, 'imageAsset': 'lib/assets/images/bottom/download_6.jpg',  'category': 'bottoms'},
    {'name': 'Wide-Leg Pants',         'price': 58.00, 'imageAsset': 'lib/assets/images/bottom/download_7.jpg',  'category': 'bottoms'},
    {'name': 'Denim Cutoffs',          'price': 32.00, 'imageAsset': 'lib/assets/images/bottom/download_8.jpeg', 'category': 'bottoms'},
    {'name': 'Leather Leggings',       'price': 75.00, 'imageAsset': 'lib/assets/images/bottom/download_1.jpg',  'category': 'bottoms'},
    {'name': 'Jogger Sweatpants',      'price': 40.00, 'imageAsset': 'lib/assets/images/bottom/download_2.jpg',  'category': 'bottoms'},
    {'name': 'Corduroy Pants',         'price': 54.00, 'imageAsset': 'lib/assets/images/bottom/download_3.jpg',  'category': 'bottoms'},
    {'name': 'Bermuda Shorts',         'price': 28.00, 'imageAsset': 'lib/assets/images/bottom/download_4.jpg',  'category': 'bottoms'},
    {'name': 'Pencil Skirt',           'price': 42.00, 'imageAsset': 'lib/assets/images/bottom/download_5.jpg',  'category': 'bottoms'},
    {'name': 'Culottes',               'price': 46.00, 'imageAsset': 'lib/assets/images/bottom/download_6.jpg',  'category': 'bottoms'},
    {'name': 'Tailored Slacks',        'price': 68.00, 'imageAsset': 'lib/assets/images/bottom/download_7.jpg',  'category': 'bottoms'},
    {'name': 'Paperbag Waist Pants',   'price': 52.00, 'imageAsset': 'lib/assets/images/bottom/download_8.jpeg', 'category': 'bottoms'},

    // ─── SHOES ────────────────────────────────────────────────────────────────
    {'name': 'White Leather Sneakers', 'price': 85.00,  'imageAsset': 'lib/assets/images/shoes/download_1.jpg',   'category': 'shoes'},
    {'name': 'Classic Running Shoes',  'price': 110.00, 'imageAsset': 'lib/assets/images/shoes/download_2.jpg',   'category': 'shoes'},
    {'name': 'Formal Oxford Shoes',    'price': 125.00, 'imageAsset': 'lib/assets/images/shoes/download_3.jpeg',  'category': 'shoes'},
    {'name': 'Casual Loafers',         'price': 65.00,  'imageAsset': 'lib/assets/images/shoes/download_4.jpg',   'category': 'shoes'},
    {'name': 'Sporty Training Shoes',  'price': 95.00,  'imageAsset': 'lib/assets/images/shoes/download_5.jpg',   'category': 'shoes'},
    {'name': 'Canvas Slip-Ons',        'price': 45.00,  'imageAsset': 'lib/assets/images/shoes/download_6.jpg',   'category': 'shoes'},
    {'name': 'Suede Desert Boots',     'price': 120.00, 'imageAsset': 'lib/assets/images/shoes/download_7.jpg',   'category': 'shoes'},
    {'name': 'Lightweight Trainers',   'price': 75.00,  'imageAsset': 'lib/assets/images/shoes/download_8.jpg',   'category': 'shoes'},
    {'name': 'Street Style High-Tops', 'price': 98.00,  'imageAsset': 'lib/assets/images/shoes/download_1.jpg',   'category': 'shoes'},
    {'name': 'Marathon Pro Shoes',     'price': 145.00, 'imageAsset': 'lib/assets/images/shoes/download_2.jpg',   'category': 'shoes'},
    {'name': 'Brogue Leather Shoes',   'price': 135.00, 'imageAsset': 'lib/assets/images/shoes/download_3.jpeg',  'category': 'shoes'},
    {'name': 'Summer Boat Shoes',      'price': 70.00,  'imageAsset': 'lib/assets/images/shoes/download_4.jpg',   'category': 'shoes'},
    {'name': 'Outdoor Hiking Boots',   'price': 150.00, 'imageAsset': 'lib/assets/images/shoes/download_5.jpg',   'category': 'shoes'},
    {'name': 'Simple Flip-Flops',      'price': 25.00,  'imageAsset': 'lib/assets/images/shoes/download_6.jpg',   'category': 'shoes'},
    {'name': 'Classic Timber Boots',   'price': 160.00, 'imageAsset': 'lib/assets/images/shoes/download_7.jpg',   'category': 'shoes'},
    {'name': 'Performance Gym Shoes',  'price': 88.00,  'imageAsset': 'lib/assets/images/shoes/download_8.jpg',   'category': 'shoes'},

    // ─── ALL ──────────────────────────────────────────────────────────────────
    {'name': 'Casual Streetwear',      'price': 45.00,  'imageAsset': 'lib/assets/images/all/download_1.jpg',  'category': 'all'},
    {'name': 'Evening Dress',          'price': 120.00, 'imageAsset': 'lib/assets/images/all/download_2.jpg',  'category': 'all'},
    {'name': 'Urban Hoodie',           'price': 55.00,  'imageAsset': 'lib/assets/images/all/download_3.jpg',  'category': 'all'},
    {'name': 'Formal Blazer',          'price': 95.00,  'imageAsset': 'lib/assets/images/all/download_4.jpg',  'category': 'all'},
    {'name': 'Denim Jacket',           'price': 75.00,  'imageAsset': 'lib/assets/images/all/download_5.jpg',  'category': 'all'},
    {'name': 'Graphic Tee',            'price': 25.00,  'imageAsset': 'lib/assets/images/all/download_6.jpg',  'category': 'all'},
    {'name': 'Summer Skirt',           'price': 35.00,  'imageAsset': 'lib/assets/images/all/download_7.jpg',  'category': 'all'},
    {'name': 'Winter Coat',            'price': 150.00, 'imageAsset': 'lib/assets/images/all/download_8.jpg',  'category': 'all'},
    {'name': 'Cotton Polo',            'price': 38.00,  'imageAsset': 'lib/assets/images/all/download_9.jpg',  'category': 'all'},
    {'name': 'Luxury Handbag',         'price': 210.00, 'imageAsset': 'lib/assets/images/all/download_10.jpg', 'category': 'all'},

    // ─── BAGS ─────────────────────────────────────────────────────────────────
    {'name': 'Classic Tote Bag',       'price': 75.00,  'imageAsset': 'lib/assets/images/bages/download_1.jpg', 'category': 'bags'},
    {'name': 'Leather Crossbody',      'price': 95.00,  'imageAsset': 'lib/assets/images/bages/download_2.jpg', 'category': 'bags'},
    {'name': 'Canvas Backpack',        'price': 55.00,  'imageAsset': 'lib/assets/images/bages/download_3.jpg', 'category': 'bags'},
    {'name': 'Mini Shoulder Bag',      'price': 45.00,  'imageAsset': 'lib/assets/images/bages/download_4.jpg', 'category': 'bags'},
    {'name': 'Luxury Clutch',          'price': 120.00, 'imageAsset': 'lib/assets/images/bages/download_5.jpg', 'category': 'bags'},
    {'name': 'Boho Woven Bag',         'price': 40.00,  'imageAsset': 'lib/assets/images/bages/download_6.jpg', 'category': 'bags'},
    {'name': 'Suede Bucket Bag',       'price': 88.00,  'imageAsset': 'lib/assets/images/bages/download_7.jpg', 'category': 'bags'},
    {'name': 'Travel Duffel Bag',      'price': 110.00, 'imageAsset': 'lib/assets/images/bages/download_8.jpg', 'category': 'bags'},
    {'name': 'Straw Beach Bag',        'price': 35.00,  'imageAsset': 'lib/assets/images/bages/download_1.jpg', 'category': 'bags'},
    {'name': 'Quilted Chain Bag',      'price': 130.00, 'imageAsset': 'lib/assets/images/bages/download_2.jpg', 'category': 'bags'},
    {'name': 'Nylon Zip Bag',          'price': 50.00,  'imageAsset': 'lib/assets/images/bages/download_3.jpg', 'category': 'bags'},
    {'name': 'Velvet Evening Bag',     'price': 85.00,  'imageAsset': 'lib/assets/images/bages/download_4.jpg', 'category': 'bags'},
    {'name': 'Printed Tote',           'price': 42.00,  'imageAsset': 'lib/assets/images/bages/download_5.jpg', 'category': 'bags'},
    {'name': 'Metallic Clutch',        'price': 65.00,  'imageAsset': 'lib/assets/images/bages/download_6.jpg', 'category': 'bags'},
    {'name': 'Backpack Purse',         'price': 72.00,  'imageAsset': 'lib/assets/images/bages/download_7.jpg', 'category': 'bags'},
    {'name': 'Large Shopper Bag',      'price': 58.00,  'imageAsset': 'lib/assets/images/bages/download_8.jpg', 'category': 'bags'},

    // ─── BEAUTY ───────────────────────────────────────────────────────────────
    {'name': 'Glow Foundation',        'price': 32.00, 'imageAsset': 'lib/assets/images/beuty/download_1.jpg', 'category': 'beauty'},
    {'name': 'Matte Lipstick',         'price': 18.00, 'imageAsset': 'lib/assets/images/beuty/download_2.jpg', 'category': 'beauty'},
    {'name': 'Eye Shadow Palette',     'price': 45.00, 'imageAsset': 'lib/assets/images/beuty/download_3.jpg', 'category': 'beauty'},
    {'name': 'Hydrating Serum',        'price': 55.00, 'imageAsset': 'lib/assets/images/beuty/download_4.jpg', 'category': 'beauty'},
    {'name': 'Rose Face Cream',        'price': 48.00, 'imageAsset': 'lib/assets/images/beuty/download_5.jpg', 'category': 'beauty'},
    {'name': 'Volumizing Mascara',     'price': 22.00, 'imageAsset': 'lib/assets/images/beuty/download_6.jpg', 'category': 'beauty'},
    {'name': 'Perfume Collection',     'price': 85.00, 'imageAsset': 'lib/assets/images/beuty/download_7.jpg', 'category': 'beauty'},
    {'name': 'Blush & Contour Set',    'price': 38.00, 'imageAsset': 'lib/assets/images/beuty/download_8.jpg', 'category': 'beauty'},
    {'name': 'Sunscreen SPF 50',       'price': 25.00, 'imageAsset': 'lib/assets/images/beuty/download_1.jpg', 'category': 'beauty'},
    {'name': 'Lip Gloss Set',          'price': 15.00, 'imageAsset': 'lib/assets/images/beuty/download_2.jpg', 'category': 'beauty'},
    {'name': 'Highlighter Powder',     'price': 28.00, 'imageAsset': 'lib/assets/images/beuty/download_3.jpg', 'category': 'beauty'},
    {'name': 'Anti-Aging Cream',       'price': 72.00, 'imageAsset': 'lib/assets/images/beuty/download_4.jpg', 'category': 'beauty'},
    {'name': 'Tinted Moisturizer',     'price': 35.00, 'imageAsset': 'lib/assets/images/beuty/download_5.jpg', 'category': 'beauty'},
    {'name': 'Brow Pencil',            'price': 12.00, 'imageAsset': 'lib/assets/images/beuty/download_6.jpg', 'category': 'beauty'},
    {'name': 'Floral Body Mist',       'price': 30.00, 'imageAsset': 'lib/assets/images/beuty/download_7.jpg', 'category': 'beauty'},
    {'name': 'Setting Powder',         'price': 26.00, 'imageAsset': 'lib/assets/images/beuty/download_8.jpg', 'category': 'beauty'},

    // ─── CLOTHES (General) ────────────────────────────────────────────────────
    {'name': 'Roller Rabbit',          'price': 198.00, 'imageAsset': 'lib/assets/images/Clothes/Download_1.jpg', 'category': 'clothes'},
    {'name': 'Endless Rose',           'price': 50.00,  'imageAsset': 'lib/assets/images/Clothes/Download_2.png', 'category': 'clothes'},
    {'name': 'Theory',                 'price': 345.00, 'imageAsset': 'lib/assets/images/Clothes/Download_3.png', 'category': 'clothes'},
    {'name': 'Madewell',               'price': 69.50,  'imageAsset': 'lib/assets/images/Clothes/Download_4.png', 'category': 'clothes'},
    {'name': 'House of CB',            'price': 120.00, 'imageAsset': 'lib/assets/images/Clothes/Download_5.png', 'category': 'clothes'},
    {'name': 'Zara',                   'price': 45.00,  'imageAsset': 'lib/assets/images/Clothes/Download_6.png', 'category': 'clothes'},
  ];

  /// Call this once to seed all products into Firestore.
  /// It checks if a product already exists by name to avoid duplicates.
  static Future<void> seedAll() async {
    for (final product in _products) {
      final snapshot = await _db
          .collection('products')
          .where('name', isEqualTo: product['name'])
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        await _db.collection('products').add({
          ...product,
          'seededAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  /// Check if products have already been seeded.
  static Future<bool> isSeeded() async {
    final snapshot = await _db
        .collection('products')
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}
