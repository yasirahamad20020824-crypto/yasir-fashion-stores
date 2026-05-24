import 'package:flutter/material.dart';
import 'product_grid_page.dart';

class BeautyProductsPage extends StatelessWidget {
  const BeautyProductsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductGridPage(title: 'Beauty Products', category: 'beauty');
  }
}
