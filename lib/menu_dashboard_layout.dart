import 'package:flutter/material.dart';
import 'package:lockdown/main.dart';
import 'package:lockdown/home_page.dart';


final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context) => LockdownHome(),
                          ));
                    },
                    child: Text(
                        "Dashboard",
                        style: TextStyle(color: Colors.white, fontSize: 22))),
                SizedBox(height: 10),
                Text("Messages", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Utility Bills", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Funds Transfer", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 10),
                Text("Branches", style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("My Cards", style: TextStyle(fontSize: 24, color: Colors.white)),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 150,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.6),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
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
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('img/icon-infected.png'),
                                  ),
                                ),
                              ),
                              Text(
                                "4051" ,
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
//                              color: Color.fromRGBO(245,206,103, 1),
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
                                "200",
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
                                "5000",
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
                                "01",
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
                  ),
                  SizedBox(height: 20),
                  Text("Transactions", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Macbook"),
                          subtitle: Text("Apple"),
                          trailing: Text("-2900"),
                        );
                      }, separatorBuilder: (context, index) {
                    return Divider(height: 16);
                  }, itemCount: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}