import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/pages/NavBar/SearchAd.dart';
import 'package:my_app/pages/filterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool buy=true;
  bool rent=false;
  static var cnic;
  @override
  void initState() {
    super.initState();
    getCNIC();// Set "buy" as the default selected choice
  }

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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


            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 14.w, right: 14.w),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.w, color: Colors.white38),
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.transparent),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "The Property\nExpert",
                              style: GoogleFonts.libreBaskerville(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.sp,
                                ),
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/logoX.png",
                              width: 100.w,
                              height: 100.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:  11.h, left: 14.w,right: 14.w),
                    child: Container(
                      height: 532.h,
                      //width: 380,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.w, color: Colors.white38),
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.transparent),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Choose: ",
                                  style:
                                  TextStyle(fontSize: 17.sp, color: Colors.white)),
                              IconButton(
                                onPressed: (){
                                  if(!buy){
                                    setState(() {
                                      buy=true;
                                      rent=false;
                                    });
                                  }
                                },
                                iconSize: 20.sp,
                                icon: Icon(buy? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white70,
                              ),
                              Text(
                                "Buy",
                                style: TextStyle(fontSize: 17.sp, color: Colors.white),
                              ),
                              IconButton(
                                onPressed: (){
                                  if(!rent){
                                    setState(() {
                                      rent=true;
                                      buy=false;
                                    });
                                  }
                                },
                                iconSize: 20.sp,
                                icon: Icon(rent? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white70,
                              ),
                              Text(
                                "Rent",
                                style: TextStyle(fontSize: 17.sp, color: Colors.white),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              //Navigator.pushNamed(context, "/SearchAd",arguments: (buy)?"buy":"rent");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => searchFilter(s:(buy)?"Buy":"Rent",p:"House"), // Assuming UpdatePropertyAd requires 'data'
                                ),
                              );
                            }
                              ,
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                                  child: Image.asset(
                                    "assets/images/house.png",
                                    width: 130.w,
                                    height: 130.h,
                                  ),
                                ),
                                Text(
                                  "House",
                                  style: GoogleFonts.libreBaskerville(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white70),
                                  ),
                                ),
                              ])
                          ),
                          InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => searchFilter(s:(buy)?"Buy":"Rent",p:"Plot"), // Assuming UpdatePropertyAd requires 'data'
                                  ),
                                );
                                //Navigator.pushNamed(context, "/SearchAd",arguments: (buy)?"buy":"rent");
                              },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 45.h, bottom: 8.h),
                                  child: Image.asset(
                                    "assets/images/land.png",
                                    width: 130.w,
                                    height: 130.h,
                                  ),
                                ),
                                Text(
                                  "Plots",
                                  style: GoogleFonts.libreBaskerville(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white70),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 0,)
                ],
              ),
            ),


          ),
        ],
      ),




    ));
  }
  Future<void> getCNIC() async{
    SharedPreferences prefLogin = await SharedPreferences.getInstance();
    cnic= prefLogin.getString('cnic') ?? '';
  }
}
