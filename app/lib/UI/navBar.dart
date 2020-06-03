import 'package:flutter/material.dart';
import './home.dart';
import './events.dart';
import './profile.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => _NavBar();
}

// SingleTickerProviderStateMixin is used for animation
class _NavBar extends State<NavBar> with SingleTickerProviderStateMixin {
  /*
   *-------------------- Setup Tabs ------------------*
   */
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          // set icon to the tab
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.calendar_today),
        ),
        Tab(
          icon: Icon(Icons.person),
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  Widget getAppBar(){
    return AppBar(
          // Title
            title: Text("Voluntários"),
            // Set the background color of the App Bar
            backgroundColor: Colors.orange,
            // Set the bottom property of the Appbar to include a Tab Bar
            bottom: getTabBar());
        // Set the TabBar view as the body of the Scaffold
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
        appBar: getAppBar(),
        body: getTabBarView(<Widget>[Home(), Events(), Profile()]));
  }
}