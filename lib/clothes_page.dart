import 'package:flutter/material.dart';
import 'product_grid_page.dart';

class ClothesPage extends StatelessWidget {
  final String title;
  const ClothesPage({super.key, this.title = 'Clothes'});
  @override
  Widget build(BuildContext context) {
    return ProductGridPage(title: title, category: 'clothes');
  }
}
