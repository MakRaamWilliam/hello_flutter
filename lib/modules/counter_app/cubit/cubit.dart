import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/counter_app/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(InitState());

  int count = 1;

  static CounterCubit getInstance(context) => BlocProvider.of(context);

  void minusCounter(){
    count--;
    emit(MinusState());
  }

  void plusCounter( ){
    count++;
    emit(PlusState());
  }

}