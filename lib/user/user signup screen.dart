// import 'package:flutter/material.dart';

// class UserSignupScreen extends StatefulWidget {
//   const UserSignupScreen({super.key});

//   @override
//   State<UserSignupScreen> createState() => _UserSignupScreenState();
// }

// class _UserSignupScreenState extends State<UserSignupScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: Text(
//           "Sign Up",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         color: Colors.grey[200],
//         child: Center(
//           child: SingleChildScrollView(
//             child: Card(
//               elevation: 8,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Create Your Account",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add submit logic here
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 40,
//                           vertical: 12,
//                         ),
//                       ),
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(fontSize: 16,color:Colors.black),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextButton(
//                       onPressed: () {
//                         // Navigate to login screen or action
//                       },
//                       child: Text(
//                         "Already have an account? Log in",
//                         style: TextStyle(color: Colors.deepPurple),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserSignupScreen extends StatefulWidget {
//   const UserSignupScreen({super.key});

//   @override
//   State<UserSignupScreen> createState() => _UserSignupScreenState();
// }

// class _UserSignupScreenState extends State<UserSignupScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void _signUp() async {
//     String username = _usernameController.text.trim();
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//     String confirmPassword = _confirmPasswordController.text.trim();

//     if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("All fields are required")),
//       );
//       return;
//     }

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Passwords do not match")),
//       );
//       return;
//     }

//     try {
//       // Create user with Firebase Authentication
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Add user details to Firestore
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'username': username,
//         'email': email,
//         'created_at': DateTime.now(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Sign-up successful!")),
//       );

//       // Clear the input fields
//       _usernameController.clear();
//       _emailController.clear();
//       _passwordController.clear();
//       _confirmPasswordController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: const Text(
//           "Sign Up",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         color: Colors.grey[200],
//         child: Center(
//           child: SingleChildScrollView(
//             child: Card(
//               elevation: 8,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       "Create Your Account",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: _confirmPasswordController,
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _signUp,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 40,
//                           vertical: 12,
//                         ),
//                       ),
//                       child: const Text(
//                         "Sign Up",
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextButton(
//                       onPressed: () {
//                         // Navigate to login screen or action
//                       },
//                       child: const Text(
//                         "Already have an account? Log in",
//                         style: TextStyle(color: Colors.deepPurple),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:arsmart/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender = 'Male'; // Default gender
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    } else {
      _showSnackBar("No image selected");
    }
  }

  Future<String?> _uploadProfileImage() async {
    if (_profileImage == null) return null;

    try {
      String? fileName = await uploadImageToCloudinary(_profileImage!.path);
      return fileName;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _signUpUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final phone = _phoneController.text.trim();
    final dob = _dobController.text.trim();
    final gender = _selectedGender;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        dob.isEmpty ||
        gender == null) {
      _showSnackBar("Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    try {
      // Create user with Firebase Authentication
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      // Upload the profile image if available
      String? profileImageUrl = await _uploadProfileImage();

      // Add user data to Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'dob': dob,
        'gender': gender,
        'uid': uid,
        'profileImage': profileImageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _showSnackBar("Sign up successful!");
      // Navigate to another screen, e.g., Home
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message ?? "An error occurred");
    } catch (e) {
      _showSnackBar("An unexpected error occurred");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Create Account",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue.shade400, Colors.lightBlue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Form Container
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 120),
                // Profile Photo
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, color: Colors.white, size: 30)
                        : null,
                  ),
                ),
                SizedBox(height: 16),

                // Name Field
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  icon: Icons.person,
                ),
                SizedBox(height: 16),

                // Email Field
                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),

                // Phone Field
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),

                // Date of Birth Field
                GestureDetector(
                  onTap: () => _selectDateOfBirth(context),
                  child: AbsorbPointer(
                    child: _buildTextField(
                      controller: _dobController,
                      label: 'Date of Birth',
                      hintText: 'Select your date of birth',
                      icon: Icons.calendar_today,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,
                        color: const Color.fromARGB(255, 17, 16, 16)),
                    labelText: 'Gender',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter a strong password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 16),

                // Confirm Password Field
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 30),

                // Submit Button
                ElevatedButton(
                  onPressed: _signUpUser,
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
                    backgroundColor: const Color.fromARGB(255, 226, 76, 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom TextField Widget with styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 15, 15, 15)),
          labelText: label,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          labelStyle: TextStyle(color: const Color.fromARGB(255, 25, 23, 23)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
