import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'payment_page.dart';
import 'cart_service.dart';
import 'delivery_details_page.dart';

class ProductDescriptionPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDescriptionPage({super.key, required this.product});

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  int _selectedThumb = 0;
  int _selectedColor = 0;
  bool _isAddingToCart = false;

  late final List<String> _thumbImages;

  final List<Color> _colors = [
    const Color(0xFFB0A8D0), // lavender
    const Color(0xFFD9C8E0), // light purple
    const Color(0xFF2D3A5E), // navy
    const Color(0xFF7B8FA1), // slate blue
    const Color(0xFF6B7A5E), // olive
  ];

  @override
  void initState() {
    super.initState();
    final mainImage = widget.product['imageAsset'] ?? widget.product['image'] ?? '';
    // We try to provide 4 thumbnails. If we don't have them, we reuse the main image or category defaults.
    _thumbImages = [
      mainImage,
      'lib/assets/images/Product description/Download_1.jpg',
      'lib/assets/images/Product description/Download_2.jpg',
      'lib/assets/images/Product description/Download_3.jpg',
    ];
  }

  Future<void> _handleAddToCart() async {
    setState(() => _isAddingToCart = true);
    try {
      await CartService().addToCart(widget.product);
      // SnackBar removed as we now navigate directly to the Cart Page
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isAddingToCart = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.product['name'] ?? 'Product';
    final price = widget.product['price'] ?? 0.0;
    final mainImage = widget.product['imageAsset'] ?? widget.product['image'] ?? '';

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
                  ),
                  const Icon(Icons.search, color: Colors.black, size: 30),
                ],
              ),
            ),

            // ── Scrollable Body ──────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Hero Image Card ──────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: _buildProductImage(_thumbImages[_selectedThumb], isHero: true),
                            ),
                            Positioned(
                              right: 18,
                              bottom: 18,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '40%\nOff',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, height: 1.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Thumbnail Strip ──────────────────────────
                    SizedBox(
                      height: 68,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _thumbImages.length,
                        itemBuilder: (context, i) {
                          final isSelected = _selectedThumb == i;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedThumb = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: isSelected ? Colors.black : Colors.white.withOpacity(0.3), width: 2),
                                color: Colors.white.withOpacity(0.2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: _buildProductImage(_thumbImages[i], width: 62, height: 62),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ── Product Name & Price ─────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Tags Row (Matching Screenshot) ───────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 8, runSpacing: 8,
                        children: [
                          _buildTag('5 Pair Left', const Color(0xFFE8F5E9), Colors.green.shade700),
                          _buildTag('Sold 50', const Color(0xFFE3F2FD), Colors.blue.shade700),
                          _buildTag('⭐ 4.7 (69 Reviews)', const Color(0xFFFFF8E1), Colors.orange.shade700),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ── Select Color ─────────────────────────────
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Select Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: List.generate(_colors.length, (i) {
                          final isSelected = _selectedColor == i;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedColor = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              margin: const EdgeInsets.only(right: 12),
                              width: 38, height: 38,
                              decoration: BoxDecoration(
                                color: _colors[i],
                                shape: BoxShape.circle,
                                border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 2.5),
                                boxShadow: isSelected ? [BoxShadow(color: Colors.black26, blurRadius: 4)] : [],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ── Extra Detail Images (Bottom Boxes) ───────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(child: _buildDetailBox(mainImage)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildDetailBox(_thumbImages.length > 1 ? _thumbImages[1] : mainImage)), 
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Action Bar ────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.chat_bubble_outline, color: Colors.black87, size: 24),
                  ),
                  const SizedBox(width: 12),

                  // Add to Cart
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isAddingToCart ? null : () async {
                        await _handleAddToCart();
                        if (mounted) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1E6C79), width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _isAddingToCart 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF1E6C79)))
                        : const Text('Add to Cart', style: TextStyle(color: Color(0xFF1E6C79), fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Buy Now
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => DeliveryDetailsPage(
                            subtotal: price, 
                            discountPercent: 40,
                            items: [
                              {
                                'name': name,
                                'price': price,
                                'image': mainImage,
                                'qty': 1,
                              }
                            ],
                          )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FB6B9),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Buy Now', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildDetailBox(String imagePath) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _buildProductImage(imagePath),
      ),
    );
  }

  /// Renders a product image from either a local asset path or a network URL.
  Widget _buildProductImage(String imagePath, {double? width, double? height, bool isHero = false}) {
    final fallback = Container(
      width: width,
      height: height,
      color: const Color(0xFF3A9EA2).withOpacity(0.5),
      child: Icon(Icons.image, color: Colors.white70, size: isHero ? 60 : 24),
    );

    if (imagePath.isEmpty) return fallback;

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: const Color(0xFF3A9EA2).withOpacity(0.2),
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
          );
        },
      );
    }

    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
