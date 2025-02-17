import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewProduct extends StatefulWidget {
  @override
  _UserViewProductState createState() => _UserViewProductState();
}

class _UserViewProductState extends State<UserViewProduct> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _orderProduct(String productId, String productName, String price) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('orders').add({
        'userId': user.uid,
        'productId': productId,
        'productName': productName,
        'price': price,
        'status': 'Pending',
        'orderDate': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Products')),
      body: StreamBuilder(
        stream: _firestore.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: ListTile(
                  leading: Image.network(product['image'],
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product['name']),
                  subtitle: Text("Price: \$${product['price']}"),
                  trailing: ElevatedButton(
                    onPressed: () => _orderProduct(
                        product.id, product['name'], product['price']),
                    child: Text('Buy Now'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
