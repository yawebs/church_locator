import 'package:church_locator/home_screen.dart';
import 'package:church_locator/screens/add_church_screen.dart';
import 'package:church_locator/screens/church_details_screen.dart';
import 'package:church_locator/screens/edit_profile_screen.dart';
import 'package:church_locator/screens/filter_churches.screen.dart';
import 'package:church_locator/screens/filter_screen.dart';
import 'package:church_locator/screens/front_screen.dart';
import 'package:church_locator/screens/login_screen.dart';
import 'package:church_locator/screens/search_result_screen.dart';
import 'package:church_locator/screens/signup_screen.dart';
import 'package:church_locator/screens/stories.screen.dart';
import 'package:church_locator/states/app_state.dart';
import 'package:church_locator/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AppState())],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePageScreen(),
        routes: {
          SignupScreen.pageRoute: (context) => SignupScreen(),
          LoginScreen.pageRoute: (context) => LoginScreen(),
          ChurchDetailsScreen.routeName: (context) => ChurchDetailsScreen(),
          StoriesScreen.routeName: (context) => StoriesScreen(),
          AddChurchScreen.routeName: (context) => AddChurchScreen(),
          FilterScreen.routeName: (context) => FilterScreen(),
          SearchResultScreen.routName: (context) => SearchResultScreen(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
          FrontPageScreen.routeName: (context) => FrontPageScreen(),
        },
      ),
    );
  }
}
