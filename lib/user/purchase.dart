import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuyNowScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final num price;
  final String imageUrl;

  BuyNowScreen({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedPaymentMethod = "Cash on Delivery"; // Default payment method

  void _confirmOrder() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('orders').add({
        'userId': user.uid,
        'productId': widget.productId,
        'productName': widget.productName,
        'price': widget.price,
        'paymentMethod': _selectedPaymentMethod,
        'status': 'Pending',
        'orderDate': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );

      Navigator.pop(context); // Return to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.network(
                widget.imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                },
              ),
            ),
            SizedBox(height: 20),

            // Product Details
            Text(
              widget.productName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Price: \$${widget.price}", style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),

            // Payment Method Selection
            Text(
              "Select Payment Method:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Payment Method Radio Buttons
            Column(
              children: [
                ListTile(
                  title: Text("Cash on Delivery"),
                  leading: Radio(
                    value: "Cash on Delivery",
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text("Online Payment (Coming Soon)"),
                  leading: Radio(
                    value: "Online Payment",
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Confirm Order Button
            Center(
              child: ElevatedButton(
                onPressed: _confirmOrder,
                child: Text("Confirm Order", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
