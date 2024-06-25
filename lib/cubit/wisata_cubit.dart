import 'package:dewatanv/dto/wisata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'wisata_state.dart';

class wisataCubit extends Cubit<wisataState> {
  wisataCubit() : super(wisataInitialState());

  // Future<void> fetchWisataCubit() async {
  //   try {
  //     debugPrint('Berhasil');
  //     List<Wisata>? 
  //   }
  // }
}
