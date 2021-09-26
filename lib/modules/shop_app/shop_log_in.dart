import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/layout/shop_app/shop_layout.dart';
import 'package:hello_flutter/modules/shop_app/log_in_cubit/cubit.dart';
import 'package:hello_flutter/modules/shop_app/log_in_cubit/states.dart';
import 'package:hello_flutter/modules/shop_app/products_screen.dart';
import 'package:hello_flutter/modules/shop_app/register_screen.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';

class ShopLogInScreen extends StatelessWidget{
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkeys = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          ShopLoginCubit cubit = ShopLoginCubit.getInstance(context);
          if(state is ShopLoginSuccessState){
            if(cubit.shopLoginModel.status ){
              defaultToast(msg: cubit.shopLoginModel.message,
                color: Colors.green,
              );
              CacheHelper.putBool(key: "isToken", value: true);
              NavgPushToAndFinish(context, ShopLayout());
            }else {
              defaultToast(
                msg: cubit.shopLoginModel.message,
                color: Colors.red,
              );
            }
          }
        },
        builder: (context,state){
          ShopLoginCubit cubit = ShopLoginCubit.getInstance(context);
            return Scaffold(
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
                        defaultFormField(
                          type:TextInputType.emailAddress ,
                          controller: emailController,
                          validText:  "Email can not be empty",
                          label: "Email Address" ,
                          prefix: Icons.email,
                          ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPasswordSecure,
                          validText: "Password can not be empty",
                          label: "Password",
                          suffixPressed: cubit.ChangePasswrodSecure,
                          suffix:  cubit.isPasswordSecure ?
                          Icons.remove_red_eye:
                          Icons.remove_red_eye_outlined ,
                          onSubmit: (value){
                            if(formkeys.currentState!.validate()) {
                              print("Email: " + emailController.text);
                              print("Password:" + passwordController.text);
                              ShopLoginCubit.getInstance(context).loginClick(
                                  user: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          }
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
                                NavgPushTo(context, RegistrationScreen());
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
        },
      ),
    );
  }

}