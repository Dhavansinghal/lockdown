import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lockdown/district_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

getTotalCount () async{
  var url = 'https://api.covid19india.org/data.json';
  var fetchTotalData = await Dio().get(url);
  return fetchTotalData.data;
}

class _HomePageState extends State<HomePage> {
  final double _borderRadius = 24;
  Color primaryColor = Color(0xff0074ff);

  var totalData = getTotalCount();

  var colors = [
    {"start":Color(0xff6DC8F3), "end":Color(0xff73A1F9)},
    {"start":Color(0xffFFB157), "end":Color(0xffFFA057)},
    {"start":Color(0xffFF5B95), "end":Color(0xffF8556D)},
    {"start":Color(0xffD76EF5), "end":Color(0xff8F7AFE)},
    {"start":Color(0xff42E695), "end":Color(0xff3BB2B8)},
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: totalData,
        builder: (context,snapshot) {
          var i = 0;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data["statewise"].length - 1,
              itemBuilder: (context, index) {
                var total = int.parse(snapshot.data["statewise"][index+1]["confirmed"]);
                var death = int.parse(snapshot.data["statewise"][index+1]["deaths"]);
                var active = int.parse(snapshot.data["statewise"][index+1]["active"]);
                var cured = int.parse(snapshot.data["statewise"][index+1]["recovered"]);
                var lastupdateDate = snapshot.data["statewise"][index+1]["lastupdatedtime"].split(" ")[0];

                if (i > 3){
                  i = 0;
                }
                else {
                  i = i + 1;
                }
                return GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context) => DistrctScreen(state:snapshot.data["statewise"][index+1]["state"]),
                    ));
                  },
                  child:Center(
                    child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            gradient: LinearGradient(colors: [
                              colors[i]["start"],
                              colors[i]["end"]
                            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                            boxShadow: [
                              BoxShadow(
                                color: colors[i]["end"],
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: CustomPaint(
                            size: Size(100, 150),
                            painter: CustomCardShapePainter(_borderRadius,
                                colors[i]["start"], colors[i]["end"]),
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(''),
                                flex: 1,
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data["statewise"][index+1]["state"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Total : '+ total.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.accessibility_new,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Cured : '+ cured.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.airline_seat_individual_suite,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Death : '+ death.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.watch,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Last Update : '+ lastupdateDate.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      active.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                          fontSize: 23,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'Active Cases',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      );

  }
}

class ColorInfo {
  final Color startColor;
  final Color endColor;

  ColorInfo(this.startColor, this.endColor);

}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}