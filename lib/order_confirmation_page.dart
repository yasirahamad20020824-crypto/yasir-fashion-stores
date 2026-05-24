import 'package:flutter/material.dart';
import 'cart_service.dart';
import 'profile_page.dart';
import 'order_summary_page.dart';
import 'home_page.dart';
import 'order_service.dart';

class OrderConfirmationPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final Map<String, dynamic> deliveryDetails;
  final String paymentMethod;

  const OrderConfirmationPage({
    super.key,
    required this.items,
    required this.subtotal,
    required this.deliveryDetails,
    required this.paymentMethod,
  });

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // ── Place order in Firestore ──────────────────────────────────────────
    _placeOrder();

    // ── Success animation ─────────────────────────────────────────────────
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    _animController.forward();
  }

  Future<void> _placeOrder() async {
    try {
      // 1. Save order to Firestore
      await OrderService().placeOrder(
        items: widget.items,
        subtotal: widget.subtotal,
        total: widget.subtotal + 5.0, // Assuming 5.0 delivery fee
        deliveryDetails: widget.deliveryDetails,
        paymentMethod: widget.paymentMethod,
      );

      // 2. Clear the cart in Firestore
      await CartService().clearCart();
    } catch (e) {
      debugPrint('Error placing order: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save order: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────────────────────
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

            const Spacer(),

            // ── Success Icon ─────────────────────────────────────────
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'lib/assets/images/order confirmation/download (42).png',
                width: 160,
                height: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 6),
                    color: Colors.green.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.check, color: Colors.green, size: 90),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'ORDER COMPLETED!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your order has been placed successfully.\nYour cart has been cleared.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const Spacer(),

            // ── View Order Button ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderSummaryPage(
                          items: widget.items,
                          subtotal: widget.subtotal,
                          deliveryDetails: widget.deliveryDetails,
                          paidBy: widget.paymentMethod,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A8E91),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text('View Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),

            // ── Bottom Nav ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF4FB6B9),
                border: Border(top: BorderSide(color: Colors.black12, width: 0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    ),
                    child: _navIcon(Icons.home, filled: true),
                  ),
                  _navIcon(Icons.notifications_none),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    ),
                    child: _navIcon(Icons.person_outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, {bool filled = false}) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: filled ? Colors.black87 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: filled ? Colors.white : Colors.black, size: 26),
    );
  }
}
