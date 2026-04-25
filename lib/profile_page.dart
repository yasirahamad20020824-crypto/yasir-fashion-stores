import 'package:flutter/material.dart';
import 'payment_page.dart';
import 'order_summary_page.dart';
import 'first_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showFeedback = false;
  final TextEditingController _feedbackController = TextEditingController();
  bool _feedbackSubmitted = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ─────────────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.black, size: 22),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Profile Picture ──────────────────────────────────────
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'lib/assets/images/profile/Download_1.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xFF1E6C79),
                    child:
                        Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Name ─────────────────────────────────────────────────
            const Text(
              'M.N.Y.AHAMAD',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 4),

            // ── Email ────────────────────────────────────────────────
            const Text(
              'yasirahamad@gmail.com',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // ── Menu Buttons + Feedback Form ─────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Feedback button
                    _menuButton(
                      'Feedback',
                      onTap: () =>
                          setState(() => _showFeedback = !_showFeedback),
                    ),

                    // Inline feedback form
                    if (_showFeedback) ...[
                      const SizedBox(height: 12),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: TextField(
                                controller: _feedbackController,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Write your feedback here...',
                                  hintStyle:
                                      TextStyle(color: Colors.black38),
                                  contentPadding: EdgeInsets.all(14),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _feedbackSubmitted = true;
                                    _showFeedback = false;
                                    _feedbackController.clear();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Thank you for your feedback!'),
                                      backgroundColor:
                                          Color(0xFF1E6C79),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF1E6C79),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Submit Feedback',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 18),

                    // Payment button
                    _menuButton(
                      'Payment',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentPage(
                            subtotal: 483.00,
                            discountPercent: 40,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Order Summary button
                    _menuButton(
                      'Order Summary',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OrderSummaryPage()),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Logout button
                    _menuButton(
                      'Logout',
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FirstPage()),
                        (route) => false,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Bottom Navigation Bar ─────────────────────────────────
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
                  // Profile — already here
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFF1E6C79), width: 2.5),
                    ),
                    child:
                        const Icon(Icons.person, color: Colors.black, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(String label, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3AACAF),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
