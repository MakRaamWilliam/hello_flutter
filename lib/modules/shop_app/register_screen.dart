import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/modules/shop_app/log_in_cubit/cubit.dart';
import 'package:hello_flutter/modules/shop_app/log_in_cubit/states.dart';
import 'package:hello_flutter/modules/shop_app/register_cubit/cubit.dart';
import 'package:hello_flutter/modules/shop_app/register_cubit/states.dart';
import 'package:hello_flutter/shared/components/components.dart';

class RegistrationScreen extends StatelessWidget{

  var emailController = TextEditingController();
  var passwordController1 = TextEditingController();
  var passwordController2 = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formkeys = GlobalKey<FormState>();

  bool isPasswordSecure = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> ShopRegisterCubit(),

      child: BlocConsumer<ShopRegisterCubit,ShopRegistersStates>(
        listener: (context,state){
          ShopRegisterCubit cubit = ShopRegisterCubit.getInstance(context);
          if(state is ShopRegisterSuccessState){
            if(cubit.status ){
              defaultToast(msg: cubit.mess,
                color: Colors.green,

              );
            }else {
              defaultToast(
                msg: cubit.mess,
                color: Colors.red,
              );
            }
          }
        },
        builder: (context,state){
          ShopRegisterCubit cubit = ShopRegisterCubit.getInstance(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkeys,
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        label: "Name",
                        validText: "name can not be empty",
                        prefix: Icons.edit,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: "Phone",
                        validText: "phone can not be empty",
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: "Email Address",
                        validText: "Email can not be empty",
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: passwordController1,
                        type: TextInputType.visiblePassword,
                        label: "Password",
                        validText: "Password can not be empty",
                        prefix: Icons.security,
                        suffixPressed: cubit.ChangePasswrodSecure,
                        suffix: cubit.isPasswordSecure ?
                        Icons.remove_red_eye:
                        Icons.remove_red_eye_outlined ,
                        isPassword: cubit.isPasswordSecure,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: passwordController2,
                        type: TextInputType.visiblePassword,
                        label: "Confirm Password",
                        validText: "Password can not be empty",
                        prefix: Icons.security,
                        suffixPressed: cubit.ChangePasswrodSecure,
                        suffix: cubit.isPasswordSecure ?
                        Icons.remove_red_eye:
                        Icons.remove_red_eye_outlined ,
                        isPassword: cubit.isPasswordSecure,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context)=> state is! ShopRegisterLoadingState,
                          widgetBuilder: (context)=>
                              defaultButton(
                                text: "Register",
                                onPressed: (){
                                  if(formkeys.currentState!.validate() &&
                                      passwordController1.text == passwordController2.text ) {
                                    print("Email: " + emailController.text);
                                    print("Password:" + passwordController1.text);
                                    cubit.RegisterClick(
                                         name: nameController.text,
                                         phone: phoneController.text,
                                         email: emailController.text,
                                         password: passwordController1.text
                                    );
                                  }
                                },
                              ),
                          fallbackBuilder: (context)=> Center(child: CircularProgressIndicator())
                      ),
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