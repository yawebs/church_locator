import 'package:church_locator/models/result_dummy_model.dart';
import 'package:church_locator/screens/filter_churches.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../models/dummy_churches.dart';
import 'dart:math';

import 'filter_screen.dart';

class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _NewHomePageState extends State<NewHomePage> {
  var currentPage = dummyChurches.length - 1.0;
  PageController controller;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: dummyChurches.length + 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    print(currentPage);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: status ? Colors.white : Colors.black,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 25.0,
                          child: FlutterSwitch(
                            activeColor: Colors.black,
                            inactiveColor: Colors.orange,
                            activeText: '',
                            inactiveText: '',
                            value: status,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(top: 30.0),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                        ),
                        child: Text(
                          'Find a Church',
                          style: TextStyle(
                            color: status ? Colors.black : Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        top: 30,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: status
                                ? Color.fromRGBO(232, 232, 232, 1)
                                : Color.fromRGBO(77, 74, 74, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            // border: Border.all(width: 1.0, color: Colors.white),
                          ),
                          margin: EdgeInsets.all(30.0),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => Navigator.of(context)
                                .pushNamed(FilterScreen.routeName),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Image.asset(
                                  "assets/images/hotspot.png",
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                              labelText: "Search Church",
                              labelStyle: TextStyle(
                                  color: status ? Colors.black : Colors.white),
                              suffixIcon: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0)),
                                child: Container(
                                  height: 60.0,
                                  color: Colors.orange,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.0,
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Text("Popular",
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 46.0,
                        //       letterSpacing: 1.0,
                        //     )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.0, vertical: 6.0),
                              child: Text("Churches",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "50000+ churches",
                          style: TextStyle(
                            color: status ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      CardScrollWidget(
                        currentPage,
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FilterChurchesScreen(
                                        churchIp: currentPage,
                                      ))),
                          child: PageView.builder(
                            itemCount: dummyChurches.length,
                            controller: controller,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Container();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardScrollViewWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;
  CardScrollViewWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: cardAspectRatio,
      child: LayoutBuilder(
        builder: (context, contraint) {
          var width = contraint.maxWidth;
          var height = contraint.maxHeight;
          var safeWidth = width - 2 * padding;
          var safeHight = height - 2 * padding;

          var heightOfPrimaryCard = safeHight;
          var widthofPrimaryCard = heightOfPrimaryCard * cardAspectRatio;
          var primaryCardLeft = safeWidth * widthofPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < dummyChurches.length; i++) {
            var delta = i - currentPage;
            bool isRight = delta > 0;
            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isRight ? 5 : 0),
                    0.0);
            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 1.0),
              bottom: padding + verticalInset * max(-delta, 1.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: Container(
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        dummyChurches[i],
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < dummyChurches.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(dummyChurches[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                title[i],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text("Get Location",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
