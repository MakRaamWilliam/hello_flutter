import 'package:flutter/material.dart';
import 'package:hello_flutter/BMICalculator.dart';
import 'package:hello_flutter/CounterScreen.dart';
import 'package:hello_flutter/Messenger.dart';
import 'package:hello_flutter/loginScreen.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar(
      leading: Icon(
        Icons.menu
      ),
      title: Text("       First App    "),
      centerTitle: true,
      backgroundColor: Colors.amberAccent,
      actions: [
        IconButton(onPressed: (){
          print("Notification pressed");
        }, icon:Icon( Icons.notifications_active)
        ),

        IconButton(onPressed:SearchPressed
        , icon:Icon( Icons.search)
        ),
      ],
    ),

      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context){
                                return loginScreen();
                              }
                          )
                      );
                    },
                  child: Text(
                    "Log In App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return CounterScreen();
                            }
                        )
                    );
                  },
                  child: Text(
                    "Counter App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return Messenger();
                            }
                        )
                    );
                  },
                  child: Text(
                    "Messenger App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return BMICalculator();
                            }
                        )
                    );
                  },
                  child: Text(
                    "BMI App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
  );

  }
 void SearchPressed() {
  print("Search Pressed");
 }

}