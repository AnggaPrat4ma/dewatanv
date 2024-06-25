import 'package:dewatanv/wisata/pantai_penimbangan.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> featuredContents = [
    {
      'image': 'assets/images/agung.jpg',
      'title': 'Pura Agung Besakih',
      'rating': 5,
    },
    {
      'image': 'assets/images/tanah.jpeg',
      'title': 'Monumen Bajra Sandhi',
      'rating': 4,
    },
    {
      'image': 'assets/images/ulun-danu.jpg',
      'title': 'Pura Ulun Danu',
      'rating': 4,
    },
  ];

  final List<Map<String, dynamic>> videos = [
    {
      'thumbnail': 'assets/images/nusa dua.png',
      'title': 'Nusa Dua',
      'description': 'A beautiful view of nature.',
      'rating': 4,
    },
    {
      'thumbnail': 'assets/images/uluwatu.jpg',
      'title': 'Uluwatu',
      'description': 'The city illuminated at night.',
      'rating': 5,
    },
    {
      'thumbnail': 'assets/images/sanur.png',
      'title': 'Pantai Sanur',
      'description': 'Snowy mountains under.',
      'rating': 3,
    },
    {
      'thumbnail': 'assets/images/museum.jpg',
      'title': 'Museum Bali',
      'description': 'Sunset over the ocean.',
      'rating': 4,
    },
    {
      'thumbnail': 'assets/images/tirta.png',
      'title': 'Tirta Empul',
      'description': 'A serene path through the.',
      'rating': 5,
    },
    {
      'thumbnail': 'assets/images/penglipuran.jpg',
      'title': 'Desa Penglipuran',
      'description': 'A vast desert landscape.',
      'rating': 2,
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredVideos = [];

  @override
  void initState() {
    super.initState();
    _filteredVideos = videos;
    _searchController.addListener(_filterVideos);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterVideos);
    _searchController.dispose();
    super.dispose();
  }

  void _filterVideos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredVideos = videos.where((video) {
        final titleLower = video['title']!.toLowerCase();
        final descriptionLower = video['description']!.toLowerCase();
        return titleLower.contains(query) || descriptionLower.contains(query);
      }).toList();
    });
  }

  void navigateToCategory(String title) {
    switch (title) {
      case 'Monumen Bajra Sandhi':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PantaiPenimbangan()),
        );
      break;
    }
  }

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border ,
          size: 16.0,
          color: Colors.amber,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                ),
              ),
            ),
            // Featured Content Slider
            Container(
              height: 200.0,
              child: PageView.builder(
                itemCount: featuredContents.length,
                itemBuilder: (context, index) {
                  final content = featuredContents[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToCategory(content['title']);
                    },
                    child: Stack(
                      children: [
                        content['image']!.startsWith('http')
                            ? Image.network(
                                content['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Image.asset(
                                content['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.0,
                          left: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                featuredContents[index]['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              _buildStarRating(featuredContents[index]['rating']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Section Title
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommended for You',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Video Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2 / 2,
                ),
                itemCount: _filteredVideos.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: _filteredVideos[index]['thumbnail']!
                                  .startsWith('http')
                              ? Image.network(
                                  _filteredVideos[index]['thumbnail']!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  _filteredVideos[index]['thumbnail']!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _filteredVideos[index]['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildStarRating(_filteredVideos[index]['rating']),
                        ],
                      ),
                      Text(_filteredVideos[index]['description']!),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
