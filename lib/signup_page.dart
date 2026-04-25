import 'package:flutter/material.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FB6B9), // Teal background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'YASIR',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'FASHION STORES',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Create a new account to get started',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                // Fields
                _buildField(label: 'Full Name'),
                const SizedBox(height: 15),
                _buildField(label: 'Email Address'),
                const SizedBox(height: 15),
                _buildField(label: 'Password', isObscure: true, hasVisibilityIcon: true),
                const SizedBox(height: 15),
                _buildField(label: 'Confirm Password', isObscure: true, hasVisibilityIcon: true),
                const SizedBox(height: 25),
                // Checkbox
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: false,
                        onChanged: (val) {},
                        side: const BorderSide(color: Colors.black),
                        activeColor: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'By creating an account, you agree with our terms & conditions.',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 15),
                const Center(child: Text('or sign up with', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                const SizedBox(height: 15),
                // Social Buttons
                Row(
                  children: [
                    Expanded(
                      child: _smallSocialButton(
                        icon: Icons.facebook,
                        color: const Color(0xFF3B5998),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _smallSocialButton(
                        icon: Icons.g_mobiledata,
                        color: const Color(0xFF8DC6CD),
                        iconColor: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _smallSocialButton(
                        icon: Icons.apple,
                        color: const Color(0xFF8DC6CD),
                        iconColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Login Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ", style: TextStyle(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, bool isObscure = false, bool hasVisibilityIcon = false}) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        suffixIcon: hasVisibilityIcon ? const Icon(Icons.visibility_off, color: Colors.black, size: 20) : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }

  Widget _smallSocialButton({
    required IconData icon,
    required Color color,
    Color iconColor = Colors.white,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: iconColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, color: iconColor, size: 30),
      ),
    );
  }
}
