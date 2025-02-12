import 'package:flutter/material.dart';

void main() {
  runApp(SellerOrderApp());
}

class SellerOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SellerOrdersPage(),
    );
  }
}

class SellerOrdersPage extends StatefulWidget {
  @override
  _SellerOrdersPageState createState() => _SellerOrdersPageState();
}

class _SellerOrdersPageState extends State<SellerOrdersPage> {
  List<Map<String, dynamic>> orders = [
    {
      "productName": "Smartphone",
      "price": 699.99,
      "quantity": 2,
      "status": "Pending",
      "image": "https://via.placeholder.com/150"
    },
    {
      "productName": "Wireless Headphones",
      "price": 129.99,
      "quantity": 1,
      "status": "Pending",
      "image": "https://via.placeholder.com/150"
    }
  ];

  void _markAsCompleted(int index) {
    setState(() {
      orders[index]["status"] = "Completed";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seller Orders")),
      body: orders.isEmpty
          ? Center(child: Text("No orders placed yet."))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(orders[index]["image"], width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(orders[index]["productName"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: \$${orders[index]["price"]}"),
                        Text("Quantity: ${orders[index]["quantity"]}"),
                        Text("Status: ${orders[index]["status"]}", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: orders[index]["status"] == "Pending" ? Colors.red : Colors.green,
                        )),
                      ],
                    ),
                    trailing: orders[index]["status"] == "Pending"
                        ? IconButton(
                            icon: Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () => _markAsCompleted(index),
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
