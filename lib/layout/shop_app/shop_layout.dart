import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ShopLayout extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Shop App"),
      ),
    );
  }

}