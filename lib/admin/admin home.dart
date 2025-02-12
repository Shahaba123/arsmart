import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(AdminHomeApp());
}

class AdminHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UsersPage(),
    SellersPage(),
    OrdersPage(),
    FeedbackPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Makes bottom navigation bar look floating
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        centerTitle: true,
        elevation: 5,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.indigo.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _pages[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define action for floating button
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Add New Item Action")),
          );
        },
        backgroundColor: Colors.blue.shade800,
        child: Icon(Icons.add, size: 30, color: Colors.white),
        elevation: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white.withOpacity(0.9),
        elevation: 10,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue.shade900,
          unselectedItemColor: Colors.grey[500],
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: "Sellers"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          ],
        ),
      ),
    );
  }
}

// ** Updated Page UI with Glass Effect **
class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Users Management", Icons.people, Colors.blue);
  }
}

class SellersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Sellers Management", Icons.store, Colors.green);
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Orders Management", Icons.shopping_cart, Colors.orange);
  }
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Feedback Management", Icons.feedback, Colors.red);
  }
}

// ** Glassmorphism Card UI **
Widget _buildPage(String title, IconData icon, Color color) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, color.withOpacity(0.1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: Card(
        elevation: 6,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 320,
          height: 220,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.8), // Glass effect
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.2), blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 70, color: color),
              SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

