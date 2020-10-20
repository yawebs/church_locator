import 'package:church_locator/screens/search_result_screen.dart';
import 'package:church_locator/services/auths_services.dart';
import '../map.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static final String routeName = '/filterscreen';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _key = GlobalKey<FormState>();
  String _churchName, _location, _fullAddress, _community, _lga;
  bool _isLoading = false;

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                    ),
                    Positioned(
                      top: 150.0,
                      left: 20.0,
                      right: 20.0,
                      child: Form(
                        key: _key,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 80.0,
                                margin:
                                    EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child:
                                    Image.asset("assets/images/logoicon.png"),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
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
                                        contentPadding:
                                            EdgeInsets.only(left: 10.0),
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
                                        validator: (input) =>
                                            input.trim().isEmpty
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 5.0,
                                      left: 10.0,
                                    ),
                                    child: TextFormField(
                                      onSaved: (input) => _community = input,
                                      decoration: InputDecoration(
                                        labelText: "Community (Optional)",
                                        contentPadding:
                                            EdgeInsets.only(left: 10.0),
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
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
