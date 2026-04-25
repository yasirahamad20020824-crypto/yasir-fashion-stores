import 'package:flutter/material.dart';
import 'product_description_page.dart';
import 'search_page.dart';

class ClothesPage extends StatefulWidget {
  const ClothesPage({super.key});

  @override
  State<ClothesPage> createState() => _ClothesPageState();
}

class _ClothesPageState extends State<ClothesPage> {
  // Track favourite state for each product
  final List<bool> _favourites = List.filled(6, false);

  final List<Map<String, String>> _products = [
    {
      'name': 'Roller Rabbit',
      'price': '\$198.00',
      'image': 'lib/assets/images/Clothes/Download_1.jpg',
    },
    {
      'name': 'Endless Rose',
      'price': '\$50.00',
      'image': 'lib/assets/images/Clothes/Download_2.png',
    },
    {
      'name': 'Theory',
      'price': '\$345.00',
      'image': 'lib/assets/images/Clothes/Download_3.png',
    },
    {
      'name': 'Madewell',
      'price': '\$69.50',
      'image': 'lib/assets/images/Clothes/Download_4.png',
    },
    {
      'name': 'House of CB',
      'price': '\$120.00',
      'image': 'lib/assets/images/Clothes/Download_5.png',
    },
    {
      'name': 'Zara',
      'price': '\$45.00',
      'image': 'lib/assets/images/Clothes/Download_6.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchPage()),
                    ),
                    child: const Icon(Icons.search, color: Colors.black, size: 30),
                  ),
                ],
              ),
            ),

            // "Clothes" Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Clothes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Product Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProductCard(int index) {
    final product = _products[index];
    final isFirstCard = index == 0;
    return GestureDetector(
      onTap: isFirstCard
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductDescriptionPage(),
                ),
              )
          : null,
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area with heart icon
          Expanded(
            child: Stack(
              children: [
                // Product image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox.expand(
                    child: Image.asset(
                      product['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFE0F4F5),
                        child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                      ),
                    ),
                  ),
                ),
                // Heart icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _favourites[index] = !_favourites[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        _favourites[index] ? Icons.favorite : Icons.favorite_border,
                        color: _favourites[index] ? Colors.red : Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product name & price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  product['price']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E6C79),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),   // closes Container
    );   // closes GestureDetector
  }


  Widget _buildBottomNavBar() {
    return Container(
      height: 75,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4FB6B9),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF1E6C79), width: 2),
            ),
            child: const Icon(Icons.home_outlined, color: Colors.black, size: 30),
          ),

          // Notifications
          const Icon(Icons.notifications_none, color: Colors.black, size: 35),

          // User Profile
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF1E6C79), width: 2.5),
            ),
            child: const Icon(Icons.person, color: Colors.black, size: 30),
          ),
        ],
      ),
    );
  }
}
