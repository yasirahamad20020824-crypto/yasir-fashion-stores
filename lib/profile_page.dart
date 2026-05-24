import 'package:flutter/material.dart';
import 'payment_page.dart';
import 'order_summary_page.dart';
import 'first_page.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'favorites_page.dart';
import 'order_history_page.dart';
import 'cart_service.dart';
import 'cart_page.dart';
import 'user_service.dart';
import 'edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showFeedback = false;
  final TextEditingController _feedbackController = TextEditingController();
  final CartService _cartService = CartService();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _navigateToOrderSummary() async {
    // Show a loading indicator while fetching current cart
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    try {
      final items = await _cartService.getCartItems().first;
      final subtotal = items.fold<double>(0, (sum, item) => sum + ((item['price'] ?? 0.0) * (item['qty'] ?? 1)));
      
      if (mounted) {
        Navigator.pop(context); // Remove loading
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderSummaryPage(items: items, subtotal: subtotal),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Remove loading
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
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
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
                    child: const Icon(Icons.settings_outlined, color: Colors.black, size: 26),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<Map<String, dynamic>?>(
              stream: UserService().getUserProfile(),
              builder: (context, snapshot) {
                final userData = snapshot.data;
                final name = userData?['name'] ?? FirebaseAuth.instance.currentUser?.displayName ?? 'M.N.Y.AHAMAD';
                final email = userData?['email'] ?? FirebaseAuth.instance.currentUser?.email ?? 'yasirahamad@gmail.com';

                return Column(
                  children: [
                    Container(
                      width: 110, height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'lib/assets/images/profile/Download_1.jpeg', fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const CircleAvatar(
                                radius: 55, backgroundColor: Color(0xFF1E6C79),
                                child: Icon(Icons.person, size: 60, color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0, bottom: 0,
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfilePage(userData: userData))),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                                child: const Icon(Icons.edit, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(name.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text(email, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _menuButton('Feedback', onTap: () => setState(() => _showFeedback = !_showFeedback)),
                    if (_showFeedback) ...[
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                              child: TextField(
                                controller: _feedbackController, maxLines: 4,
                                decoration: const InputDecoration(hintText: 'Write your feedback here...', border: InputBorder.none, contentPadding: EdgeInsets.all(14)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() { _showFeedback = false; _feedbackController.clear(); });
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you for your feedback!'), backgroundColor: Color(0xFF1E6C79)));
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E6C79), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                child: const Text('Submit Feedback', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    _menuButton('Payment Methods', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage(subtotal: 0, discountPercent: 0, items: [], deliveryDetails: {})))),
                    const SizedBox(height: 18),
                    _menuButton('My Orders', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryPage()))),
                    const SizedBox(height: 18),
                    _menuButton('Logout', onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const FirstPage()), (route) => false);
                      }
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _menuButton(String label, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3AACAF), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 0),
          child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20), height: 70,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavBarItem(Icons.home_outlined, context),
          _buildNavBarItem(Icons.settings_outlined, context),
          _buildNavBarItem(Icons.favorite_border, context),
          _buildNavBarItem(Icons.person_outline, context),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, BuildContext context) {
    final isActive = icon == Icons.person_outline;
    return GestureDetector(
      onTap: () {
        if (icon == Icons.home_outlined) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (route) => false);
        } else if (icon == Icons.settings_outlined) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
        } else if (icon == Icons.favorite_border) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: isActive ? const Color(0xFF4FB6B9) : Colors.transparent, shape: BoxShape.circle),
        child: Icon(icon, color: isActive ? Colors.white : Colors.black, size: 28),
      ),
    );
  }
}
