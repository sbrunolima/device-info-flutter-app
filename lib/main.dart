import 'package:flutter/material.dart';

//Screens
import './screens/home_page_screen.dart';

void main() => runApp(DeviceInfo());

class DeviceInfo extends StatefulWidget {
  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Device Info',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}
