import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import "package:system_info/system_info.dart";
import 'package:enefty_icons/enefty_icons.dart';
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';

//Widgets
import '../widgets/processor_widget.dart';

class CpuInfoScreen extends StatefulWidget {
  static const routeName = '/cpu-screen';
  @override
  State<CpuInfoScreen> createState() => _CpuInfoScreenState();
}

class _CpuInfoScreenState extends State<CpuInfoScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String processorVendor = '';
  String processorName = '';
  String processorCores = '';
  String processorArchitecture = '';
  String processorSoket = '';
  List<int?> processorFrequency = [];

  @override
  void initState() {
    super.initState();
    setVendor();
  }

  void setVendor() async {
    final processors = SysInfo.processors;
    CpuInfo cpuInfo = await CpuReader.cpuInfo;

    for (int i = 0; i < processors.length; i++) {
      await CpuReader.getCurrentFrequency(i);
      setState(
        () async {
          processorFrequency = [
            await CpuReader.getCurrentFrequency(i),
          ];
        },
      );
    }

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

  final List<String> _processorsBrand = [
    'qualcomm',
    'exynos',
    'mediatek',
    'unisoc',
    'kirin',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('CPU'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 435,
          width: mediaQuery,
          child: Card(
            color: Colors.white24,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                cardText('Cores', processorCores),
                cardText('Frequency', '${processorFrequency[1].toString()}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardText(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.lightGreenAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
