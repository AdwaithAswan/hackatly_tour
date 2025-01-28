import 'package:flutter/material.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bookmarks',
          style: TextStyle(color: Color(0xFFF0EA99)),
        ),
        backgroundColor: const Color(0xFF292929),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 0, // Will be replaced with actual bookmarked trips
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF4156A3),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  color: const Color(0xFF24848D),
                  child: const Icon(
                    Icons.landscape,
                    color: Color(0xFFF0EA99),
                  ),
                ),
              ),
              title: const Text(
                'Trip Name',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Location • Budget',
                style: TextStyle(color: Color(0xFFB1E3D3)),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Color(0xFFF0EA99),
                ),
                onPressed: () {
                  // Handle unbookmark
                },
              ),
            ),
          );
        },
      ),
    );
  }
} 