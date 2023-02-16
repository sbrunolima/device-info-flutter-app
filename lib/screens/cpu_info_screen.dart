import 'package:flutter/material.dart';
import "package:system_info/system_info.dart";
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';

class CpuInfoScreen extends StatefulWidget {
  static const routeName = '/cpu-screen';
  @override
  State<CpuInfoScreen> createState() => _CpuInfoScreenState();
}

class _CpuInfoScreenState extends State<CpuInfoScreen> {
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
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Divider(color: Colors.grey),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: const Text('CPU'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: int.parse(processorCores) <= 8 ? 400 : 600,
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
                StreamBuilder<CpuInfo>(
                  stream: CpuReader.cpuStream(1000),
                  builder: (_, AsyncSnapshot<CpuInfo> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cardText('Cores', processorCores, true),
                          cardText(
                            'Temperature',
                            '${snapshot.data!.cpuTemperature.toString()}°',
                            true,
                          ),
                          cardText('Running CPUs', processorCores, false),
                          Column(
                            children: buildFreqList(snapshot),
                          ),
                        ],
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: Colors.lightGreenAccent,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Loading...',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.lightGreenAccent,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Padding> buildFreqList(AsyncSnapshot<CpuInfo> snapshot) {
    return snapshot.data!.currentFrequencies!.entries
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Core ${entry.key}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(width: 30),
                Text(
                  '${entry.value} MHz',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.lightGreenAccent,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget cardText(String title, String subtitle, bool useSubitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
          if (useSubitle)
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
            ),
          if (useSubitle) const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
