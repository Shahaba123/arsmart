// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloudinary/cloudinary.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(SellerProductApp());
// }

// class SellerProductApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SellerHomePage(),
//     );
//   }
// }

// class SellerHomePage extends StatefulWidget {
//   @override
//   _SellerHomePageState createState() => _SellerHomePageState();
// }

// class _SellerHomePageState extends State<SellerHomePage> {
//   final CollectionReference productsRef =
//       FirebaseFirestore.instance.collection('products');
//   final User? currentUser =
//       FirebaseAuth.instance.currentUser; // Get current logged-in user

//   Future<String?> getClodinaryUrl(String imagePath) async {
//     final cloudinary = Cloudinary.signedConfig(
//       cloudName: 'dewdlr275',
//       apiKey: '893876956335369',
//       apiSecret: 'dXqJSXnFwWTHBeSsfgNfaOcTOjg',
//     );

//     final response = await cloudinary.upload(
//       file: imagePath,
//       resourceType: CloudinaryResourceType.image,
//     );
//     return response.secureUrl;
//   }

//   void _addProduct() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController nameController = TextEditingController();
//         TextEditingController priceController = TextEditingController();
//         TextEditingController descriptionController = TextEditingController();
//         XFile? imageFile;

//         return AlertDialog(
//           title: Text("Add Product"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(labelText: "Product Name")),
//               TextField(
//                   controller: priceController,
//                   decoration: InputDecoration(labelText: "Price")),
//               TextField(
//                   controller: descriptionController,
//                   decoration: InputDecoration(labelText: "Description")),
//               ElevatedButton(
//                 onPressed: () async {
//                   final ImagePicker picker = ImagePicker();
//                   imageFile =
//                       await picker.pickImage(source: ImageSource.gallery);
//                 },
//                 child: Text("Select Image"),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 if (nameController.text.isNotEmpty &&
//                     priceController.text.isNotEmpty &&
//                     currentUser != null &&
//                     imageFile != null) {
//                   String? imageUrl = await getClodinaryUrl(imageFile!.path);
//                   if (imageUrl != null) {
//                     productsRef.add({
//                       "name": nameController.text,
//                       "price": priceController.text,
//                       "description": descriptionController.text,
//                       "image": imageUrl,
//                       "sellerId": currentUser!.uid, // Store seller UID
//                     }).then((_) {
//                       Navigator.pop(context);
//                     });
//                   }
//                 }
//               },
//               child: Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteProduct(String id) {
//     productsRef.doc(id).delete();
//   }

//   void _viewProduct(Map<String, dynamic> product) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProductDetailsScreen(product: product),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (currentUser == null) {
//       return Scaffold(
//         body: Center(child: Text("User not logged in. Please sign in.")),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text("Seller Products")),
//       body: StreamBuilder(
//         stream: productsRef
//             .where("sellerId", isEqualTo: currentUser!.uid)
//             .snapshots(), // Filter by logged-in seller's UID
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text("No products added yet."));
//           }

//           var products = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var product = products[index];
//               return Card(
//                 elevation: 3,
//                 margin: EdgeInsets.all(10),
//                 child: ListTile(
//                   leading: Image.network(product["image"],
//                       width: 50, height: 50, fit: BoxFit.cover),
//                   title: Text(product["name"]),
//                   subtitle: Text("Price: \$${product["price"]}"),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           icon: Icon(Icons.visibility),
//                           onPressed: () => _viewProduct(
//                               product.data() as Map<String, dynamic>)),
//                       IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _deleteProduct(product.id)),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addProduct,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class ProductDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> product;

//   ProductDetailsScreen({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(product["name"])),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(child: Image.network(product["image"], height: 150)),
//             SizedBox(height: 10),
//             Text("Name: ${product["name"]}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text("Price: \$${product["price"]}",
//                 style: TextStyle(fontSize: 18)),
//             SizedBox(height: 10),
//             Text("Description: ${product["description"]}",
//                 style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             Text("Seller ID: ${product["sellerId"]}",
//                 style: TextStyle(
//                     fontSize: 14, color: Colors.grey)), // Display seller UID
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloudinary/cloudinary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<String?> uploadToCloudinary(Uint8List fileBytes, String fileName) async {
    final cloudinary = Cloudinary.signedConfig(
      cloudName: 'dewdlr275',
      apiKey: '893876956335369',
      apiSecret: 'dXqJSXnFwWTHBeSsfgNfaOcTOjg',
    );

    final response = await cloudinary.upload(
      fileBytes: fileBytes,
      fileName: fileName,
      resourceType: CloudinaryResourceType.image,
    );

    return response.secureUrl;
  }

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController priceController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();
        Uint8List? imageBytes;
        String? fileName;

        return AlertDialog(
          title: Text("Add Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    withData: true,
                  );

                  if (result != null && result.files.first.bytes != null) {
                    setState(() {
                      imageBytes = result.files.first.bytes;
                      fileName = result.files.first.name;
                    });
                  }
                },
                child: Text("Select Image"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    currentUser != null &&
                    imageBytes != null &&
                    fileName != null) {
                  String? imageUrl = await uploadToCloudinary(imageBytes!, fileName!);
                  if (imageUrl != null) {
                    await productsRef.add({
                      "name": nameController.text,
                      "price": priceController.text,
                      "description": descriptionController.text,
                      "image": imageUrl,
                      "sellerId": currentUser!.uid,
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(String id) {
    productsRef.doc(id).delete();
  }

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
    if (currentUser == null) {
      return Scaffold(
        body: Center(child: Text("User not logged in. Please sign in.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Seller Products")),
      body: StreamBuilder(
        stream: productsRef
            .where("sellerId", isEqualTo: currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products added yet."));
          }

          var products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(product["image"],
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product["name"]),
                  subtitle: Text("Price: \$${product["price"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () => _viewProduct(
                              product.data() as Map<String, dynamic>)),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(product.id)),
                    ],
                  ),
                ),
              );
            },
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
  final Map<String, dynamic> product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"])),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product["image"], height: 150)),
            SizedBox(height: 10),
            Text("Name: ${product["name"]}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Price: \$${product["price"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Description: ${product["description"]}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Seller ID: ${product["sellerId"]}",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

