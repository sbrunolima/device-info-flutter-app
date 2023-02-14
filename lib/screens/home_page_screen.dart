import 'dart:async';
import 'dart:io';

import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:percent_indicator/percent_indicator.dart';
import "package:system_info/system_info.dart";
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:storage_info/storage_info.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/enums/charging_status.dart';

//Widgets
import '../widgets/ram_widget.dart';
import '../widgets/processor_widget.dart';
import '../widgets/home_title_widget.dart';
import '../widgets/storage_widget.dart';
import '../widgets/battery_widget.dart';
import '../widgets/system_widget.dart';
import '../widgets/device_widget.dart';

import '../widgets/card_titles_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Center(
          child: Text(
            'Device Information',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 26),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              HomeTitleWidget(title: 'RAM'),
              RamWidget(),
              HomeTitleWidget(title: 'Device'),
              DeviceWidget(),
              HomeTitleWidget(title: 'CPU'),
              ProcessorWidget(),
              HomeTitleWidget(title: 'System'),
              SystemWidget(),
              HomeTitleWidget(title: 'Stats'),
              StorageWidget(),
              BatteryWidget(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
