import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_flutter/modules/bmi_app/BMIResults.dart';
import 'package:hello_flutter/shared/components/components.dart';

class BMICalculator extends StatefulWidget{
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int height = 170;
  int age = 22;
  int weight = 50;
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
               width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isMale = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: !isMale? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/female.png'),
                                    fit: BoxFit.fitHeight,
                                     height: 100.0,
                                      width: 100.0,
                                ),
                                SizedBox(height: 8.0,),
                                Text("Female"
                                ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                  ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 5.0,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isMale = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isMale ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/male.png'),
                                  fit: BoxFit.fitHeight,
                                  height: 100.0,
                                  width: 100.0,
                                ),
                                SizedBox(height: 8.0,),
                                Text("Male"
                                  ,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                  ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Height",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${height}",
                              style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text("Cm"),
                          ],
                        ),
                        Slider(
                            value: 1.0 * height,
                            max: 220.0,
                            min: 100.0,
                            onChanged: (value){
                              setState(() {
                                height = value.round();
                                print(value.round());
                              });
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text("Weight",
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                                )
                                  ,),
                                Text("${weight}"
                                  ,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                  ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(onPressed:
                                    (){
                                       setState(() {
                                         weight--;
                                       });
                                    },
                                      mini: true,
                                        heroTag: "Weight--",

                                        child: Icon( Icons.remove,)
                                    ),
                                    FloatingActionButton(onPressed:
                                        (){
                                        setState(() {
                                          weight++;
                                        });
                                    },
                                        mini: true,
                                        heroTag: "Weight++",

                                        child: Icon( Icons.add,)
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 5.0,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text("Age",
                                  style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                  )
                                  ,),
                                Text("${age}"
                                  ,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                  ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(onPressed:
                                        (){
                                      setState(() {
                                        age--;
                                      });
                                    },
                                        mini: true,
                                        heroTag: "Age--",
                                        child: Icon( Icons.remove,)
                                    ),
                                    FloatingActionButton(onPressed:
                                        (){
                                      setState(() {
                                        age++;
                                      });
                                    },
                                        mini: true,
                                        heroTag: "Age++",
                                        child: Icon( Icons.add,)
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            defaultButton(
               text: "Calculate",
               onPressed:  (){
                 NavgPushTo(
                     context,
                     BMIResults(
                       isMale: isMale,
                       age: age,
                       weight: weight,
                     )

                 );
            })
          ],
        ),

    );
  }
}