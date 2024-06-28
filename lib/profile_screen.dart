import 'package:dewatanv/cubit/auth/cubit/auth_cubit.dart';
import 'package:dewatanv/dto/profile.dart';
import 'package:dewatanv/endpoints/endpoints.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:dewatanv/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Akun>> akunData;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;
    akunData = DataService.fetchAkunById(authState.idUser);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List<Akun>>(
                future: akunData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      item.gambar.isNotEmpty
                                          ? '${Endpoints.baseUrl}/static/${item.gambar}'
                                          : '${Endpoints.baseUrl}/static/img/default.png',
                                    ),
                                  ),
                                  Text(
                                    item.namaUser,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(item.role),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.location_on),
                                      Text(
                                        item.lokasi.isNotEmpty
                                            ? item.lokasi
                                            : 'Indonesia',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          // Implement edit action here
                                          // For example, navigate to edit screen
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile(akun: item,)));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              _buildTabBar(),
              _buildGridView()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.bookmark)),
            ],
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              children: [
                _buildGridView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Image.network(
            'https://www.example.com/post_image_$index.jpg',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
