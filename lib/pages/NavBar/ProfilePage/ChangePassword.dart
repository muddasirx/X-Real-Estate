import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../mongoDB.dart';
import '../Home_page.dart';


class ChangePassword extends StatefulWidget {

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey= GlobalKey<FormState>();
  var currentController= new TextEditingController();
  var newController= new TextEditingController();
  var confirmController= new TextEditingController();

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 18.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Update Password",
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
                            child:Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                              child:Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: currentController,
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(color: Colors.red,),
                                        labelText: "Current Password",
                                        labelStyle: TextStyle(fontSize:16.sp,color: Colors.white70),
                                        enabledBorder: UnderlineInputBorder(
                                          //borderRadius: BorderRadius.circular(29.r),
                                          borderSide: BorderSide(color: Colors.white38,width: 2.w),
                                          // Change line color here
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white70,width: 2.w),
                                          // Change line color here
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.red, // Customize the error border color as needed
                                          ),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.red, // Customize the error border color as needed
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Current password cannot be empty!";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20.h,),
                                    TextFormField(
                                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: newController,
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(color: Colors.red,),
                                        labelText: "New Password",
                                        labelStyle: TextStyle(fontSize:16.sp,color: Colors.white70),
                                        enabledBorder: UnderlineInputBorder(
                                          //borderRadius: BorderRadius.circular(29.r),
                                          borderSide: BorderSide(color: Colors.white38,width: 2.w),
                                          // Change line color here
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white70,width: 2.w),
                                          // Change line color here
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.red, // Customize the error border color as needed
                                          ),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.red, // Customize the error border color as needed
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "New password cannot be empty!";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10.h),
                                    TextFormField(
                                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: confirmController,
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(color: Colors.red,),
                                        labelText: "Confirm Password",
                                        labelStyle: TextStyle(fontSize:16.sp,color: Colors.white70),
                                        enabledBorder: UnderlineInputBorder(
                                          //borderRadius: BorderRadius.circular(29.r),
                                          borderSide: BorderSide(color: Colors.white38,width: 2.w),
                                          // Change line color here
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white70,width: 2.w),
                                          // Change line color here
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.red, // Customize the error border color as needed
                                          ),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.red, // Customize the error border color as needed
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Confirm password cannot be empty!";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height:30.h),
                                    ElevatedButton(
                                      onPressed: (){
                                        checkPassword();
                                      },
                                      child: Text("Update",style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black
                                      ),),
                                    )
                                  ],
                                ),
                              )
                      )
                    ),

                ),
              ]
            ),

          ),

        )

        )
    );
  }
void checkPassword() async{
    if(_formKey.currentState != null && _formKey.currentState!.validate()){
      if(await MongoDB.check(HomePageState.cnic, currentController.text.trim())){
        if(newController.text.trim()==confirmController.text.trim()){
          bool success=await MongoDB.updatePassword(HomePageState.cnic, newController.text.trim());
          if(success){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Updated Successfully."),duration: Duration(milliseconds: 1300)));
            Future.delayed(Duration(milliseconds: 1800), () {
              Navigator.pop(context);
            });
          }
          else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Server Error: Problem occurred while updating password!"),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000),));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Password & Confirm Password doesn't match!."),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000),));
          //newController.text="";
          confirmController.text="";
        }
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Current Password is incorrect!"),duration: Duration(milliseconds: 2000),backgroundColor: Color(0xffaa0000),));
        currentController.text="";
      }
    }
    // else
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all the fields to proceed!"),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000),));


}

}