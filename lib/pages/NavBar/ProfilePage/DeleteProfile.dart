import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/MongoDB_Ad_Connection.dart';
import 'package:my_app/mongoDB.dart';
import 'package:my_app/pages/NavBar/Home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SplashPage.dart';

class DeleteProfile extends StatefulWidget {
  @override
  State<DeleteProfile> createState() => _DeleteProfileState();
}

class _DeleteProfileState extends State<DeleteProfile> {
  String dropdownValue = 'No';
  var currentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSizedBox = false;
  FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(() {
      setState(() {
        showSizedBox = _textFieldFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff091e3a),
                  Color(0xff2f80ed),
                  Color(0xff3d2fed)
                ],
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
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 18.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delete Account",
                              style: GoogleFonts.libreBaskerville(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding:
                      EdgeInsets.only(left: 14.w, right: 14.w, top: 11.h,bottom: 13.h),
                      child: Container(
                        height: 677.h,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2.w, color: Colors.white38),
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.transparent,

                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.0.h, horizontal: 20.0.w),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Are you sure you want to delete your account? This action is permanent and will result in the loss of all your saved data and preferences. If you're certain about this decision, please confirm below. If not, you can always reconsider or reach out to our support team for assistance. Your satisfaction is important to us, and we're here to help in any way we can.",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Row(
                                    children: [
                                      Text(
                                        "Choose: ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      DropdownButton<String>(
                                        value: dropdownValue,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        dropdownColor: Colors.grey[800],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                        underline: Container(
                                          height: 2.h,
                                          color: Colors.white70,
                                        ),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white70,
                                        ),
                                        items: <String>['Yes', 'No']
                                            .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                  if (dropdownValue == "Yes") ...[
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                                      child: TextFormField(
                                        focusNode: _textFieldFocusNode,
                                        controller: currentController,
                                        style: TextStyle(color: Colors.white),
                                        obscureText: true,
                                        cursorColor: Colors.white60,
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(color: Colors.red),
                                          labelText: "Current Password",
                                          labelStyle: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white70,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white38,
                                              width: 2.w,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white70,
                                              width: 2.w,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2.w,
                                              color: Colors.red,
                                            ),
                                          ),
                                          focusedErrorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2.w,
                                              color: Colors.red,
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
                                    ),
                                    SizedBox(height: 20.h),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          deleteProfile();
                                        },
                                        child: Text(
                                          "Delete Account",
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                        style: ButtonStyle(
                                          minimumSize: MaterialStateProperty.all(
                                            Size(65.sp, 40.sp),
                                          ),
                                          foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                            Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: showSizedBox,
                                        child: SizedBox(height: 255.h,))
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),

      ),
    );
  }
  Future<void> deleteProfile() async{
    if(_formKey.currentState != null && _formKey.currentState!.validate()){
        if(await MongoDB.check(HomePageState.cnic, currentController.text)){
            if(await MongoDB.deleteAccount(HomePageState.cnic )){
              await MongoAD.deletedAccountAds(HomePageState.cnic);
              await MongoAD.removeUserLikedPost(HomePageState.cnic);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account deleted successfully!"),duration: Duration(milliseconds: 1300)));
              Future.delayed(Duration(milliseconds: 1800), () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs?.setBool(SplashPageState.keyLogin, false);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/loginRoute',
                      (route) => false, // Remove all routes from the stack
                );
              });
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Server Error: Problem occurred while deleting account!"),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000),));

            }
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Current Password is incorrect!"),duration: Duration(milliseconds: 2000),backgroundColor: Color(0xffaa0000),));
          currentController.text="";
        }
    }
  }
}
