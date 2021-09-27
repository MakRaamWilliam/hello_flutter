import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/modules/shop_app/shop_log_in.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';

class SettingsScreen extends StatelessWidget{


  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formkeys = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    emailController.text = CacheHelper.getString(key: "email")?? " ";
    nameController.text =   CacheHelper.getString(key: "name")?? " ";
    phoneController.text =   CacheHelper.getString(key: "phone")?? " ";


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
                  readOnly: true,

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
                  readOnly: true,
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
                  readOnly: true,
                ),
                SizedBox(
                  height: 20.0,
                ),

                defaultButton(
                    onPressed: (){
                      CacheHelper.removeData(key: "isToken");
                      NavgPushToAndFinish(context, ShopLogInScreen());

                    },
                    text: "LOG OUT"
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }


}