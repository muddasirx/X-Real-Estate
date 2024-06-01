import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget profileOption(String x,int y){
    return InkWell(
      onTap: (){
        if(y==0)
          Navigator.pushNamed(context, "/UpdateProfile");
        else if(y==1)
          Navigator.pushNamed(context, "/ChangePassword");
        else if(y==2)
          Navigator.pushNamed(context, "/myAds");
        else if(y==3)
          Navigator.pushNamed(context, "/DeleteProfile");
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
                       padding: EdgeInsets.only(top: 15.h,left: 14.w,right: 14.w),
                       child: Container(
                           decoration: BoxDecoration(
                               border: Border.all(width: 2.w, color: Colors.white38),
                               borderRadius: BorderRadius.circular(15.r),
                               color: Colors.transparent),
                           child:Padding(
                             padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("Profile",
                                   style: GoogleFonts.libreBaskerville(
                                     textStyle: TextStyle(
                                       color: Colors.white,
                                       fontSize: 28.sp,
                                     ),
                                   ),),
                                 SizedBox(width: 10.w,),
                                 Image.asset("assets/images/user1.png",height: 60.h,width: 60.w,),
                               ],
                             ),
                           )
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(left:14.w,right: 14.w,top:11.h),
                       child:Container(
                         height: 572.h,
                         //width:600,
                         decoration: BoxDecoration(
                             border: Border.all(width: 2.w, color: Colors.white38),
                             borderRadius: BorderRadius.circular(15.r),
                             color: Colors.transparent),
                         child:Column(
                           children: [
                             profileOption("Update profile details",0),
                             Divider(
                               thickness: 2.sp,
                               color: Colors.white38,
                             ),
                             profileOption("Change password",1),
                             Divider(
                               thickness: 2.sp,
                               color: Colors.white38,
                             ),
                             profileOption("My Ads",2),
                             Divider(
                               thickness: 2.sp,
                               color: Colors.white38,
                             ),
                             profileOption("Delete Account",3),
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
             ),


        )
    );
  }


}