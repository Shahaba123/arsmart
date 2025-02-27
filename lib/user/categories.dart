import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Categories(), debugShowCheckedModeBanner: false));
}

class Categories extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Chairs", "icon": Icons.chair, "color": Colors.blue},
    {"name": "Tables", "icon": Icons.table_chart, "color": Colors.green},
    {"name": "Sofas", "icon": Icons.weekend, "color": Colors.orange},
    {"name": "Beds", "icon": Icons.bed, "color": Colors.red},
    {"name": "Lamps", "icon": Icons.lightbulb, "color": Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Furniture Store", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: _buildCategories(context)),
          ],
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
        decoration: InputDecoration(
          hintText: "Search for furniture...",
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(category: categories[index]),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: categories[index]['color'],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(categories[index]['icon'], size: 50, color: Colors.white),
                SizedBox(height: 5),
                Text(categories[index]['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> category;

  CategoryDetailScreen({required this.category});

  final List<Map<String, dynamic>> sampleProducts = [
    {"name": "Modern Chair", "price": "\$120", "image": "https://via.placeholder.com/150"},
    {"name": "Classic Table", "price": "\$200", "image": "https://via.placeholder.com/150"},
    {"name": "Luxury Sofa", "price": "\$450", "image": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name']),
        backgroundColor: category['color'],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: _buildProductList()),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      itemCount: sampleProducts.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: Image.network(sampleProducts[index]['image'], width: 50, height: 50),
            title: Text(sampleProducts[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(sampleProducts[index]['price'], style: TextStyle(color: Colors.brown)),
          ),
        );
      },
    );
  }
}
