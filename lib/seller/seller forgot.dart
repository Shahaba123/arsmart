import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SellerForgotPasswordScreen extends StatefulWidget {
  @override
  _SellerForgotPasswordScreenState createState() => _SellerForgotPasswordScreenState();
}

class _SellerForgotPasswordScreenState extends State<SellerForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent! Check your email.')),
      );
      Navigator.pop(context); // Go back to the login screen
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Error sending reset link')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              // Send Reset Link Button
              ElevatedButton(
                onPressed: _isLoading ? null : _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 111, 183),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Send Reset Link', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

