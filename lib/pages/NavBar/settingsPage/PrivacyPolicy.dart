import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class PrivacyPolicy extends StatefulWidget {

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {



// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body:Container(
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
                      padding: EdgeInsets.only(top: 15.h,left: 13.w,right: 13.w),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2.w, color: Colors.white38),
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.transparent),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 18.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Privacy Policy",
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
                        height: 677.h,
                        //width:600,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: Colors.white38),
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.transparent),
                        child: Padding(
                          padding: EdgeInsets.only(top:25.h,left:18.w ,right:18.w),
                          child: Text("At X Real Estate, we're dedicated to revolutionizing the way people connect with properties. Our app provides a seamless platform for users to create accounts, enabling them to effortlessly post property ads. Whether you're selling, buying, or renting, our goal is to facilitate transparent and efficient transactions. We prioritize user privacy and security, implementing robust measures to safeguard your personal information. With X Real Estate, you can confidently navigate the real estate market, explore listings, and engage with potential buyers or renters. Join us in reshaping the real estate experience today.",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),




        )
    );
  }


}