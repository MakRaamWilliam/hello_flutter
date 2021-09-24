import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/modules/shop_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/shop_app/cubit/states.dart';
import 'package:hello_flutter/shared/components/components.dart';

class ShopLogInScreen extends StatefulWidget{
  @override
  _ShopLogInScreenState createState() => _ShopLogInScreenState();
}

class _ShopLogInScreenState extends State<ShopLogInScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkeys = GlobalKey<FormState>();

  bool isPasswordSecure = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){},
        builder: (context,state){

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
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context)=> state is! ShopLoginLoadingState,
                          widgetBuilder: (context)=>
                           defaultButton(
                            text: "Log In",
                            onPressed: (){
                              if(formkeys.currentState!.validate()) {
                                print("Email: " + emailController.text);
                                print("Password:" + passwordController.text);
                                ShopLoginCubit.getInstance(context).loginClick(
                                    user: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                          ),
                          fallbackBuilder: (context)=> Center(child: CircularProgressIndicator())
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
        },
      ),
    );
  }
}