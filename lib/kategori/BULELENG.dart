import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BULELENG extends StatefulWidget {
  const BULELENG({Key? key}) : super(key: key);

  @override
  _BULELENGState createState() => _BULELENGState();
}

class _BULELENGState extends State<BULELENG> {
  // Sample data
  final List<Map<String, dynamic>> items = [
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Place 1',
      'rating': 5,
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Place 2',
      'rating': 4,
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Place 3',
      'rating': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BULELENG', style: GoogleFonts.pacifico()),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(item['image']),
              title: Text(item['title']),
              subtitle: Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < item['rating'] ? Icons.star : Icons.star_border,
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}