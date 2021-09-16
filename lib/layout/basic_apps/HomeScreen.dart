import 'package:flutter/material.dart';
import 'package:hello_flutter/modules/bmi_app/BMICalculator.dart';
import 'package:hello_flutter/modules/counter_app/CounterScreen.dart';
import 'package:hello_flutter/modules/messenger_app/Messenger.dart';
import 'package:hello_flutter/modules/log_in_app/loginScreen.dart';
import 'package:hello_flutter/shared/components/components.dart';


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
                defaultButton(
                  text: "Log In App",
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
                ),
                SizedBox(height: 15.0,),
                defaultButton(
                  text: "Counter App",
                  onPressed:() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return CounterScreen();
                            }
                        )
                    );
                  },

                ),
                SizedBox(height: 15.0,),
                defaultButton(
                  text: "Messenger App",
                  onPressed:  (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return Messenger();
                            }
                        )
                    );
                  },
                ),
                SizedBox(height: 15.0,),
                defaultButton(
                  text: "BMI App",
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