import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SplashPage.dart';


class SettingsPage extends StatefulWidget {

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Widget settingsOption(String x,int y){
    return InkWell(
      onTap: (){
        if(y==0)
          Navigator.pushNamed(context, "/PrivacyPolicy");
        else if(y==1)
          Navigator.pushNamed(context, "/AboutUs");
        else if(y==2)
          logoutUser();
      },
      child:Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h,horizontal:13.w ),
              child: Text(x,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white
                  )),
            ),
          ),
    );
  }

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff091e3a), Color(0xff2f80ed), Color(0xff3d2fed)],
                            stops: [0.05, 1, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 15.h,left: 14.w,right: 14.w),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2.w, color: Colors.white38),
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.transparent),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 18.w),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Settings",
                                  style: GoogleFonts.libreBaskerville(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                    ),
                                  ),),
                              ],
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:14.w,right: 14.w,top:11.h),
                      child:Container(
                          height: 571.5.h,
                          //width:600,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2.w, color: Colors.white38),
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.transparent),
                          child:Column(
                            children: [
                              settingsOption("Privacy Policy",0),
                              Divider(
                                thickness: 2.sp,
                                color: Colors.white38,
                              ),
                              settingsOption("About us",1),
                              Divider(
                                thickness: 2.sp,
                                color: Colors.white38,
                              ),
                              settingsOption("Log out",2),
                              Divider(
                                thickness: 2.sp,
                                color: Colors.white38,
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        )
    );
  }
  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setBool(SplashPageState.keyLogin, false);
    Navigator.pushReplacementNamed(context, '/loginRoute');
  }


}