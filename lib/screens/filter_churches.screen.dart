import 'package:cached_network_image/cached_network_image.dart';
import 'package:church_locator/services/auths_services.dart';
import 'package:flutter/material.dart';

import 'church_details_screen.dart';

class FilterChurchesScreen extends StatefulWidget {
  static final String routeName = '/filterChurchScreen';
  final double churchIp;
  FilterChurchesScreen({@required this.churchIp, Key key}) : super(key: key);
  @override
  _FilterChurchesScreenState createState() => _FilterChurchesScreenState();
}

class _FilterChurchesScreenState extends State<FilterChurchesScreen> {
  String churchName;
  List _churches = [];
  bool isLoading = false;
  int _display = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setChurchName();
    getChurch();
  }

  getChurch() async {
    setState(() {
      isLoading = true;
    });
    List churches = await AuthServices.getChurch(churchName);
    setState(() {
      _churches = churches;
    });
    if (_churches != []) {
      setState(() {
        isLoading = false;
      });
    }
  }

  setChurchName() {
    if (widget.churchIp == 5.0) {
      setState(() {
        churchName = 'Christ Embassy';
      });
    } else if (widget.churchIp == 4.0) {
      setState(() {
        churchName = 'hiltop';
      });
    } else if (widget.churchIp == 3.0) {
      setState(() {
        churchName = 'house on the rock';
      });
    } else if (widget.churchIp == 2.0) {
      setState(() {
        churchName = 'redeemed Christian Church';
      });
    } else if (widget.churchIp == 1.0) {
      setState(() {
        churchName = 'Salvation Ministries';
      });
    } else if (widget.churchIp == 0.0) {
      setState(() {
        churchName = 'LIVING FAITH CHURCH';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_churches);

    return Scaffold(
        key: widget.key,
        body: Scaffold(
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: Container(
                          width: double.infinity,
                          height: 80.0,
                          margin: EdgeInsets.only(left: 10.0, top: 30.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "${_churches.length} results found",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 20.0),
                                    width: 35.0,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.grid_on,
                                        color: _display == 1
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _display = 1;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 10.0),
                                    width: 35.0,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.list,
                                        color: _display == 0
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _display = 0;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 10.0),
                                    width: 35.0,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.location_on,
                                        color: _display == 2
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _display = 2;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.all(5.0),
                        child: _display == 0
                            ? ListView.builder(
                                itemCount: _churches.length,
                                itemBuilder: (context, index) {
                                  if (index == null) {
                                    return SizedBox.shrink();
                                  }

                                  return GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChurchDetailsScreen(
                                        churches: _churches,
                                        id: _churches[index]['id'],
                                      ),
                                    )),
                                    child: Card(
                                      elevation: 10.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: 350,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl: _churches[index]
                                                  ['churchImage'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.all(10.0),
                                            margin: EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              _churches[index]['churchName'],
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 20.0),
                                            padding: EdgeInsets.all(7.0),
                                            width: 50.0,
                                            height: 30.0,
                                            color: Colors.blue,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    '${_churches.length}',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2.0,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.orange,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    _churches[index]
                                                        ['churchAddress'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5.0, left: 20.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.timelapse,
                                                  color: Colors.orange,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                    "${_churches[index]['churchLocation']}")
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 30.0,
                                            margin: EdgeInsets.only(
                                                top: 5.0, left: 20.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.black,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text('${_churches.length}')
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1.0,
                                  childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                      (MediaQuery.of(context).size.height / 1),
                                  crossAxisSpacing: 1.0,
                                ),
                                itemCount: _churches.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: _buildGridTile(
                                        _churches, index, context),
                                  );
                                }),
                      )
                    ],
                  ),
                ),
        ));
  }
}

_buildGridTile(List churches, int index, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => ChurchDetailsScreen(
        churches: churches,
        id: churches[index]['id'],
      ),
    )),
    child: churches.length == 0
        ? Center(
            child: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Text(
                    'No Results Where Found',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: churches[index]['churchImage'],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(churches[index]['churchName']),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 5.0),
                  padding: EdgeInsets.all(7.0),
                  width: 50.0,
                  height: 30.0,
                  color: Colors.blue,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${churches.length}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        churches[index]['churchAddress'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timelapse,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        churches[index]['churchLocation'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        "${churches.length}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
  );
}
