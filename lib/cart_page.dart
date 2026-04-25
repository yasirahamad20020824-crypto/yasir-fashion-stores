import 'package:flutter/material.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Cart items with image, name, unit price, quantity
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Roller Rabbit',
      'price': 198.00,
      'image': 'lib/assets/images/cart/Download_1.jpg',
      'qty': 1,
    },
    {
      'name': 'Axel Arigato',
      'price': 245.00,
      'image': 'lib/assets/images/cart/Download_2.png',
      'qty': 1,
    },
    {
      'name': 'Herschel Supply Co.',
      'price': 40.00,
      'image': 'lib/assets/images/cart/Download_3.png',
      'qty': 1,
    },
  ];

  static const double _deliveryFee = 5.00;
  static const double _discountPercent = 40;

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item['price'] * item['qty']);

  void _increment(int index) => setState(() => _cartItems[index]['qty']++);

  void _decrement(int index) {
    if (_cartItems[index]['qty'] > 1) {
      setState(() => _cartItems[index]['qty']--);
    }
  }

  void _remove(int index) => setState(() => _cartItems.removeAt(index));

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
                        color: Colors.black, size: 22),
                  ),
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.black, size: 28),
                ],
              ),
            ),

            // ── Cart Items List ───────────────────────────────────
            Expanded(
              child: _cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) =>
                          _buildCartCard(index),
                    ),
            ),

            // ── Summary & Checkout ───────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              decoration: const BoxDecoration(
                color: Color(0xFF4FB6B9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _summaryRow(
                      'Sub Total (${_cartItems.length} item):',
                      '\$${_subtotal.toStringAsFixed(2)}',
                      bold: false),
                  const SizedBox(height: 6),
                  _summaryRow('Delivery Fee:',
                      '\$${_deliveryFee.toStringAsFixed(2)}',
                      bold: false),
                  const SizedBox(height: 6),
                  _summaryRow('Discount:',
                      '${_discountPercent.toInt()}%',
                      bold: false),
                  const SizedBox(height: 16),

                  // Proceed to Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentPage(
                            subtotal: _subtotal,
                            discountPercent: _discountPercent,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_circle_right_outlined,
                          color: Colors.black, size: 22),
                      label: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3AACAF),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                              color: Colors.black26, width: 1),
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

  Widget _buildCartCard(int index) {
    final item = _cartItems[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF5DC9CC),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item['image'],
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 72,
                color: const Color(0xFF3AACAF),
                child: const Icon(Icons.image, color: Colors.white60, size: 32),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name & price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${(item['price'] as double).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ✕ remove button
              GestureDetector(
                onTap: () => _remove(index),
                child: const Icon(Icons.close, size: 18, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              // − qty + controls
              Row(
                children: [
                  _qtyButton(
                    icon: Icons.remove,
                    onTap: () => _decrement(index),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item['qty']}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _qtyButton(
                    icon: Icons.add,
                    onTap: () => _increment(index),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Icon(icon, size: 16, color: Colors.black87),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            )),
        Text(value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            )),
      ],
    );
  }
}
