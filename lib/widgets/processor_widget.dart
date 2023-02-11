import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import "package:system_info/system_info.dart";
import 'package:device_info_plus/device_info_plus.dart';

class ProcessorWidget extends StatefulWidget {
  @override
  State<ProcessorWidget> createState() => _ProcessorWidgetState();
}

class _ProcessorWidgetState extends State<ProcessorWidget> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String processorVendor = '';
  String processorName = '';
  String processorCores = '';
  String processorArchitecture = '';
  String processorSoket = '';

  @override
  void initState() {
    super.initState();
    setVendor();
  }

  void setVendor() async {
    final processors = SysInfo.processors;
    print('ANDROIDINFOTEST: ${SysInfo.userName}');

    for (var processor in processors) {
      setState(() {
        processorVendor = processor.vendor.toString();
        processorName = processor.name.toString();
        processorArchitecture = processor.architecture.toString();
        processorSoket = processor.socket.toString();
        processorCores = processors.length.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Container(
      width: mediaQuery,
      child: Card(
        color: Colors.white24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Image.asset(
              processorVendor.toLowerCase() == 'qualcomm'
                  ? 'assets/qualcomm.png'
                  : 'assets/teste.png',
              height: 100,
              width: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cpuData(processorVendor),
                cpuData(processorName),
                cpuData(processorArchitecture),
                cpuData('$processorCores cores'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cpuData(String data) {
    return Text(data,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white));
  }
}
