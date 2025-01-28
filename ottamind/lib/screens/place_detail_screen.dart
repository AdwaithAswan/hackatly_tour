import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> placeDetails;

  const PlaceDetailScreen({
    Key? key,
    required this.placeDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          placeDetails['name'] ?? 'Place Details',
          style: const TextStyle(color: Color(0xFFF0EA99)),
        ),
        backgroundColor: const Color(0xFF292929),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF0EA99)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Place Image/Map Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF4156A3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${placeDetails['location']?['lat'] ?? 0}, ${placeDetails['location']?['lng'] ?? 0}',
                  style: const TextStyle(color: Color(0xFFF0EA99)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            _buildSection(
              'About',
              placeDetails['description'] ?? 'No description available',
            ),

            // Budget
            _buildSection(
              'Budget Information',
              placeDetails['estimatedBudget'] ?? 'Budget information not available',
            ),

            // Best Time to Visit
            _buildSection(
              'Best Time to Visit',
              placeDetails['bestTimeToVisit'] ?? 'Information not available',
            ),

            // Highlights
            _buildListSection(
              'Highlights',
              placeDetails['highlights'] ?? [],
            ),

            // Local Cuisine
            _buildListSection(
              'Local Cuisine',
              placeDetails['localCuisine'] ?? [],
            ),

            // Cultural Notes
            _buildSection(
              'Cultural Notes',
              placeDetails['culturalNotes'] ?? 'Cultural information not available',
            ),

            // Travel Tips
            _buildListSection(
              'Travel Tips',
              placeDetails['travelTips'] ?? [],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle bookmark action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Place added to bookmarks'),
              backgroundColor: Color(0xFF24848D),
            ),
          );
        },
        backgroundColor: const Color(0xFF4156A3),
        child: const Icon(
          Icons.bookmark_border,
          color: Color(0xFFF0EA99),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF0EA99),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildListSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF0EA99),
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: Color(0xFF24848D),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 16),
      ],
    );
  }
} 