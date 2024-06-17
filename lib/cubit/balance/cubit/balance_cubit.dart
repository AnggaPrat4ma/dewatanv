import 'package:bloc/bloc.dart';
import 'package:dewatanv/dto/balance.dart';
import 'package:dewatanv/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitialState());

  Future<void> fetchBalance() async {
    try{
      debugPrint("fire api");
      int fetchedBalance;
      List<Balances>? balances;
      balances = await DataService.fetchBalances();
      fetchedBalance = balances[0].balance;
      emit(BalanceState(balance: fetchedBalance));
    } catch (e) {
      debugPrint("Error fetched data");
    }
  }

  void updateBalances(int spending) {
    final int newBalance = state.balance - spending;
    emit(BalanceState(balance: newBalance));
  }
}
