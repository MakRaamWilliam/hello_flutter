
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return
       BlocProvider(
         create: (BuildContext context) => CounterCubit(),

    child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (BuildContext context, CounterStates state){},
          builder: (BuildContext context, CounterStates state)  =>
                    Scaffold(
                          appBar: AppBar(
                          title:
                          Text(
                          "Counter App"
                          ),
                          centerTitle: true,
                          ),
                          body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          TextButton(
                          onPressed: (){
                            CounterCubit.getInstance(context).minusCounter();
                          },
                          child: Text("-",
                          style: TextStyle(
                          fontSize: 30.0
                          ),)),
                          Text(
                          "${CounterCubit.getInstance(context).count}",
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0
                          ),
                          ),
                          TextButton(
                          onPressed: (){
                            CounterCubit.getInstance(context).plusCounter();

                          },
                          child: Text("+",
                          style: TextStyle(
                          fontSize: 30.0
                          ),)),

                          ],
                          ),
                          )
                          ],
                          ),
                    )

          )
       );

  }
}