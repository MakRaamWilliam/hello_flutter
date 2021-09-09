
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget{
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
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
                        setState(() {
                          print(--counter);
                        });
                      },
                      child: Text("Minus",
                      style: TextStyle(
                        fontSize: 30.0
                      ),)),
                  Text(
                    "${counter}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        setState(() {
                          print(++counter);
                        });

                      },
                      child: Text("Plus",
                      style: TextStyle(
                        fontSize: 30.0
                      ),)),

                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}