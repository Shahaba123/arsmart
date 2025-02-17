import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UserProductApp());
}

class UserProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: UserProductPage(),
    );
  }
}

class UserProductPage extends StatefulWidget {
  @override
  _UserProductPageState createState() => _UserProductPageState();
}

class _UserProductPageState extends State<UserProductPage> {
  final CollectionReference productsRef = FirebaseFirestore.instance.collection('products');
  String searchQuery = "";

  void _viewProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Products", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 240, 242, 243),
                hintText: "Search products...",
                hintStyle: TextStyle(color: const Color.fromARGB(179, 14, 14, 14)),
                prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 17, 17, 17)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: productsRef.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No products available.",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70)),
                  );
                }
                var products = snapshot.data!.docs.where((product) {
                  return product["name"].toLowerCase().contains(searchQuery);
                }).toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return GestureDetector(
                        onTap: () => _viewProduct(product.data() as Map<String, dynamic>),
                        child: Card(
                          color: const Color.fromARGB(255, 239, 241, 243),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                  child: Image.network(product["image"], fit: BoxFit.cover, width: double.infinity),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(product["name"],
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                    SizedBox(height: 5),
                                    Text("\$${product["price"]}",
                                        style: TextStyle(fontSize: 15, color: Colors.orangeAccent)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  ProductDetailsScreen({required this.product});

  void _buyProduct(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please login to buy products.")),
      );
      return;
    }
    await FirebaseFirestore.instance.collection("orders").add({
      "userId": user.uid,
      "productName": product["name"],
      "price": product["price"],
      "image": product["image"],
      "sellerId": product["sellerId"],
      "timestamp": FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order placed successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"])),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product["image"], height: 250, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price: \$${product["price"]}", style: TextStyle(fontSize: 22, color: Colors.orangeAccent)),
                SizedBox(height: 10),
                Text("Description:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                Text(product["description"], style: TextStyle(fontSize: 16, color: Colors.white70)),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _buyProduct(context),
                    child: Text("Buy Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



