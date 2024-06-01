import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/mongoDB.dart';
import 'package:my_app/pages/SplashPage.dart';
import 'package:my_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
final _formKey= GlobalKey<FormState>();
var passwordController= new TextEditingController();
var cnicController= new TextEditingController();

void checkLogin(BuildContext context) async {
  if(_formKey.currentState != null && _formKey.currentState!.validate()){
    if(await MongoDB.check(cnicController.text.trim(), passwordController.text.trim())){
      SplashPageState.cnic=cnicController.text.trim();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(SplashPageState.keyLogin, true);
      SharedPreferences prefLogin = await SharedPreferences.getInstance();
      await prefLogin.setString('cnic', cnicController.text);
      Navigator.pushReplacementNamed(context, '/NavBar');
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid CNIC or Password."),duration: Duration(seconds: 3),backgroundColor: Color(0xffaa0000),));
      cnicController.text="";
      passwordController.text="";
    }
    //Navigator.pushNamed(context, "/NavBar");
  }
}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            /*gradient: LinearGradient(
              colors: [Colors.purple.withOpacity(0.80), Colors.blue.withOpacity(0.70)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight
              ,
            ),*/
              gradient: LinearGradient(
                colors: [Color(0xff091e3a), Color(0xff2f80ed), Color(0xff3d2fed)],
                stops: [0.05, 1, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),


          child: Center(
            child: Container(
              height: 550.h,
              width: 300.w,

              decoration: BoxDecoration(
                  border: Border.all(width: 2.w,color: Colors.white38),
                  borderRadius: BorderRadius.circular(30.r),
                  //color: Colors.transparent,
                  gradient: LinearGradient(
                    colors: [Color(0xff091e3a).withOpacity(0.0), Color(0xff2f80ed).withOpacity(0.0), Color(0xff3d2fed)],
                    stops: [0.05, 1, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),



              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h,),
                    Image.asset("assets/images/logoX.png",width: 130.w,height: 130.h,),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, left: 32.w,right: 32.w),
                      child: Form (
                        key: _formKey,
                        child: Column(
                          children: [SizedBox(height: 5.h),
                            TextFormField(
                             // autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: cnicController,
                                cursorColor: Colors.white60,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(13),
                                ],
                              style: TextStyle(color: Colors.white,fontSize: 14.sp),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.red,),
                                contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                                hintText: "CNIC",//currentHeight.toString(),
                                hintStyle: TextStyle(color:Colors.white60),
                               enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29.r),
                                    borderSide: BorderSide(
                                      width: 2.w,
                                      color: Colors.white54
                                    )
                                ),
                                errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(29.r),
                                borderSide: BorderSide(
                                  width: 2.w,
                                  color: Colors.red, // Customize the error border color as needed
                                ),
                              ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(29.r),
                                    borderSide: BorderSide(
                                        width: 2.w,
                                        color: Colors.white70
                                    ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29.r),
                                  borderSide: BorderSide(
                                    width: 2.w,
                                    color: Colors.white70, // Customize the error border color as needed
                                  ),
                                ),

                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10.w,right: 5.w),
                                  child: Icon(Icons.account_circle_outlined,color: Colors.white60,size: 23.sp),
                                ),

                              ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "CNIC cannot be Empty";
                                  }
                                  return null;
                                },
                              onChanged: (value){
                                  setState(() {});
                              },

                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                             // autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: passwordController,
                              style: TextStyle(color: Colors.white,fontSize: 14.sp),
                              obscureText: true,
                              cursorColor: Colors.white60,
                              decoration: InputDecoration(
                                prefixStyle: TextStyle(fontSize: 14.sp),
                                errorStyle: TextStyle(color: Colors.red),
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                                hintText: "Password",//currentWidth.toString(),
                                hintStyle: TextStyle(color: Colors.white60),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(29.r),

                                      borderSide: BorderSide(
                                          width: 2.w,
                                          color: Colors.white54
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(29.r),
                                      borderSide: BorderSide(
                                          width: 2.w,
                                          color: Colors.white70
                                      )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(29.r),
                                    borderSide: BorderSide(
                                      width: 2.w,
                                      color: Colors.red, // Customize the error border color as needed
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(29.r),
                                    borderSide: BorderSide(
                                      width: 2.w,
                                      color: Colors.white70, // Customize the error border color as needed
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 10.w,right: 5.w),
                                    child: Icon(Icons.lock_outline_rounded,color: Colors.white60,size: 22.sp,),
                                  )),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be Empty";
                                }
                                return null;
                              },
                              onChanged: (value){
                                setState(() {});
                              },
                            )
                                            ,SizedBox(height: 35.h),
                                        ElevatedButton(onPressed: (){checkLogin(context);}
                                            , child:Text("Login",style:TextStyle(fontSize: 14.sp)
                                               )
                                            ,style: ButtonStyle(
                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                              minimumSize: MaterialStateProperty.all(Size(75.sp, 35.sp)),
                                              ))
                          ,SizedBox(height:15.h)
                            ,/*Text("Sign Up",style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor:Colors.white70 ,
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                            ),*/
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, "/signUpRoute");
                              },
                              child: Text("Sign Up",style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor:Colors.white.withOpacity(0.90) ,
                              fontSize: 18.sp,
                              color: Colors.white.withOpacity(0.90),

                            ),
                            ),
                            ),
                           // SizedBox(height: 20,)

                          ],
                        ),
                      ),
                    )
                  ],
                ),

            ),
          ),
        ),
      ),
    );
  }

}

