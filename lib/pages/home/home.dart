import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  final String currentAddress;
  Home({this.currentAddress});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> children = [];

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            Expanded(
              flex: 5,
              child: ListTile(
                isThreeLine: false,
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.greenAccent),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 4.0,
                          ),
                          child: Text(
                            "Home",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2),
                          )),
                      Icon(
                        MdiIcons.chevronDown,
                        color: Colors.greenAccent,
                      ),
                    ]),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    widget.currentAddress,
                    style: Theme.of(context).textTheme.button.copyWith(
                        fontWeight: FontWeight.normal, letterSpacing: 1.2),
                    maxLines: 1,
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              child: ListTile(
                onTap: () {},
                leading: Icon(
                  MdiIcons.sale,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.local_offer),
              ),
              flex: 1,
            ),
          ]),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    
                  },
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14.0,
          unselectedFontSize: 14.0,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Cart")),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.account), title: Text("Profile")),
          ]),
    );
  }
}
