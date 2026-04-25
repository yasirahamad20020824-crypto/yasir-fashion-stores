import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'payment_page.dart';

class ProductDescriptionPage extends StatefulWidget {
  const ProductDescriptionPage({super.key});

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  int _selectedThumb = 0;
  int _selectedColor = 0;

  // Thumbnail images (shown in the strip below the hero)
  final List<String> _thumbImages = [
    'lib/assets/images/Product description/Download_1.jpg',
    'lib/assets/images/Product description/Download_2.jpg',
    'lib/assets/images/Product description/Download_3.jpg',
    'lib/assets/images/Product description/Download_4.jpg',
  ];

  // Extra images shown elsewhere (Download_5, Download_6)
  final List<String> _extraImages = [
    'lib/assets/images/Product description/Download_5.jpg',
    'lib/assets/images/Product description/Download_6.png',
  ];

  final List<Color> _colors = [
    const Color(0xFFB0A8D0), // lavender
    const Color(0xFFD9C8E0), // light purple
    const Color(0xFF2D3A5E), // navy
    const Color(0xFF7B8FA1), // slate blue
    const Color(0xFF6B7A5E), // olive
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9),
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
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black, size: 24),
                  ),
                  const Icon(Icons.search, color: Colors.black, size: 30),
                ],
              ),
            ),

            // ── Scrollable body ──────────────────────────────────
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
                            // Hero image (changes with thumbnail selection)
                            SizedBox(
                              height: 230,
                              width: double.infinity,
                              child: Image.asset(
                                _thumbImages[_selectedThumb],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFF3A9EA2),
                                  child: const Icon(Icons.image,
                                      color: Colors.white70, size: 60),
                                ),
                              ),
                            ),
                            // 40% Off badge
                            Positioned(
                              right: 18,
                              bottom: 18,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.55),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '40%\nOff',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                  ),
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
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.18),
                                          blurRadius: 6,
                                        )
                                      ]
                                    : [],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  _thumbImages[i],
                                  width: 62,
                                  height: 62,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 62,
                                    height: 62,
                                    color: const Color(0xFFB2DFE1),
                                    child: const Icon(Icons.image,
                                        color: Colors.white60, size: 28),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ── Product Name & Price ─────────────────────
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Roller Rabbit',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        '\$198.00',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Tags Row ─────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildTag('5 Pair Left',
                              const Color(0xFFE8F5E9), Colors.green.shade700),
                          _buildTag('Sold 50',
                              const Color(0xFFE3F2FD), Colors.blue.shade700),
                          _buildTag('⭐ 4.7 (69 Reviews)',
                              const Color(0xFFFFF8E1), Colors.orange.shade700),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Select Color ─────────────────────────────
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Select Color',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: List.generate(_colors.length, (i) {
                          final isSelected = _selectedColor == i;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedColor = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              margin: const EdgeInsets.only(right: 12),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _colors[i],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.2),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        )
                                      ]
                                    : [],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ── Extra preview images ─────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: _extraImages.map((img) {
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  img,
                                  height: 130,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 130,
                                    color: const Color(0xFFB2DFE1),
                                    child: const Icon(Icons.image,
                                        color: Colors.white60, size: 36),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Action Bar ────────────────────────────────
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Chat icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.chat_bubble_outline,
                        color: Colors.black87, size: 24),
                  ),
                  const SizedBox(width: 10),

                  // Add to Cart button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF1E6C79), width: 1.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Color(0xFF1E6C79),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Buy Now button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentPage(
                            subtotal: 500.00,
                            discountPercent: 40,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FB6B9),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
