import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';

//Widgets
import '../widgets/card_titles_widget.dart';

class BatteryWidget extends StatefulWidget {
  @override
  State<BatteryWidget> createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    const sizedBox = SizedBox(height: 5);
    return FutureBuilder<AndroidBatteryInfo?>(
      future: BatteryInfoPlugin().androidBatteryInfo,
      builder: (context, snapshot) {
        final batteryPercent = snapshot.data!.batteryLevel! / 100;
        if (snapshot.hasData) {
          return Container(
            width: mediaQuery,
            child: Card(
              color: Colors.white24,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Image.asset(
                        'assets/battery.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardTitlesWidget(
                          title: 'Battery',
                          isTitle: true,
                        ),
                        sizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LinearPercentIndicator(
                              lineHeight: 6,
                              width: 250,
                              percent: batteryPercent,
                              animation: true,
                              animationDuration: 2500,
                              progressColor: Colors.white,
                              backgroundColor: Colors.black12,
                              barRadius: const Radius.circular(16),
                            ),
                            Text(
                              '${snapshot.data!.batteryLevel}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                        sizedBox,
                        snapshot.data!.chargingStatus != ChargingStatus.Charging
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CardTitlesWidget(
                                        title:
                                            'Voltage: ${(snapshot.data!.voltage)}mV,',
                                        isTitle: false,
                                      ),
                                      CardTitlesWidget(
                                        title:
                                            'Temp: ${(snapshot.data!.temperature)}°C',
                                        isTitle: false,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : CardTitlesWidget(
                                title:
                                    'Charge time: ${(snapshot.data!.chargeTimeRemaining! / 1000 / 60).truncate()} minutes',
                                isTitle: false,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Text('Loading...');
      },
    );
  }
}