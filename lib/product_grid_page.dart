import 'package:flutter/material.dart';
import 'product_service.dart';
import 'search_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'favorites_page.dart';
import 'product_description_page.dart';
import 'favorite_service.dart';
import 'cart_service.dart';
import 'cart_page.dart';

class ProductGridPage extends StatefulWidget {
  final String title;
  final String category;

  const ProductGridPage({super.key, required this.title, required this.category});

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  late Future<List<Map<String, dynamic>>> _productsFuture;
  final FavoriteService _favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService().fetchProducts(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
                  ),
                  Text(widget.title.toUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.black)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
                        child: const Icon(Icons.settings_outlined, color: Colors.black, size: 26),
                      ),
                      const SizedBox(width: 12),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
                            child: const Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 26),
                          ),
                          StreamBuilder<int>(
                            stream: CartService().getCartItemCount(),
                            builder: (context, snapshot) {
                              final count = snapshot.data ?? 0;
                              if (count == 0) return const SizedBox.shrink();
                              return Positioned(
                                right: -5,
                                top: -5,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage())),
                        child: const Icon(Icons.search, color: Colors.black, size: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF1E6C79)));
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading products'));
                  }

                  final products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Center(child: Text('No products found.\nGo to Settings → Seed Products.', textAlign: TextAlign.center));
                  }

                  return StreamBuilder<Set<String>>(
                    stream: _favoriteService.getFavoriteNames(),
                    builder: (context, favSnapshot) {
                      final favorites = favSnapshot.data ?? {};
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.72,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final isFav = favorites.contains(product['name']);
                          return _buildProductCard(product, isFav);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, bool isFav) {
    final imagePath = product['imageAsset'] ?? product['image'] ?? '';
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDescriptionPage(product: product))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: SizedBox.expand(
                      child: _buildProductImage(imagePath),
                    ),
                  ),
                  Positioned(
                    top: 8, right: 8,
                    child: GestureDetector(
                      onTap: () => _favoriteService.toggleFavorite(product),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.85), shape: BoxShape.circle),
                        child: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.black, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'] ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('\$${(product['price'] ?? 0.0).toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E6C79))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20), height: 70,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.home_outlined, context),
          _navItem(Icons.settings_outlined, context),
          _navItem(Icons.favorite_border, context),
          _navItem(Icons.person_outline, context),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (icon == Icons.home_outlined) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (r) => false);
        } else if (icon == Icons.settings_outlined) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        } else if (icon == Icons.favorite_border) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
        } else if (icon == Icons.person_outline) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        }
      },
      child: Container(padding: const EdgeInsets.all(10), child: Icon(icon, color: Colors.black, size: 28)),
    );
  }

  /// Renders a product image from either a local asset path or a network URL.
  Widget _buildProductImage(String imagePath) {
    final fallback = Container(
      color: const Color(0xFFE0F4F5),
      child: const Icon(Icons.image, color: Colors.grey, size: 40),
    );

    if (imagePath.isEmpty) return fallback;

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFFE0F4F5),
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF1E6C79))),
          );
        },
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
