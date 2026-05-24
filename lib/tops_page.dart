import 'package:flutter/material.dart';
import 'product_grid_page.dart';

class TopsPage extends StatelessWidget {
  const TopsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const ProductGridPage(title: 'Tops Collection', category: 'tops');
  }
}
