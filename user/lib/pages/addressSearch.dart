import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () {},
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  final client = Client();
  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    var apiKey = "AIzaSyAeWGCO4e-w8xR_OohqJwJu45hDk2VqM9Q";
    // final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    Uri request = Uri(
      host: 'maps.googleapis.com',
      scheme: 'https',
      path: '/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey'//&sessiontoken=$sessionToken'
    );
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: null,
        builder: (context, snapshot) => query == ''
            ? Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Enter your address'),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(snapshot.data.toString()),
                      onTap: () {
                        // close(context, snapshot.data[index]
                        // );
                      },
                    ),
                    //itemCount:  snapshot.data.length,
                  )
                : const Text('Loading...'));
  }
}
