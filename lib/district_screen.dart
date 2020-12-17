import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Color primaryColor = Color(0xff0074ff);

class DistrctScreen extends StatelessWidget {
  final String state;
  const DistrctScreen({Key key,@required this.state}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomBar(),
      body: _districtList(state),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(state),
      backgroundColor: primaryColor,
      elevation: 0,
      actions: <Widget>[
        Container(
          width: 100,
          alignment: Alignment.center,
          child: Text('Stay Home, Stay Safe'),
        ),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('img/Dhavan.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.label_outline,
              size: 35,
              color: primaryColor,
            ),
            Icon(
              Icons.ac_unit,
              color: Colors.grey,
              size: 30,
            ),
            Icon(
              Icons.tune,
              size: 30,
              color: Colors.grey,
            ),
            Icon(
              Icons.perm_identity,
              color: Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  getTotalCount () async{
    var url = 'https://api.covid19india.org/state_district_wise.json';
    var fetchTotalData = await Dio().get(url);

    var urlColor = 'https://api.covid19india.org/zones.json';
    var fetchColorData = await Dio().get(urlColor);
    var data = {
      "CaseData": fetchTotalData.data,
      "ColorData": fetchColorData.data
    };
    return data;
  }


  Widget _districtList(String state) {
    final double _borderRadius = 24;

    var totalData = getTotalCount();


    var colors = {
      "Orange":{"start": Color(0xffFFB157), "end": Color(0xffFFA057)},
      "Red":{"start": Color(0xffFF5B95), "end": Color(0xffF8556D)},
      "Green":{"start": Color(0xff42E695), "end": Color(0xff3BB2B8)},
    };

    return FutureBuilder(
        future: totalData,
        builder: (context,snapshot) {

          if (snapshot.hasData) {
            var CaseData = snapshot.data["CaseData"];
            var ColorData = snapshot.data["ColorData"];

            return ListView.builder(

              itemCount: CaseData[state]["districtData"].length,
              itemBuilder: (context, index) {

                var districtData = CaseData[state]["districtData"].values.toList()[index];
                var districtName  = CaseData[state]["districtData"].keys.toList()[index];

                var total = districtData["confirmed"];
                var active = districtData["active"];
                var death = districtData["deceased"];
                var cured = districtData["recovered"];

                var colorIn = ColorData["zones"].indexWhere((x) => x["district"] == districtName);

                var colorName = ColorData["zones"][colorIn]["zone"];

                return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(_borderRadius),
                              gradient: LinearGradient(colors: [
                                colors[colorName]["start"],
                                colors[colorName]["end"]
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: colors[colorName]["end"],
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
                                  colors[colorName]["start"], colors[colorName]["end"]),
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
                                        districtName.toString(),
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
                                            size: 16,
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
                                                  fontSize: 18,
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
                                            size: 16,
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
                                                  fontSize: 18,
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
                                            size: 16,
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
                                                  fontSize: 18,
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
                                            fontSize: 15,
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
                  );

              },
            );
          }
          return Center(
            child:CircularProgressIndicator(),
          );
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