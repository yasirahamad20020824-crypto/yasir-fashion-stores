import 'package:flutter/material.dart';
import 'clothes_page.dart';
import 'shoes_page.dart';
import 'bage_page.dart';
import 'beautyproducts_page.dart';
import 'profile_page.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'settings_page.dart';
import 'favorites_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    'Bags',
                    'lib/assets/images/Categories/Download_2.jpg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BagePage()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCategoryCard(
                    context,
                    'Shoes',
                    'lib/assets/images/Categories/Download_3.jpg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ShoesPage()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCategoryCard(
                    context,
                    'Beauty Products',
                    'lib/assets/images/Categories/Download_4.jpg',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BeautyProductsPage()),
                    ),
                  ),
                  const SizedBox(height: 30),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = const Color(0xFF1E6C79),
                ),
              ),
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
      margin: const EdgeInsets.all(20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
    return GestureDetector(
      onTap: () {
        if (icon == Icons.home_outlined) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        } else if (icon == Icons.settings_outlined) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          );
        } else if (icon == Icons.favorite_border) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FavoritesPage()),
          );
        } else if (icon == Icons.person_outline) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 28,
        ),
      ),
    );
  }
}
