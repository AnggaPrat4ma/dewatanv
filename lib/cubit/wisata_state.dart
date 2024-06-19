part of 'wisata_cubit.dart';

@immutable
class wisataState {
  const wisataState({required this.dataWisata});
  final List<Wisata> dataWisata;
}

final class wisataInitialState extends wisataState {
  wisataInitialState() : super(dataWisata: [
    //Wisata(idwisata: 1, nama: 'nama', deskripsi: 'deskripsi', gambar: 'A.png', video: 'video', rating: 2, maps: 'maps', idkategori: 1)
  ]);
}
