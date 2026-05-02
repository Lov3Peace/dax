import 'package:flutter/material.dart';

// Custom search delegate used to handle search UI and logic
// (triggered via showSearch in Flutter)
class CustomSearchDelegate extends SearchDelegate {
  // Static list of searchable items (replace with dynamic data later)
  List<String> searchTerms = [
    "Tiffany",
    "Mitch",
    "Cassandra",
    "Bluecheese",
    "Johnny",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Clears the current search query
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Closes the search view and returns to previous screen
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filters search results based on user input (query)
    List<String> matchQuery = [];

    for (var friends in searchTerms) {
      if (friends.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(friends);
      }
    }

    // Displays final search results after user submits query
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Provides live suggestions as the user types
    // (same filtering logic as results, but shown in real-time)
    List<String> matchQuery = [];

    for (var friends in searchTerms) {
      if (friends.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(friends);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
