import 'package:flutter/material.dart';
import 'package:ottamind/screens/place_detail_screen.dart';
import 'package:ottamind/services/gemini_service.dart';
//import 'package:travel_guide/services/gemini_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  RangeValues _budgetRange = const RangeValues(0, 1000);
  String _selectedFoodPreference = 'All';
  String _selectedLanguage = 'English';
  DateTimeRange? _selectedDateRange;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await GeminiService.searchPlaces(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
        });
      }
    } catch (e) {
      print('Error performing search: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error searching for places. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Trips',
          style: TextStyle(color: Color(0xFFF0EA99)),
        ),
        backgroundColor: const Color(0xFF292929),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search destinations...',
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults.clear();
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: _performSearch,
            ),
          ),

          ExpansionTile(
            title: const Text('Filters'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Budget Range'),
                    RangeSlider(
                      values: _budgetRange,
                      min: 0,
                      max: 1000,
                      divisions: 20,
                      labels: RangeLabels(
                        '\$${_budgetRange.start.round()}',
                        '\$${_budgetRange.end.round()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _budgetRange = values;
                        });
                      },
                      activeColor: const Color(0xFF24848D),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final place = _searchResults[index];
                      return Card(
                        color: const Color(0xFF4156A3),
                        child: ListTile(
                          title: Text(place['name'] ?? ''),
                          subtitle: Text(place['description'] ?? ''),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.bookmark_border,
                              color: Color(0xFFF0EA99),
                            ),
                            onPressed: () {
                              // Handle bookmark
                            },
                          ),
                          onTap: () async {
                            final details = await GeminiService.getPlaceDetails(
                              place['name'],
                            );
                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaceDetailScreen(
                                    placeDetails: details,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 