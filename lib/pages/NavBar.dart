import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/pages/NavBar/favouritePage.dart';
import 'package:my_app/pages/NavBar/post.dart';
import 'package:my_app/pages/NavBar/Home_page.dart';
import 'package:my_app/pages/NavBar/profilePage.dart';
import 'package:my_app/pages/NavBar/settingsPage.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  final List _pages = [
    HomePage(),
    FavouritePage(),
    PostPage(),
    ProfilePage(),
    SettingsPage()
  ];

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                if (index == 2)
                  Navigator.pushNamed(context, "/postPage");
                else
                  _selectedIndex = index;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            tabs:  [
              GButton(
                icon: Icons.home_filled,
                // text: "Home",
                iconActiveColor: Colors.blue,
                iconSize: 23.sp,

              ),
              GButton(
                icon: Icons.favorite_border,
                // text: "Favourites",
                iconActiveColor: Colors.pink,
                iconSize: 23.sp,
              ),
              GButton(
                icon: Icons.add_circle_outline_sharp,
                iconSize: 45.sp,
                backgroundColor: Colors.transparent,
                iconActiveColor: Colors.white,

                //iconActiveColor: Colors.blue,
                //text: "Post",
              ),
              GButton(
                  icon: Icons.person_outline, iconActiveColor: Colors.cyan,
                iconSize: 23.sp,
                  //text: "Profile",
                  ),
              GButton(
                  icon: Icons.settings_outlined, iconActiveColor: Color(0xff00ffa2),
                iconSize: 23.sp,
                  //text: "Settings",
                  )
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    ));
  }
}
