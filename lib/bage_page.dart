import 'package:flutter/material.dart';
import 'product_grid_page.dart';

class BagePage extends StatelessWidget {
  const BagePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductGridPage(title: 'Bags Collection', category: 'bags');
  }
}
