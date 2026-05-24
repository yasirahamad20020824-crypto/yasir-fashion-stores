import 'package:flutter/material.dart';
import 'firestore_seeder.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'profile_page.dart';
import 'theme_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _seeding = false;
  bool _seeded = false;

  @override
  void initState() {
    super.initState();
    _checkSeeded();
  }

  Future<void> _checkSeeded() async {
    final seeded = await FirestoreSeeder.isSeeded();
    if (mounted) setState(() => _seeded = seeded);
  }

  Future<void> _seedProducts() async {
    setState(() => _seeding = true);
    try {
      await FirestoreSeeder.seedAll();
      if (mounted) {
        setState(() {
          _seeded = true;
          _seeding = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ All products seeded to Firestore successfully!'),
            backgroundColor: Color(0xFF1E6C79),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _seeding = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Seeding failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF121212) : const Color(0xFF4FB6B9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, size: 24),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _sectionTitle('App Settings'),
                  _buildCard(
                    child: Column(
                      children: [
                        _switchTile(
                          icon: Icons.notifications_outlined,
                          title: 'Push Notifications',
                          subtitle: 'Get updates on orders & offers',
                          value: _notificationsEnabled,
                          onChanged: (v) => setState(() => _notificationsEnabled = v),
                        ),
                        const Divider(height: 1, indent: 56),
                        _switchTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          subtitle: 'Toggle dark appearance',
                          value: ThemeManager.themeMode.value == ThemeMode.dark,
                          onChanged: (v) {
                            ThemeManager.toggleTheme(v);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  _sectionTitle('Data & Firebase'),
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                          child: Row(
                            children: [
                              const Icon(Icons.cloud_upload_outlined, color: Color(0xFF1E6C79), size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Seed Products to Firestore',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black)),
                                    const Text('Upload all product data once',
                                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                                  ],
                                ),
                              ),
                              if (_seeded)
                                const Icon(Icons.check_circle, color: Colors.green, size: 22)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _seeding ? null : _seedProducts,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E6C79),
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: Colors.grey.shade300,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              icon: _seeding
                                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : const Icon(Icons.sync),
                              label: Text(_seeding ? 'Syncing...' : 'Sync Latest Products'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  _sectionTitle('About'),
                  _buildCard(
                    child: Column(
                      children: [
                        _infoTile(Icons.store_outlined, 'App Name', 'Yasir Fashion Stores'),
                        const Divider(height: 1, indent: 56),
                        _infoTile(Icons.info_outline, 'Version', '1.0.0'),
                      ],
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: child,
    );
  }

  Widget _switchTile({required IconData icon, required String title, required String subtitle, required bool value, required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      secondary: Icon(icon, color: const Color(0xFF1E6C79)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: const Color(0xFF1E6C79),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1E6C79)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
      trailing: Text(value, style: const TextStyle(color: Colors.black54, fontSize: 14)),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_outlined, context),
          _buildNavItem(Icons.settings_outlined, context),
          _buildNavItem(Icons.favorite_border, context),
          _buildNavItem(Icons.person_outline, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, BuildContext context) {
    final isActive = icon == Icons.settings_outlined;
    return GestureDetector(
      onTap: () {
        if (icon == Icons.home_outlined) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (r) => false);
        } else if (icon == Icons.favorite_border) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
        } else if (icon == Icons.person_outline) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4FB6B9) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isActive ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black), size: 28),
      ),
    );
  }
}
