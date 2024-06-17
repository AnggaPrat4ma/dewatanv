import 'package:dewatanv/components/asset_image_widget.dart';
import 'package:flutter/material.dart';
class AboutUs extends StatelessWidget {
const AboutUs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/angga.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Gede Angga Putra Pratama',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Perkenalkan saya Gede Angga Putra Pratama dari Universitas Pendidikan'
                'Ganesha Fakultas Teknik dan Kejuruan Jurusan Teknik Informatika Prodi'
                'Sistem Informasi. Saya sangat senang berkuliah di Undiksha karena banyak'
                'teman yang saya temui di kampus ini, dan juga saya mengikuti organisasi'
                'yaitu BEM FTK masa bakti 2023/2024 dan 2024/2025.',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AssetImageWidget(
                  imagePath: 'assets/images/angga.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email: anggapratama@gmail.com\n'
                'Phone: +628674395836\n'
                'Address: jaln kakak tua no.26, kaliuntu',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
