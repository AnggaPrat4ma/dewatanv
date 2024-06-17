import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DENPASAR extends StatefulWidget {
  final int idkategori;
  const DENPASAR({ Key? key, required this.idkategori}) : super(key: key);

  @override
  _DENPASARState createState() => _DENPASARState();
}

class _DENPASARState extends State<DENPASAR> {

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 16.0,
          color: Colors.amber,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('', 
        style: GoogleFonts.pacifico()),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        // child: videos[index]['thumbnail']!
                        //         .startsWith('http')
                        //     ? Image.network(
                        //         videos[index]['thumbnail']!,
                        //         fit: BoxFit.cover,
                        //       )
                        //     : Image.asset(
                        //         videos[index]['thumbnail']!,
                        //         fit: BoxFit.cover,
                        //       ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         videos[index]['title']!,
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //     _buildStarRating(videos[index]['rating']),
                    //   ],
                    // ),
                    //Text(videos[index]['description']!),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}