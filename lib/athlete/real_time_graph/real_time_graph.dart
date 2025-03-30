import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

import '../../shared/color.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);




  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  int _displayText = 0;
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _streamSubscription;
  ScreenshotController controller = ScreenshotController();
  // int count=0;
  GlobalKey repaintKey=  GlobalKey();



  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(milliseconds: 500), updateDataSource);
    _activateListeners();
    super.initState();

  }
  void _activateListeners() async{
    _streamSubscription = _database.child("Signals2").onValue.listen((event) {
      final Object description = event.snapshot.value ??0;
      setState((){
        _displayText = int.parse('$description');
        print (_displayText);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return  RepaintBoundary(
      key: repaintKey,
      child: SfCartesianChart(

          series: <LineSeries<LiveData, int>>[

            LineSeries<LiveData, int>(
              onRendererCreated: (ChartSeriesController controller) {
                _chartSeriesController = controller;
              },
              dataSource: chartData,
              color: mainColor,
              xValueMapper: (LiveData sales, _) => sales.time,
              yValueMapper: (LiveData sales, _) => sales.speed,
            )
          ],
          primaryXAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              interval: 3,
              title: AxisTitle(text: 'Time (seconds)')),
          primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              title: AxisTitle(text: 'emg detector (HZ)'))),
    );
  }

  int time = 19;
  Future<void> updateDataSource(Timer timer) async {
    chartData.add(LiveData(time++, _displayText));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);



  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 0),
      LiveData(2, 0),
      LiveData(3, 0),
      LiveData(4, 0),
      LiveData(5, 0),
      LiveData(6, 0),
      LiveData(7, 0),
      LiveData(8, 0),
      LiveData(9, 0),
      LiveData(10, 0),
      LiveData(11, 0),
      LiveData(12, 0),
      LiveData(13, 0),
      LiveData(14, 0),
      LiveData(15, 0),
      LiveData(16, 0),
      LiveData(17, 0),
      LiveData(18, 0)
    ];
  }

  @override
  void deactivate(){
    _streamSubscription.cancel();
    super.deactivate();
  }


}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final int speed;
}