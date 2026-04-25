import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'home_page.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  // Same cart items as CartPage
  static const List<Map<String, dynamic>> _items = [
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
  static const double _subtotal = 198.00 + 245.00 + 40.00; // 483 → shown as 500 in mockup
  static const double _total = _subtotal + _deliveryFee;
  static const double _debitCard = 205.00;
  static const String _orderNo = '98736453632221';
  static const String _placedOn = '05 Apr 2026  12:34:02';
  static const String _paidBy = 'Debit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────────────────────
            Container(
              color: const Color(0xFFE0F7F8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black, size: 22),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 22), // balance the back icon
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Delivery Address ─────────────────────────────────
                    Container(
                      width: double.infinity,
                      color: const Color(0xFF4FB6B9),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.black, size: 18),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'M.N.Y.Ahamad  0112455448',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '34/45 , Main Street , Colombo',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ── Order Items ──────────────────────────────────────
                    Container(
                      color: const Color(0xFF3AACAF),
                      child: Column(
                        children: _items
                            .map((item) => _buildItemRow(item))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Price Summary ────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Column(
                        children: [
                          _summaryRow('Subtotal',
                              '\$${_subtotal.toStringAsFixed(2)}'),
                          const SizedBox(height: 6),
                          _summaryRow('Delivery Fee',
                              '\$${_deliveryFee.toStringAsFixed(2)}'),
                          const SizedBox(height: 6),
                          _summaryRow(
                              'Total', '\$${_total.toStringAsFixed(2)}'),
                          const SizedBox(height: 6),
                          _summaryRow('Debit Card',
                              '\$${_debitCard.toStringAsFixed(2)}'),
                          const Divider(height: 20, color: Colors.black26),
                          _summaryRow('Order No', _orderNo),
                          const SizedBox(height: 6),
                          _summaryRow('Placed On', _placedOn),
                          const SizedBox(height: 6),
                          _summaryRow('Paid by', _paidBy),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Bottom Navigation Bar ────────────────────────────────
            Container(
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home
                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomePage()),
                      (route) => false,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4FB6B9),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF1E6C79), width: 2),
                      ),
                      child: const Icon(Icons.home_outlined,
                          color: Colors.black, size: 30),
                    ),
                  ),
                  // Notifications
                  const Icon(Icons.notifications_none,
                      color: Colors.black, size: 35),
                  // Profile
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ProfilePage()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF1E6C79), width: 2.5),
                      ),
                      child: const Icon(Icons.person,
                          color: Colors.black, size: 30),
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

  Widget _buildItemRow(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Item image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item['image'] as String,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                color: const Color(0xFF4FB6B9),
                child: const Icon(Icons.image,
                    color: Colors.white60, size: 28),
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
                  item['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${(item['price'] as double).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Qty
          Text(
            'Qty ${item['qty']}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
        Text(value,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
