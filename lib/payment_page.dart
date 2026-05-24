import 'package:flutter/material.dart';
import 'order_confirmation_page.dart';
import 'card_payment_page.dart';
import 'instalment_page.dart';

class PaymentPage extends StatefulWidget {
  final double subtotal;
  final double discountPercent;
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> deliveryDetails;

  const PaymentPage({
    super.key,
    required this.subtotal,
    required this.discountPercent,
    required this.items,
    required this.deliveryDetails,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedMethod = -1;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'label': 'Credit / Debit Card',
      'images': ['lib/assets/images/payment/Download_1.png', 'lib/assets/images/payment/Download_2.png'],
    },
    {
      'label': 'Cash on Delivery',
      'images': ['lib/assets/images/payment/Download_3.png', 'lib/assets/images/payment/Download_4.png'],
    },
    {
      'label': 'Instalment',
      'images': ['lib/assets/images/payment/Download_5.png', 'lib/assets/images/payment/Download_6.png'],
    },
  ];

  double get _discountAmount => widget.subtotal * widget.discountPercent / 100;
  double get _totalAmount => widget.subtotal - _discountAmount;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
                  ),
                  const Icon(Icons.menu, color: Colors.black, size: 28),
                ],
              ),
            ),
            const Center(
              child: Text('Select Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) => _buildPaymentOption(index),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Column(
                children: [
                  _summaryRow('Subtotal', '\$${widget.subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 6),
                  _summaryRow('Discount', '${widget.discountPercent.toInt()}%'),
                  const SizedBox(height: 6),
                  _summaryRow('Total Amount', '\$${_totalAmount.toStringAsFixed(2)}', bold: true),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedMethod == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a payment method'), backgroundColor: Color(0xFF1E6C79)));
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmationPage(
                          items: widget.items,
                          subtotal: widget.subtotal,
                          deliveryDetails: widget.deliveryDetails,
                          paymentMethod: _paymentMethods[_selectedMethod]['label'],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2E35),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text('Pay Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(int index) {
    final method = _paymentMethods[index];
    final isSelected = _selectedMethod == index;
    final List<String> images = List<String>.from(method['images'] as List);
    return GestureDetector(
      onTap: () {
        setState(() => _selectedMethod = index);
        if (method['label'] == 'Credit / Debit Card') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardPaymentPage(
                subtotal: widget.subtotal,
                discountPercent: widget.discountPercent,
                items: widget.items,
                deliveryDetails: widget.deliveryDetails,
              ),
            ),
          );
        } else if (method['label'] == 'Instalment') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstalmentPage(
                subtotal: widget.subtotal,
                discountPercent: widget.discountPercent,
                items: widget.items,
                deliveryDetails: widget.deliveryDetails,
              ),
            ),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Expanded(child: Text(method['label'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black))),
            ...images.map((img) => Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Image.asset(img, width: 38, height: 28, fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(width: 38, height: 28, child: Icon(Icons.image, color: Colors.grey, size: 22))),
                )),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.black54, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: 14, color: bold ? Colors.black : Colors.black87, fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
