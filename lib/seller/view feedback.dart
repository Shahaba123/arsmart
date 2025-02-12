import 'package:flutter/material.dart';

void main() {
  runApp(SellerFeedbackApp());
}

class SellerFeedbackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SellerFeedbackPage(),
    );
  }
}

class SellerFeedbackPage extends StatelessWidget {
  final List<Map<String, dynamic>> feedbackList = [
    {
      "username": "John Doe",
      "rating": 5,
      "comment": "Great product! Highly recommended.",
    },
    {
      "username": "Jane Smith",
      "rating": 4,
      "comment": "Good quality, but delivery took longer than expected.",
    },
    {
      "username": "Mark Wilson",
      "rating": 3,
      "comment": "Average experience. Could be improved.",
    },
  ];

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer Feedback")),
      body: feedbackList.isEmpty
          ? Center(child: Text("No feedback received yet."))
          : ListView.builder(
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(feedbackList[index]["username"][0]),
                    ),
                    title: Text(feedbackList[index]["username"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStarRating(feedbackList[index]["rating"]),
                        SizedBox(height: 5),
                        Text(feedbackList[index]["comment"]),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
