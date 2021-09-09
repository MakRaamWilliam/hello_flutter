import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class loginScreen extends StatelessWidget{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0015/7587/brand.gif?itok=CbbOOGEv",
                  width: 200.0,
                  height: 150.0,
                ),

                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value){
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon: Icon(
                        Icons.email
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (value){
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: "Password ",
                    suffixIcon: Icon(
                        Icons.remove_red_eye_rounded
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  width: double.infinity,
                    color: Colors.blueAccent,
                    child: MaterialButton(onPressed: (){
                    print("Email: "+emailController.text );
                    print("Password:" + passwordController.text);
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white70,
                    ),
                  ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        "don\'t have an account ",

                      ),
                      TextButton(onPressed: (){
                        print("Create new account");
                      },
                          child: Text(
                            "Register Now"
                          ))

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}