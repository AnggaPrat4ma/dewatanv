part of 'wisata_cubit.dart';

@immutable
class WisataState {
  const WisataState({required this.dataWisata});
  final List<Wisata> dataWisata;
}

final class WisataInitialState extends WisataState {
  WisataInitialState() : super(dataWisata: [
    //Wisata(idwisata: 1, nama: 'nama', deskripsi: 'deskripsi', gambar: 'A.png', video: 'video', rating: 2, maps: 'maps', idkategori: 1)
  ]);
}
