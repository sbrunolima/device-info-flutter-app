import 'package:flutter/material.dart';
import "package:system_info/system_info.dart";

class ProcessorWidget extends StatefulWidget {
  @override
  State<ProcessorWidget> createState() => _ProcessorWidgetState();
}

class _ProcessorWidgetState extends State<ProcessorWidget> {
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
        color: Colors.orangeAccent,
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
                Text(processorVendor),
                Text(processorName),
                Text(processorArchitecture),
                Text(processorCores),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
