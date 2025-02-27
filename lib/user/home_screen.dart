import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];
  List<Map<String, dynamic>> recentlyViewed = [];
  List<Map<String, dynamic>> bestSelling = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    QuerySnapshot querySnapshot = await _firestore.collection("products").get();
    List<Map<String, dynamic>> products = querySnapshot.docs.map((doc) {
      return {
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      };
    }).toList();

    setState(() {
      allProducts = products;
      filteredProducts = products;
      bestSelling = products.take(5).toList(); // Example logic for best selling
    });
  }

  void _searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = allProducts;
      });
    } else {
      setState(() {
        filteredProducts = allProducts
            .where((product) =>
                product['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _addToRecentlyViewed(Map<String, dynamic> product) {
    setState(() {
      recentlyViewed.removeWhere((item) => item['id'] == product['id']);
      recentlyViewed.insert(0, product);
      if (recentlyViewed.length > 5) {
        recentlyViewed.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("ARSmart", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 20),
              if (recentlyViewed.isNotEmpty) ...[
                _buildSectionTitle("Recently Viewed"),
                _buildHorizontalList(recentlyViewed),
                SizedBox(height: 20),
              ],
              if (bestSelling.isNotEmpty) ...[
                _buildSectionTitle("Best Selling"),
                _buildHorizontalList(bestSelling),
                SizedBox(height: 20),
              ],
              _buildSectionTitle("All Products"),
              _buildProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: TextField(
        controller: searchController,
        onChanged: _searchProducts,
        decoration: InputDecoration(
          hintText: "Search for products...",
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHorizontalList(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _addToRecentlyViewed(items[index]),
            child: _buildProductCard(items[index]),
          );
        },
      ),
    );
  }

  Widget _buildProductList() {
    if (filteredProducts.isEmpty) {
      return Center(child: Text("No products found"));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _addToRecentlyViewed(filteredProducts[index]),
          child: _buildProductCard(filteredProducts[index]),
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(product['image'], height: 150, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(product['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(product['description'], style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 5),
            Text(product['price'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}

