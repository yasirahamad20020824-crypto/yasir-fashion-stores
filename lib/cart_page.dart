import 'package:flutter/material.dart';
import 'cart_service.dart';
import 'settings_page.dart';
import 'delivery_details_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}
// ... lines removed for brevity in replace_file_content logic but I'll specify target ...

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  static const double _deliveryFee = 5.00;
  static const double _discountPercent = 40;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _cartService.getCartItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            final cartItems = snapshot.data ?? [];
            final subtotal = cartItems.fold<double>(
              0,
              (sum, item) => sum + ((item['price'] as double) * ((item['qty'] as int?) ?? 1)),
            );

            return Column(
              children: [
                // ── Top Bar ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
                      ),
                      const Text(
                        'My Cart',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SettingsPage()),
                            ),
                            child: const Icon(Icons.settings_outlined, color: Colors.black, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.search, color: Colors.black, size: 28),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Cart Items List ───────────────────────────────────
                Expanded(
                  child: cartItems.isEmpty
                      ? _buildEmptyCart()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) => _buildCartCard(cartItems[index]),
                        ),
                ),

                // ── Summary & Checkout ───────────────────────────────
                if (cartItems.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFF4FB6B9),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _summaryRow(
                          'Sub Total (${cartItems.length} item${cartItems.length == 1 ? '' : 's'}):',
                          '\$${subtotal.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 6),
                        _summaryRow('Delivery Fee:', '\$${_deliveryFee.toStringAsFixed(2)}'),
                        const SizedBox(height: 6),
                        _summaryRow('Discount:', '${_discountPercent.toInt()}%'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.black26, thickness: 1),
                        ),
                        _summaryRow(
                          'Total:',
                          '\$${(subtotal + _deliveryFee - subtotal * _discountPercent / 100).toStringAsFixed(2)}',
                          bold: true,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DeliveryDetailsPage(
                                  subtotal: subtotal,
                                  discountPercent: _discountPercent,
                                  items: cartItems,
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.black, size: 22),
                            label: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3AACAF),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: Colors.black26, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Empty state ──────────────────────────────────────────────────────────
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.black.withOpacity(0.3)),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add some items to get started!',
            style: TextStyle(fontSize: 14, color: Colors.black38),
          ),
        ],
      ),
    );
  }

  // ── Cart Item Card ───────────────────────────────────────────────────────
  Widget _buildCartCard(Map<String, dynamic> item) {
    final String docId = item['id'] as String;
    final int qty = (item['qty'] as int?) ?? 1;
    final double price = (item['price'] as double?) ?? 0.0;
    final String imagePath = (item['image'] as String?) ?? '';
    final String name = (item['name'] as String?) ?? 'Product';

    return Dismissible(
      key: Key(docId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (_) => _cartService.removeFromCart(docId),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF5DC9CC),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            // ── Product Image ────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildProductImage(imagePath),
            ),
            const SizedBox(width: 12),

            // ── Name & Price ─────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total: \$${(price * qty).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // ── Qty Controls & Remove ────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _cartService.removeFromCart(docId),
                  child: const Icon(Icons.close, size: 18, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _qtyButton(
                      icon: Icons.remove,
                      onTap: () => _cartService.updateQuantity(docId, qty - 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('$qty', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    _qtyButton(
                      icon: Icons.add,
                      onTap: () => _cartService.updateQuantity(docId, qty + 1),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Renders a product image from either a local asset path or a network URL.
  Widget _buildProductImage(String imagePath) {
    const double size = 72;
    final fallback = Container(
      width: size,
      height: size,
      color: const Color(0xFF3AACAF),
      child: const Icon(Icons.image, color: Colors.white60, size: 32),
    );

    if (imagePath.isEmpty) return fallback;

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size,
            height: size,
            color: const Color(0xFF3AACAF),
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
          );
        },
      );
    }

    return Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3)],
        ),
        child: Icon(icon, size: 16, color: Colors.black87),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
