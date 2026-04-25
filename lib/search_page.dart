import 'package:flutter/material.dart';
import 'clothes_page.dart';
import 'categories_page.dart';
import 'product_description_page.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _allItems = [
    // Products
    {
      'name': 'Roller Rabbit',
      'subtitle': 'Clothes · \$198.00',
      'image': 'lib/assets/images/Clothes/Download_1.jpg',
      'type': 'product',
      'category': 'Clothes',
    },
    {
      'name': 'Endless Rose',
      'subtitle': 'Clothes · \$50.00',
      'image': 'lib/assets/images/Clothes/Download_2.png',
      'type': 'product',
      'category': 'Clothes',
    },
    {
      'name': 'Theory',
      'subtitle': 'Clothes · \$345.00',
      'image': 'lib/assets/images/Clothes/Download_3.png',
      'type': 'product',
      'category': 'Clothes',
    },
    {
      'name': 'Madewell',
      'subtitle': 'Clothes · \$69.50',
      'image': 'lib/assets/images/Clothes/Download_4.png',
      'type': 'product',
      'category': 'Clothes',
    },
    {
      'name': 'House of CB',
      'subtitle': 'Clothes · \$120.00',
      'image': 'lib/assets/images/Clothes/Download_5.png',
      'type': 'product',
      'category': 'Clothes',
    },
    {
      'name': 'Zara',
      'subtitle': 'Clothes · \$45.00',
      'image': 'lib/assets/images/Clothes/Download_6.png',
      'type': 'product',
      'category': 'Clothes',
    },
    // Categories
    {
      'name': 'Clothes',
      'subtitle': 'Category',
      'image': 'lib/assets/images/Categories/Download_1.png',
      'type': 'category',
    },
    {
      'name': 'Bags',
      'subtitle': 'Category',
      'image': 'lib/assets/images/Categories/Download_2.jpg',
      'type': 'category',
    },
    {
      'name': 'Shoes',
      'subtitle': 'Category',
      'image': 'lib/assets/images/Categories/Download_3.jpg',
      'type': 'category',
    },
    {
      'name': 'Beauty Products',
      'subtitle': 'Category',
      'image': 'lib/assets/images/Categories/Download_4.jpg',
      'type': 'category',
    },
  ];

  List<Map<String, dynamic>> _filteredItems = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = [];

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();

    _searchController.addListener(() {
      final query = _searchController.text.trim().toLowerCase();
      setState(() {
        _hasSearched = query.isNotEmpty;
        if (query.isEmpty) {
          _filteredItems = [];
        } else {
          _filteredItems = _allItems
              .where((item) =>
                  item['name'].toString().toLowerCase().contains(query) ||
                  item['subtitle'].toString().toLowerCase().contains(query))
              .toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTap(Map<String, dynamic> item) {
    if (item['type'] == 'product' && item['name'] == 'Roller Rabbit') {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ProductDescriptionPage()));
    } else if (item['type'] == 'category' && item['name'] == 'Clothes') {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ClothesPage()));
    } else if (item['type'] == 'category') {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const CategoriesPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // ── Search Bar Header ──
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4FB6B9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.black, size: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Search TextField
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            autofocus: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search products, categories…',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 14),
                              prefixIcon: const Icon(Icons.search,
                                  color: Color(0xFF4FB6B9), size: 22),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                      },
                                      child: const Icon(Icons.close,
                                          color: Colors.black45, size: 20),
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Body ──
            Expanded(
              child: _hasSearched
                  ? _filteredItems.isEmpty
                      ? _buildNoResults()
                      : _buildResultsList()
                  : _buildInitialState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFF4FB6B9).withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_rounded,
                size: 64, color: Color(0xFF4FB6B9)),
          ),
          const SizedBox(height: 22),
          const Text(
            'Search anything',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Find products, clothes, shoes,\nbags and beauty items',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.45),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 36),
          // Quick suggestions
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: ['Clothes', 'Shoes', 'Zara', 'Bags', 'Beauty']
                .map((suggestion) => GestureDetector(
                      onTap: () {
                        _searchController.text = suggestion;
                        _searchController.selection =
                            TextSelection.collapsed(offset: suggestion.length);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF4FB6B9), width: 1.2),
                        ),
                        child: Text(
                          suggestion,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF1E6C79),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.search_off, size: 60, color: Colors.black38),
          ),
          const SizedBox(height: 20),
          const Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different keyword',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        final isCategory = item['type'] == 'category';

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 200 + index * 60),
          curve: Curves.easeOut,
          builder: (context, value, child) => Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          ),
          child: GestureDetector(
            onTap: () => _onItemTap(item),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.asset(
                      item['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: const Color(0xFFE0F4F5),
                        child: const Icon(Icons.image_not_supported,
                            color: Colors.grey, size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Text info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['subtitle'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tag badge
                  Container(
                    margin: const EdgeInsets.only(right: 14),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCategory
                          ? const Color(0xFF4FB6B9).withOpacity(0.15)
                          : const Color(0xFF1E6C79).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isCategory ? 'Category' : 'Product',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isCategory
                            ? const Color(0xFF4FB6B9)
                            : const Color(0xFF1E6C79),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
