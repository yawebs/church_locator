import 'package:cached_network_image/cached_network_image.dart';
import 'package:church_locator/home_screen.dart';
import 'package:church_locator/screens/front_screen.dart';
import 'package:church_locator/utilities/routes.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final String imageUrl;
  NavDrawer({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Manage,Organize,Edit Profile',
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              // image: DecorationImage(
              //   image: AssetImage('assets/images/4.jpg'),
              //   fit: BoxFit.fill,
              // ),
            ),
          ),
          ListTile(
            onTap: () => '',
            leading: Icon(
              Icons.filter,
              color: Colors.orange,
            ),
            title: Text('Uploads'),
          ),
          ListTile(
            onTap: () => '',
            leading: Icon(
              Icons.verified_user,
              color: Colors.orange,
            ),
            title: Text('Status'),
          ),
          ListTile(
            onTap: () => '',
            leading: Icon(
              Icons.add,
              color: Colors.orange,
            ),
            title: Text('Add Church'),
          ),
          ListTile(
            onTap: () => '',
            leading: Icon(
              Icons.report,
              color: Colors.orange,
            ),
            title: Text('Report User'),
          ),
          ListTile(
            onTap: () => '',
            leading: Icon(
              Icons.notifications_active,
              color: Colors.orange,
            ),
            title: Text('Notification'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyHomePageScreen(),
              ),
            ),
            leading: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            title: Text('Search Church'),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.report_problem,
              color: Colors.orange,
            ),
            title: Text('Report Location'),
          ),
        ],
      ),
    );
  }
}
