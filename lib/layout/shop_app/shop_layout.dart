import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingPage {
  String imgSrc;
  String screenTitle;
  String screenBody;

  BoardingPage({
   required this.imgSrc,
   required this.screenBody,
   required this.screenTitle,
});
}

class ShopLayout extends StatefulWidget{

  bool isLast = false;

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  List<BoardingPage> boardingList = [
    BoardingPage(imgSrc:"assets/images/onboard_1.jpg",
    screenBody: "Screen Body 1",
    screenTitle: "Screen Title 1"
    ),
    BoardingPage(imgSrc:"assets/images/onboard_1.jpg",
        screenBody: "Screen Body 2",
        screenTitle: "Screen Title 2"
    ),
    BoardingPage(imgSrc:"assets/images/onboard_1.jpg",
        screenBody: "Screen Body 3",
        screenTitle: "Screen Title 3"
    ),

  ];

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Shop App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:PageView.builder(
             controller: pageController,
            itemBuilder: (context,index) => getPageViewItem(boardingList[index],boardingList.length),
             itemCount: 3,


        ),
      ),
    );
  }

  Widget getPageViewItem(BoardingPage boardItem,int count) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage(boardItem.imgSrc)
        ),
      ),
      SizedBox(height: 30.0,),
      Text(
        boardItem.screenTitle,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 30.0,),
      Text(
        boardItem.screenBody,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w100,
        ),
      ),
      SizedBox(height: 30.0,),
      Row(
        children: [
          SmoothPageIndicator(
              controller: pageController,  // PageController
              count:  count,
              effect: ExpandingDotsEffect(
              dotColor: Colors.grey,
              dotHeight: 10,
              expansionFactor: 4,
                activeDotColor: defaultColor,
                dotWidth: 10,
              spacing: 5.0,
            ),

          ),
          Spacer(),
          FloatingActionButton(
            onPressed: (){
              pageController.nextPage(
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            child: Icon(Icons.arrow_forward_ios_rounded),
          ),

        ],
      ),

    ],
  );
}