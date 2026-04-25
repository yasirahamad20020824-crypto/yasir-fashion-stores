import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'order_summary_page.dart';
import 'home_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ─────────────────────────────────────────────
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
                  const Icon(Icons.menu, color: Colors.black, size: 28),
                ],
              ),
            ),

            // ── Spacer to push content to center ────────────────────
            const Spacer(),

            // ── Confirmation Image ───────────────────────────────────
            Image.asset(
              'lib/assets/images/order confirmation/download (42).png',
              width: 160,
              height: 160,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 6),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 90,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── ORDER COMPLETED! ─────────────────────────────────────
            const Text(
              'ORDER COMPLETED!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.2,
              ),
            ),

            const Spacer(),

            // ── View Order Button ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderSummaryPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A8E91),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'View Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom Navigation Bar ────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF4FB6B9),
                border: Border(
                  top: BorderSide(color: Colors.black12, width: 0.5),
                ),
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
      child: Icon(
        icon,
        color: filled ? Colors.white : Colors.black,
        size: 26,
      ),
    );
  }
}
