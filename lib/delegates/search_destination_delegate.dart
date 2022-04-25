import 'package:flutter/material.dart';
import 'package:map_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar destino');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
          title: const Text(
            'Colocar la ubicacion manualmente',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
