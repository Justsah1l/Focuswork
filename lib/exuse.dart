import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fl_chart/fl_chart.dart';

class AppUsageApp extends StatefulWidget {
  @override
  AppUsageAppState createState() => AppUsageAppState();
}

class AppUsageAppState extends State<AppUsageApp> {
  List<AppUsageInfo> _infos = [];
  List<AppUsageInfo> _einfos = [];
  List<FlSpot> _spots = [];

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
    getUsageStats();
    // egetUsageStats();
  }

  Future<void> egetUsageStats() async {
    try {
      DateTime now = DateTime.now();
      DateTime endDate = now;
      // Subtract the current hour as a duration
      DateTime startDate = endDate.subtract(Duration(hours: 2));

      print("Getting usage from: $startDate to $endDate");

      List<AppUsageInfo> iinfoList = await AppUsage().getAppUsage(
        startDate,
        endDate,
      );
      setState(() => _einfos = iinfoList);
      print(
        "herere --------------------------------------------------------------------------------------------",
      );
      print("All apps:");
      for (var info in iinfoList) {
        print(info);
      }
    } catch (exception) {
      print(exception);
    }
  }

  Future<void> getUsageStats() async {
    try {
      final istNow = DateTime.now().toUtc().add(
        const Duration(hours: 5, minutes: 30),
      );

      final istStart = istNow.subtract(const Duration(hours: 20));

      final utcStart = istStart.subtract(const Duration(hours: 5, minutes: 30));
      final utcEnd = istNow.subtract(const Duration(hours: 5, minutes: 30));

      print("IST range: $istStart to $istNow");
      print("Sending to getAppUsage: $utcStart to $utcEnd");

      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(
        utcStart,
        utcEnd,
      );
      print(
        "herere --------------------------------------------------------------------------------------------",
      );
      print("All apps:");
      for (var info in infoList) {
        print(info);
      }

      infoList.sort((a, b) => b.usage.inMinutes.compareTo(a.usage.inMinutes));

      setState(() {
        _infos = infoList.take(5).toList();
        _spots = [
          FlSpot(0, 0),
          ...List.generate(infoList.length, (i) {
            return FlSpot(
              (i + 1).toDouble(),
              infoList[i].usage.inMinutes.toDouble(),
            );
          }),
        ];
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              int index = value.toInt() - 1;
              if (index >= 0 && index < _infos.length) {
                final app = _infos[index];
                String displayName =
                    app.appName.toLowerCase() == 'android'
                        ? (app.packageName.contains('instagram')
                            ? 'Instagram'
                            : 'Unknown')
                        : app.appName;
                return Text(
                  displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Circular",
                  ),
                );
              } else {
                return const Text('');
              }
            },

            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 30,
            getTitlesWidget: (value, meta) {
              int minutes = value.toInt();

              if (minutes == 0) {
                return const Text(
                  '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Circular",
                  ),
                );
              }

              if (minutes % 60 != 0) return const SizedBox.shrink();

              int hours = minutes ~/ 60;
              String label = '$hours hr';

              return SizedBox(
                width: 40,
                child: Text(
                  label,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Circular",
                  ),
                ),
              );
            },
          ),
        ),

        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: 5,

      minY: 0,
      maxY:
          _spots.isNotEmpty
              ? _spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 10
              : 60,
      lineBarsData: [
        LineChartBarData(
          spots: _spots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 2,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((c) => c.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Text(
              "Top 5 apps usage from last 24 hours",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Circular",
                height: 1.2,
              ),
            ),
          ),
          SizedBox(height: 20),
          _spots.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(),
                child: LineChart(mainData()),
              ),
        ],
      ),
    );
  }
}
