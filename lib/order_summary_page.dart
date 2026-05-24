import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'home_page.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final Map<String, dynamic>? deliveryDetails;
  final String? orderNo;
  final String? placedOn;
  final String? paidBy;

  const OrderSummaryPage({
    super.key,
    required this.items,
    required this.subtotal,
    this.deliveryDetails,
    this.orderNo,
    this.placedOn,
    this.paidBy,
  });

  static const double _deliveryFee = 5.00;
  double get _total => subtotal + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFE0F7F8),
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
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Order Summary',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.black, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deliveryDetails != null 
                                      ? '${deliveryDetails!['name']}  ${deliveryDetails!['phone']}'
                                      : 'M.N.Y.Ahamad  0112455448',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  deliveryDetails != null
                                      ? '${deliveryDetails!['address']}, ${deliveryDetails!['city']}'
                                      : '34/45 , Main Street , Colombo',
                                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Order Items ──────────────────────────────────────
                    Container(
                      color: const Color(0xFF3AACAF),
                      child: Column(
                        children: items.map((item) => _buildItemRow(item)).toList(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Price Summary ────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        children: [
                          _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                          const SizedBox(height: 6),
                          _summaryRow('Delivery Fee', '\$${_deliveryFee.toStringAsFixed(2)}'),
                          const SizedBox(height: 6),
                          _summaryRow('Total', '\$${_total.toStringAsFixed(2)}', bold: true),
                          const Divider(height: 20, color: Colors.black26),
                          _summaryRow('Order No', orderNo ?? '98736453632221'),
                          const SizedBox(height: 6),
                          _summaryRow('Placed On', placedOn ?? '10 May 2026  14:22:15'),
                          const SizedBox(height: 6),
                          _summaryRow('Paid by', paidBy ?? 'Debit Card'),
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
                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (route) => false),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: const Color(0xFF4FB6B9), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF1E6C79), width: 2)),
                      child: const Icon(Icons.home_outlined, color: Colors.black, size: 30),
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.black, size: 35),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF1E6C79), width: 2.5)),
                      child: const Icon(Icons.person, color: Colors.black, size: 30),
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
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item['image'].startsWith('http')
                ? Image.network(
                    item['image'] as String,
                    width: 56, height: 56, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(width: 56, height: 56, color: const Color(0xFF4FB6B9), child: const Icon(Icons.image, color: Colors.white60, size: 28)),
                  )
                : Image.asset(
                    item['image'] as String,
                    width: 56, height: 56, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(width: 56, height: 56, color: const Color(0xFF4FB6B9), child: const Icon(Icons.image, color: Colors.white60, size: 28)),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
                const SizedBox(height: 4),
                Text('\$${(item['price'] as double).toStringAsFixed(2)}', style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),
          ),
          Text('Qty ${item['qty']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
