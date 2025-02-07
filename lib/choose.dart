import 'package:arsmart/admin/admin%20login.dart';
import 'package:arsmart/seller/seller%20login.dart';
import 'package:arsmart/user/user%20login.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  void _register() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role to proceed.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Proceeding as $_selectedRole')),
    );
    // Navigate to the respective registration screen based on role
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Role',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text('Admin'),
              value: 'Admin',
              groupValue: _selectedRole,
              onChanged: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminLoginScreen(),
                    ));
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('User'),
              value: 'User',
              groupValue: _selectedRole,
              onChanged: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLoginScreen(),
                    ));

                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Seller'),
              value: 'Seller',
              groupValue: _selectedRole,
              onChanged: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerLoginScreen(),
                    ));
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Proceed',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
