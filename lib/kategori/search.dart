import 'package:dewatanv/dto/wisata.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/kategori/detailWisata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WisataSearchPage extends StatefulWidget {
  const WisataSearchPage({super.key});
  @override
  WisataSearchPageState createState() => WisataSearchPageState();
}

class WisataSearchPageState extends State<WisataSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Wisata> _searchResults = [];
  final List<String> _searchHistory = [];
  bool _isLoading = false;

  Future<void> _search(String keyword) async {
    setState(() {
      _isLoading = true;
      if (!_searchHistory.contains(keyword)) {
        _searchHistory.add(keyword);
      }
    });

    String url = '${Endpoints.wisata}/search?keyword=$keyword';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _searchResults = (data['datas'] as List)
            .map((json) => Wisata.fromJson(json))
            .toList();
      });
    } else {
      // Handle error response
      debugPrint('Error searching: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _searchResults = [];
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSubmitted: (value) {
                    _search(value);
                  },
                ),
                if (_searchHistory.isNotEmpty)
                  DropdownButton<String>(
                    hint: const Text("Select from history"),
                    isExpanded: true,
                    items: _searchHistory.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _controller.text = value;
                        _search(value);
                      }
                    },
                  ),
              ],
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: _searchResults.isEmpty
                      ? const Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            var wisata = _searchResults[index];
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    wisata.gambar,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(
                                  wisata.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Text(
                                  wisata.deskripsi,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WisataDetailScreen(wisata: wisata),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
