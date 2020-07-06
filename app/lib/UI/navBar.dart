import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:voluntarios/db_connect/databaseConnection.dart' as database;
import 'home.dart';
import 'yourEvents.dart';
import './profile.dart';
import 'createEvent.dart';
import 'organizationTab.dart';

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);
  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  final dbHelper = database.DatabaseHelper.instance;
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      Home(),
      CreateEvent(),
      OrganizationTab(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    _consultarEventos();
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: Colors.lightGreen[300],
        inactiveColor: Colors.white,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.event_note),
        title: ("Eventos"),
        activeColor: Colors.lightGreen[300],
        inactiveColor: Colors.white,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.business),
        title: ("Organização"),
        activeColor: Colors.lightGreen[300],
        inactiveColor: Colors.white,
        isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Perfil"),
        activeColor: Colors.lightGreen[300],
        inactiveColor: Colors.white,
        isTranslucent: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        navBarStyle: NavBarStyle.style3,
        controller: _controller,
        screens: _buildScreens(),
        items:
            _navBarsItems(), // Redundant here but defined to demonstrate for other than custom style
        confineInSafeArea: true,
        backgroundColor: Colors.cyan[700],
        handleAndroidBackButtonPress: true,
        onItemSelected: (int) {
          setState(
              () {}); // This is required to update the nav bar if Android back button is pressed
        },
        itemCount: 4, // Choose the nav bar style with this property
      ),
    );
  }

  void _consultarEventos() async {
    final todasEventos = await dbHelper.queryAllRows();
    print('Consulta todos os eventos:');
    todasEventos.forEach((row) => print(row));
  }
}
