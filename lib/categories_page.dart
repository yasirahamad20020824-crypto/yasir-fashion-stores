import 'package:flutter/material.dart';
import 'clothes_page.dart';
import 'profile_page.dart';
import 'home_page.dart';
import 'search_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9), // Matching the app's teal theme
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchPage()),
                    ),
                    child: const Icon(Icons.search, color: Colors.black, size: 30),
                  ),
                ],
              ),
            ),

            // "Categories" Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // The List of Categories
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildCategoryCard(
                    context,
                    'Clothes',
                    'lib/assets/images/Categories/Download_1.png',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ClothesPage()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCategoryCard(
                    context,
                    'Bages',
                    'lib/assets/images/Categories/Download_2.jpg',
                  ),
                  const SizedBox(height: 15),
                  _buildCategoryCard(
                    context,
                    'Shoes',
                    'lib/assets/images/Categories/Download_3.jpg',
                  ),
                  const SizedBox(height: 15),
                  _buildCategoryCard(
                    context,
                    'Beauty products',
                    'lib/assets/images/Categories/Download_4.jpg',
                  ),
                  const SizedBox(height: 30), // Bottom padding
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imagePath,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              // Outline text
              Text(
                title,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = const Color(0xFF1E6C79), // Dark teal outline
                ),
              ),
              // Solid white text
              Text(
                title,
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home
          GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4FB6B9),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1E6C79), width: 2),
              ),
              child: const Icon(Icons.home_outlined, color: Colors.black, size: 30),
            ),
          ),

          // Notifications
          const Icon(Icons.notifications_none, color: Colors.black, size: 35),

          // User Profile
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1E6C79), width: 2.5),
              ),
              child: const Icon(Icons.person, color: Colors.black, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
