import 'package:flutter/material.dart';
import 'package:lockdown/home_page.dart';
import 'package:dio/dio.dart';

void main() => runApp(MaterialApp(
  home:LockdownHome(),
));

Color primaryColor = Color(0xff0074ff);

class LockdownHome extends StatelessWidget {
  const LockdownHome({Key key}) : super(key: key);

  getTotalCount () async{
    var url = 'https://api.covid19india.org/data.json';
    var fetchTotalData = await Dio().get(url);
    return fetchTotalData.data;
  }

  @override
  Widget build(BuildContext context) {
    var totalData = getTotalCount();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomBar(),
      body: FutureBuilder(
        future: totalData,
        builder: (context,snapshot){
          if (snapshot.hasData){
            var death = int.parse(snapshot.data["statewise"][0]["deaths"]);
            var active = int.parse(snapshot.data["statewise"][0]["active"]);
            var total = int.parse(snapshot.data["statewise"][0]["confirmed"]);
            var cured = int.parse(snapshot.data["statewise"][0]["recovered"]);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 170,
                                    height: 115,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(colors: [
                                        Color(0xff6DC8F3),
                                        Color(0xff73A1F9)
                                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff73A1F9),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('img/icon-infected.png'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          total.toString() ,
                                          style: TextStyle(
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 25
                                          ),
                                        ),
                                        Text(
                                          'Total Cases',
                                          style: TextStyle(
                                              fontFamily: 'IndieFlower',
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 21
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    height: 115,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(colors: [
                                        Color(0xffFFB157),
                                        Color(0xffFFA057)
                                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffFFA057),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('img/icon-infected.png'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          active.toString(),
                                          style: TextStyle(
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 25
                                          ),
                                        ),
                                        Text(
                                          'Active Cases',
                                          style: TextStyle(
                                              fontFamily: 'IndieFlower',
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 21
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 170,
                                    height: 115,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(colors: [
                                        Color(0xff42E695),
                                        Color(0xff3BB2B8)
                                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff3BB2B8),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('img/icon-active.png'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          cured.toString(),
                                          style: TextStyle(
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 25
                                          ),
                                        ),
                                        Text(
                                          'Cured',
                                          style: TextStyle(
                                              fontFamily: 'IndieFlower',
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 21
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    height: 115,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(colors: [
                                        Color(0xffFF5B95),
                                        Color(0xffF8556D)
                                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffF8556D),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('img/icon-inactive.png'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          death.toString(),
                                          style: TextStyle(
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 25
                                          ),
                                        ),
                                        Text(
                                          'Total Deaths',
                                          style: TextStyle(
                                              fontFamily: 'IndieFlower',
                                              color:Color.fromRGBO(0,44,86,1),
                                              fontSize: 21
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child:HomePage(),
                ),
              ],
            );
          }
          else {
            return Text(snapshot.data.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('COVID-19'),
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
        padding: const EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Icon(
              Icons.tag_faces,
              color: Colors.grey,
              size: 16,
            ),
            Text(
              'Stay Home Stay Safe',
              style: TextStyle(
                  fontFamily: 'IndieFlower',
                  color:Color.fromRGBO(0,44,86,1),
                  fontSize: 50
              )
            ),
            Icon(
              Icons.tag_faces,
              color: Colors.grey,
              size: 16,
            ),



          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context,dynamic totalData) {
    print("Dataa :"+totalData);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 170,
                            height: 115,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xff6DC8F3),
                                Color(0xff73A1F9)
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff73A1F9),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('img/icon-infected.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'total' ,
                                  style: TextStyle(
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 25
                                  ),
                                ),
                                Text(
                                  'Total Cases',
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 21
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 170,
                            height: 115,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xffFFB157),
                                Color(0xffFFA057)
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffFFA057),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('img/icon-infected.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  '2650',
                                  style: TextStyle(
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 25
                                  ),
                                ),
                                Text(
                                  'Active Cases',
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 21
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 170,
                            height: 115,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xff42E695),
                                Color(0xff3BB2B8)
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff3BB2B8),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('img/icon-active.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  '183',
                                  style: TextStyle(
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 25
                                  ),
                                ),
                                Text(
                                  'Cured/Discharged',
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 21
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 170,
                            height: 115,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color(0xffFF5B95),
                                Color(0xffF8556D)
                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffF8556D),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('img/icon-inactive.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  '68',
                                  style: TextStyle(
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 25
                                  ),
                                ),
                                Text(
                                  'Total Deaths',
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color:Color.fromRGBO(0,44,86,1),
                                      fontSize: 21
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child:HomePage(),
        ),
      ],
    );
  }
}