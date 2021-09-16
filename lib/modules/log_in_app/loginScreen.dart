import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_flutter/shared/components/components.dart';

class loginScreen extends StatefulWidget{
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkeys = GlobalKey<FormState>();

  bool isPasswordSecure = true;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkeys,
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
                    validator: (value){
                        if(value!.isEmpty)
                          return "Email can not be empty";
                        return null;
                    },
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        prefixIcon: Icon(
                           Icons.email,
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
                    obscureText: isPasswordSecure,
                    onFieldSubmitted: (value){
                      print(value);
                    },
                    validator: (value){
                      if(value!.isEmpty)
                        return "Password can not be empty";
                      return null;

                    },
                    decoration: InputDecoration(
                      labelText: "Password ",
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isPasswordSecure = !isPasswordSecure;
                          });
                        },
                        icon: Icon(
                            isPasswordSecure ?
                            Icons.remove_red_eye_rounded:
                                Icons.remove_red_eye_outlined
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultButton(
                    text: "Log In",
                    onPressed: (){
                      if(formkeys.currentState!.validate()) {
                        print("Email: " + emailController.text);
                        print("Password:" + passwordController.text);
                      }
                    },
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
      ),
    );
  }
}