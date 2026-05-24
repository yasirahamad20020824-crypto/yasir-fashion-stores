import 'package:flutter/material.dart';
import 'product_grid_page.dart';

class ShoesPage extends StatelessWidget {
  const ShoesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductGridPage(title: 'Shoes Collection', category: 'shoes');
  }
}
