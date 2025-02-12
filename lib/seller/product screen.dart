import 'package:flutter/material.dart';

void main() {
  runApp(SellerProductApp());
}

class SellerProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SellerHomePage(),
    );
  }
}

class SellerHomePage extends StatefulWidget {
  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  List<Map<String, String>> products = [];

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController priceController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();

        return AlertDialog(
          title: Text("Add Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Product Name")),
              TextField(controller: priceController, decoration: InputDecoration(labelText: "Price")),
              TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                  setState(() {
                    products.add({
                      "name": nameController.text,
                      "price": priceController.text,
                      "description": descriptionController.text,
                      "image": "https://via.placeholder.com/150"
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void _viewProduct(Map<String, String> product) {
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
      appBar: AppBar(title: Text("Seller Products")),
      body: products.isEmpty
          ? Center(child: Text("No products added yet."))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(products[index]["image"]!, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(products[index]["name"]!),
                    subtitle: Text("Price: \$${products[index]["price"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.visibility), onPressed: () => _viewProduct(products[index])),
                        IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteProduct(index)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, String> product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"]!)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product["image"]!, height: 150)),
            SizedBox(height: 10),
            Text("Name: ${product["name"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Price: \$${product["price"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Description: ${product["description"]}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

