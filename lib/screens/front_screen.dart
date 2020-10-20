import 'package:church_locator/models/dummy_churches.dart';
import 'package:church_locator/screens/filter_screen.dart';
import 'package:church_locator/screens/search_result_screen.dart';
import 'package:church_locator/services/auths_services.dart';
import 'package:church_locator/utilities/nav_drawer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../map.dart';
import 'package:flutter/material.dart';

class FrontPageScreen extends StatefulWidget {
  static const String routeName = '/frontScreen';
  @override
  _FrontPageScreenState createState() => _FrontPageScreenState();
}

class _FrontPageScreenState extends State<FrontPageScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    print(status);
    return Scaffold(
      // drawer: NavDrawer(
      //   imageUrl: '',
      // ),
      body: status == true
          ? SecondViewScreen()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(top: 30.0),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlutterSwitch(
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
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 100.0,
                    ),
                    child: Image.asset(
                      "assets/images/logoicon.png",
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(11, 8, 5, 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      border: Border.all(width: 1.0, color: Colors.white),
                    ),
                    margin: EdgeInsets.all(30.0),
                    child: TextFormField(
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
                        suffixIcon: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          child: Container(
                            height: 65.0,
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
                  Text(
                    "Find A Church",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    padding: EdgeInsets.all(30.0),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    child: GridView.builder(
                      itemCount: dummyChurches.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 20.0),
                      itemBuilder: (context, index) {
                        if (index == null) {
                          return SizedBox(
                            width: 10.0,
                          );
                        }
                        return GestureDetector(
                          onTap: () => '',
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    dummyChurches[index],
                                  ),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class SecondViewScreen extends StatefulWidget {
  bool status = false;
  @override
  _SecondViewScreenState createState() => _SecondViewScreenState();
}

class _SecondViewScreenState extends State<SecondViewScreen> {
  final _key = GlobalKey<FormState>();
  String _churchName, _location, _fullAddress, _community, _lga;
  bool _isLoading = false;
  bool status = false;

  _onSubmitted() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final result = await AuthServices.searchChurch(
            _churchName, _location, _fullAddress);
        if (result.length != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SearchResultScreen(
                    churches: result,
                  )));

          setState(() {
            _isLoading = false;
          });
        }
      } catch (error) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status == true
          ? FrontPageScreen()
          : Stack(
              children: <Widget>[
                Map(),
                Positioned(
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                  child: Form(
                    key: _key,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    status = true;
                                  });
                                },
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 80.0,
                            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Image.asset("assets/images/logoicon.png"),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 220.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                margin: EdgeInsets.only(
                                  right: 5.0,
                                  left: 10.0,
                                ),
                                child: TextFormField(
                                  validator: (input) => input.trim().isEmpty
                                      ? 'Please enter church name'
                                      : null,
                                  onSaved: (input) => _churchName = input,
                                  decoration: InputDecoration(
                                    labelText: "Church Name",
                                    contentPadding: EdgeInsets.only(left: 10.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    validator: (input) => input.trim().isEmpty
                                        ? 'Church location is required'
                                        : null,
                                    onSaved: (input) => _location = input,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 10.0),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          "assets/images/hotspot.png",
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                      ),
                                      labelText: "State",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            margin: EdgeInsets.only(
                              right: 5.0,
                              left: 10.0,
                            ),
                            child: TextFormField(
                              onSaved: (input) => _fullAddress = input,
                              decoration: InputDecoration(
                                labelText: "Full Address (Optional)",
                                contentPadding: EdgeInsets.only(left: 10.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 220.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                margin: EdgeInsets.only(
                                  right: 5.0,
                                  left: 10.0,
                                ),
                                child: TextFormField(
                                  onSaved: (input) => _community = input,
                                  decoration: InputDecoration(
                                    labelText: "Community (Optional)",
                                    contentPadding: EdgeInsets.only(left: 10.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    onSaved: (input) => _lga = input,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 10.0),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Image.asset(
                                          "assets/images/hotspot.png",
                                          width: 20.0,
                                          height: 20.0,
                                        ),
                                      ),
                                      labelText: "LGA (Optional)",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                // width: 220.0,
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     width: 1.0,
                                //     color: Colors.grey,
                                //   ),
                                //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                // ),
                                margin: EdgeInsets.only(
                                  right: 5.0,
                                  left: 10.0,
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(color: Colors.orange),
                                  ),
                                  color: Colors.orange,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Search",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 80.0,
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: _onSubmitted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
