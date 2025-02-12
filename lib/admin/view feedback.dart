import 'package:flutter/material.dart';

void main() {
  runApp(AdminFeedbackApp());
}

class AdminFeedbackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel - View Feedback',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: AdminFeedbackPage(),
    );
  }
}

class AdminFeedbackPage extends StatefulWidget {
  @override
  _AdminFeedbackPageState createState() => _AdminFeedbackPageState();
}

class _AdminFeedbackPageState extends State<AdminFeedbackPage> {
  List<Map<String, dynamic>> feedbackList = [
    {"user": "Alice Johnson", "message": "Great service!", "rating": 5, "date": "2024-02-12"},
    {"user": "Bob Smith", "message": "Good but can improve.", "rating": 3, "date": "2024-02-10"},
    {"user": "Charlie Brown", "message": "Very satisfied!", "rating": 4, "date": "2024-02-08"},
  ];

  Icon getStarRating(int rating) {
    if (rating >= 4) {
      return Icon(Icons.star, color: Colors.orange, size: 30);
    } else {
      return Icon(Icons.star_half, color: Colors.orange, size: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel: View Feedback"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: getStarRating(feedbackList[index]["rating"]),
                title: Text(
                  feedbackList[index]["user"]!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Message: ${feedbackList[index]["message"]!}", style: TextStyle(color: Colors.grey.shade700)),
                    Text("Date: ${feedbackList[index]["date"]!}", style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple.shade900,
        unselectedItemColor: Colors.grey.shade600,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
