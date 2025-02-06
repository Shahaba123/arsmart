import 'package:arsmart/admin/forgot.dart'; // Admin Forgot Password Page
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Admin Login Successful ✅")),
        );
        // Navigate to the Admin Dashboard (Replace with your route)
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboardScreen()));
      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No admin found with this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect admin password.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  void _forgotPassword() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        ));
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter your email to reset password.")),
      );
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset link sent to admin email.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A192F), Color(0xFF1976D2)], // Dark Blue to Light Blue
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.admin_panel_settings, size: 60, color: Colors.blue),
                      const SizedBox(height: 10),
                      const Text(
                        "Admin Login",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Admin Email",
                          hintText: "Enter Admin Email",
                          prefixIcon: const Icon(Icons.email, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter admin email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Admin Password",
                          hintText: "Enter Admin Password",
                          prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter admin password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _forgotPassword,
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Login Button
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



