import 'dart:async';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sisterhood_app/icons.dart';
import 'package:sisterhood_app/screen/Dashboard/drawer_page.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/profile_page.dart';
import 'package:sisterhood_app/screen/Dashboard/sos/sos.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Home/homeScreen.dart';
/// persistent navigation bar ////////////////////////////

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return const Text('');
      }
    }

    _launchURLApp() async {
      const url = 'https://www.sosalarm.se/spraklanguages/english/sms112-english/';
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: true, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    _callNowApp(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launch(launchUri.toString());
    }


    List<Widget> _buildScreens() {
      return [
        HomePage(),
        ProfilePage(),
        SOSPage()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_rounded),
          title: (Strings.home),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_outlined,),
          title: (Strings.profile),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.panorama_fish_eye,),
          title: (Strings.sos),
          onPressed: (c)=> _callNowApp("112"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
      backgroundColor: ColorResources.background,

      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorResources.background, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          boxShadow: const[BoxShadow(
            color: Colors.grey,
            blurStyle: BlurStyle.solid,
            // offset: Offset.zero,
            blurRadius: 0.1,
          ),],
          borderRadius: BorderRadius.circular(0.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
