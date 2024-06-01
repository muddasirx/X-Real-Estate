import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class AboutUs extends StatefulWidget {

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

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
                                Text("About us",
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
                          child: Text("Welcome to X Real Estate, your premier destination for all things real estate. We are committed to empowering users with a cutting-edge platform that simplifies property transactions. Our app is designed to offer a user-friendly experience, allowing you to create an account and showcase your properties effortlessly. Whether you're a seller, buyer, or renter, X Real Estate provides comprehensive tools and resources to streamline your journey. We strive for excellence in every aspect, from listing management to user interaction, ensuring that you have a seamless and satisfying experience. Trust X Real Estate to be your trusted partner in the world of real estate.",
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


}   // Sign Up button