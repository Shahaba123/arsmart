import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  User? _user;
  Map<String, dynamic>? _userData;
  File? _image;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Upload image logic goes here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (_userData!["profileImage"] != null
                              ? NetworkImage(_userData!["profileImage"])
                              : AssetImage("assets/default_avatar.png"))
                                  as ImageProvider,
                      child: _image == null
                          ? Icon(Icons.camera_alt, size: 30)
                          : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Name: ${_userData!["name"]}",
                      style: TextStyle(fontSize: 18)),
                  Text("Email: ${_userData!["email"]}",
                      style: TextStyle(fontSize: 18)),
                  Text("Phone: ${_userData!["phone"]}",
                      style: TextStyle(fontSize: 18)),
                  Text("DOB: ${_userData!["dob"]}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Edit Profile Page
                    },
                    child: Text("Edit Profile"),
                  ),
                ],
              ),
            ),
    );
  }
}