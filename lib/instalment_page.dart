import 'package:flutter/material.dart';
import 'order_confirmation_page.dart';

class InstalmentPage extends StatelessWidget {
  final double subtotal;
  final double discountPercent;
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> deliveryDetails;

  const InstalmentPage({
    super.key,
    required this.subtotal,
    required this.discountPercent,
    required this.items,
    required this.deliveryDetails,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double discountAmount = subtotal * discountPercent / 100;
    final double totalAmount = subtotal - discountAmount;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      appBar: AppBar(
        title: const Text('Instalment Options', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose your instalment plan:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildPlanCard(context, '3 Months', totalAmount / 3),
            _buildPlanCard(context, '6 Months', totalAmount / 6),
            _buildPlanCard(context, '12 Months', totalAmount / 12),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A2E35),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Confirm Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String duration, double monthly) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrderConfirmationPage(
              items: items,
              subtotal: subtotal,
              deliveryDetails: deliveryDetails,
              paymentMethod: 'Instalment ($duration)',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(duration, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('\$${monthly.toStringAsFixed(2)} / month', style: const TextStyle(fontSize: 16, color: Color(0xFF1E6C79))),
          ],
        ),
      ),
    );
  }
}
