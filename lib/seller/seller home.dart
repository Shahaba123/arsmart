import 'package:flutter/material.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProfileScreen(),
    ProductsScreen(),
    OrdersScreen(),
    FeedbackScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _pages[_currentIndex], // Display current tab content
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.blue.shade800,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analytics'),
          ],
        ),
      ),
    );
  }
}

// 🔹 Attractive Profile Screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSection('Profile', Icons.person, 'Manage your seller profile and account settings.');
  }
}

// 🔹 Attractive Products Screen
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSection('Products', Icons.shopping_bag, 'Add, edit, and manage your listed products.');
  }
}

// 🔹 Attractive Orders Screen
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSection('Orders', Icons.receipt_long, 'View and manage customer orders efficiently.');
  }
}

// 🔹 Attractive Feedback Screen
class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSection('Feedback', Icons.feedback, 'Check customer reviews and feedback.');
  }
}

// 🔹 Attractive Analytics Screen
class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSection('Analytics', Icons.bar_chart, 'Track sales and performance analytics.');
  }
}

// 🌟 Reusable Card-based UI for Each Section
Widget _buildSection(String title, IconData icon, String description) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        shadowColor: Colors.black45,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 60, color: Colors.blue.shade800),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
              SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


