import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeBattery extends StatefulWidget{
  @override
  State<NativeBattery> createState() => _NativeBatteryState();
}

class _NativeBatteryState extends State<NativeBattery> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  void _getBatteryLevel()  {
    String batteryLevel;
    platform.invokeMethod('getBatteryLevel')
    .then((value) {
      batteryLevel = 'Battery level at $value % .';
      setState(() {
        _batteryLevel = batteryLevel;
      });
    })
    .catchError((e){
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      setState(() {
        _batteryLevel = batteryLevel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );

  }
}