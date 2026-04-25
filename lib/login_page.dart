import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                const SizedBox(height: 50),
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Please login or sign up to continue our app',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                // Email field
                _buildField(label: 'Email'),
                const SizedBox(height: 20),
                // Password field
                _buildField(label: 'Password', isObscure: true, hasVisibilityIcon: true),
                const SizedBox(height: 40),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(child: Text('or', style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                // Social Buttons
                _socialButton(
                  icon: Icons.facebook,
                  text: 'Continue with Facebook',
                  color: const Color(0xFF3B5998),
                ),
                const SizedBox(height: 10),
                _socialButton(
                  icon: Icons.g_mobiledata, 
                  text: 'Continue with Google',
                  color: const Color(0xFF8DC6CD),
                  iconColor: Colors.black,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 10),
                _socialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                  color: const Color(0xFF8DC6CD),
                  iconColor: Colors.black,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 30),
                // Sign Up Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ", style: TextStyle(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupPage()),
                          );
                        },
                        child: const Text(
                          "Sign Up",
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
        labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        suffixIcon: hasVisibilityIcon ? const Icon(Icons.visibility_off, color: Colors.black) : null,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String text,
    required Color color,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
