import 'package:flutter/material.dart';
import "package:system_info/system_info.dart";
import 'package:percent_indicator/percent_indicator.dart';
import 'package:enefty_icons/enefty_icons.dart';

class RamWidget extends StatefulWidget {
  @override
  State<RamWidget> createState() => _RamWidgetState();
}

class _RamWidgetState extends State<RamWidget> {
  String ramPercent = '';
  int usedRam = 0;
  double indicatorPercent = 0;
  static int MEGABYTE = 1024 * 1024;

  @override
  void initState() {
    super.initState();
    calculateRamPercent();
  }

  void calculateRamPercent() {
    var _totalRam = SysInfo.getVirtualMemorySize();
    var _freeRam = SysInfo.getFreeVirtualMemory();
    var _percentStepOne = (_freeRam / _totalRam) * 100;
    var _percentStepTwo = 100 - _percentStepOne;
    setState(() {
      ramPercent = _percentStepTwo.toStringAsFixed(0).toString();
      indicatorPercent = _percentStepTwo / 100;
      usedRam = _totalRam - _freeRam;
    });
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(EneftyIcons.a_3d_cube_bold,
                          color: Colors.white, size: 20),
                      Text(
                        'RAM - ${SysInfo.getVirtualMemorySize() ~/ MEGABYTE}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'MB Total',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  CircularPercentIndicator(
                    radius: 50,
                    percent: indicatorPercent,
                    progressColor: Colors.white,
                    backgroundColor: Colors.black26,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 1500,
                    lineWidth: 5,
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ramPercent,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 35,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            '%',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 2),
                  Container(
                    height: 80,
                    width: 160,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              EneftyIcons.a_3d_cube_bold,
                              color: Colors.red,
                              size: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Used - ${usedRam ~/ MEGABYTE}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  'MB',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              EneftyIcons.a_3d_cube_bold,
                              color: Colors.green,
                              size: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Free - ${SysInfo.getFreeVirtualMemory() ~/ MEGABYTE}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  'MB',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
