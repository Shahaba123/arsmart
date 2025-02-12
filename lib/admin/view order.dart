import 'package:flutter/material.dart';

void main() {
  runApp(AdminOrderApp());
}

class AdminOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel - View Orders',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: AdminOrdersPage(),
    );
  }
}

class AdminOrdersPage extends StatefulWidget {
  @override
  _AdminOrdersPageState createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  List<Map<String, dynamic>> orders = [
    {"buyer": "John Doe", "items": "Laptop, Mouse", "status": "Pending", "date": "2024-02-12"},
    {"buyer": "Jane Smith", "items": "Smartphone, Headphones", "status": "Shipped", "date": "2024-02-10"},
    {"buyer": "Michael Brown", "items": "Tablet", "status": "Delivered", "date": "2024-02-08"},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Shipped":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel: View Orders"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: CircleAvatar(
                  backgroundColor: getStatusColor(orders[index]["status"]!),
                  child: Icon(Icons.shopping_bag, color: Colors.white),
                ),
                title: Text(
                  orders[index]["buyer"]!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Items: ${orders[index]["items"]!}", style: TextStyle(color: Colors.grey.shade700)),
                    Text("Date: ${orders[index]["date"]!}", style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
                trailing: Chip(
                  label: Text(orders[index]["status"]!, style: TextStyle(color: Colors.white)),
                  backgroundColor: getStatusColor(orders[index]["status"]!),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey.shade600,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
