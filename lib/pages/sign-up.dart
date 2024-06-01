import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/mongoDB.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:my_app/userJsonModel.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
// This widget is the root of your application.
  bool cnicCheck=false;
  bool userExist=false;
  final _formKey= GlobalKey<FormState>();
  bool maleGender=true;
  bool femaleGender = false;
  bool otherGender=false;
  String gender='';
  String selectedDate = "";
  bool showSizedBox = false;
  FocusNode _textFieldFocusNode = FocusNode();
  FocusNode _textFieldFocusNode2= FocusNode();
  var nameController= new TextEditingController();
  var cnicController= new TextEditingController();
  var genderController= new TextEditingController();
  var ageController= new TextEditingController();
  var dobController= new TextEditingController();
  var numberController= new TextEditingController();
  var emailController= new TextEditingController();
  var passwordController= new TextEditingController();
  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(() {
      setState(() {
        showSizedBox = _textFieldFocusNode.hasFocus;
      });
    });
    _textFieldFocusNode2.addListener(() {
      setState(() {
        showSizedBox = _textFieldFocusNode2.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _textFieldFocusNode2.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1914, 8), // You can set minimum date here
      lastDate: DateTime.now(),
      // mode: DatePickerMode.date,// You can set maximum date here
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate =
            pickedDate.toString().substring(0, 10); // Format the date as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/loginRoute',
                  (route) => false, // Remove all routes from the stack
            );//Navigator.pushReplacementNamed(context, "/loginRoute");
            return false; // Return false to prevent default back button behavior
          },
          child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xff091e3a), Color(0xff2f80ed), Color(0xff3d2fed)],
            stops: [0.05, 1, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child:SafeArea(
            child:Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Container(
                        height: 760.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.white54),
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.transparent,

                        ),
                        child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //SizedBox(height: 4.h,),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 13.0.h, horizontal: 32.0.w),
                                  child: TextField(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Full Name",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        // Change line color here
                                      ),
                                    ),
                                  ),
                                ),
                                // fullName , cnic , email ,contactNumber , address , age , gender , dob , password
                                Padding(
                                  padding:
                                  EdgeInsets.only(top: 18.h, left: 32.w,right: 32.w,bottom: 6),
                                  child: TextFormField(
                                    controller: cnicController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(13),
                                    ],
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "CNIC",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        // Change line color here
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 34.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Visibility(
                                      visible: userExist
                                        ,child: Text("This CNIC is already in use",style:
                                          TextStyle(
                                            color: Colors.red,
                                            fontSize: 11.sp
                                          ),)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 34.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Visibility(
                                        visible: cnicCheck
                                        ,child: Text("CNIC should be of 13 characters.",style:
                                    TextStyle(
                                        color: Colors.red,
                                        fontSize: 11.sp
                                    ),)),
                                  ),
                                ),
                                SizedBox(
                                  height: 17.h,
                                ),
                                Row(
                                  children: [
                                    // Radio button for Male
                                    SizedBox(width: 16.w,),
                                    IconButton(
                                      onPressed: (){
                                        if(!maleGender){
                                          setState(() {
                                            maleGender=true;
                                            femaleGender=false;
                                            otherGender=false;
                                          });
                                        }
                                      },
                                      iconSize: 20.sp,
                                      icon: Icon(maleGender? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white70,
                                    ),
                                    Text('Male',
                                        style:
                                        TextStyle(color:(maleGender)?Colors.white:Colors.white70, fontSize: 17.sp)),
                                    //SizedBox(width: 20),

                                    // Radio button for Female
                                      IconButton(
                                        onPressed: (){
                                          if(!femaleGender){
                                            setState(() {
                                              maleGender=false;
                                              femaleGender=true;
                                              otherGender=false;
                                            });
                                          }
                                        },
                                        iconSize: 20.sp,
                                        icon: Icon(femaleGender? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white70,
                                      ),

                                    Text('Female',
                                        style:
                                        TextStyle(color: (femaleGender)?Colors.white:Colors.white70, fontSize: 17.sp)),

                                    // SizedBox(width: 20),

                                    // Radio button for Others
                                        IconButton(
                                          onPressed: (){
                                            if(!otherGender){
                                              setState(() {
                                                otherGender=true;
                                                femaleGender=false;
                                                maleGender=false;
                                              });
                                            }
                                          },
                                          iconSize: 20.sp,
                                          icon: Icon(otherGender? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white70,
                                        ),

                                    Text('Other',
                                        style:
                                        TextStyle(color: (otherGender)?Colors.white:Colors.white70, fontSize: 17.sp)),
                                  ],
                                ),

                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                                  child: TextFormField(
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Age",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        // Change line color here
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                                  child: TextField(
                                    //controller: dobController,
                                    readOnly: true,
                                    // Set to readOnly to prevent manual input
                                    onTap: () => _selectDate(context),
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      prefixIcon: Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.white60,
                                      ),
                                      hintText: "Date of Birth",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white54),
                                      ),
                                    ),
                                    controller: TextEditingController(
                                        text: selectedDate), // Display selected date
                                  ),

                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                                  child: TextFormField(
                                    controller: numberController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Contact Number",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        // Change line color here
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                                  child: TextFormField(
                                    controller: emailController,
                                    focusNode: _textFieldFocusNode2,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        // Change line color here
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                                  child: TextFormField(
                                    controller: passwordController,
                                    focusNode: _textFieldFocusNode,
                                    style: TextStyle(color: Colors.white),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle:
                                      TextStyle(color: Colors.white70, fontSize: 17.sp),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white38),
                                        // Change line color here
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        // Change line color here
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                ElevatedButton(
                                    onPressed: () async{
                                      if(nameController.text.isNotEmpty && cnicController.text.isNotEmpty && ageController.text.isNotEmpty && selectedDate.isNotEmpty && numberController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
                                      {
                                          if(cnicController.text.length==13){
                                            setState(() {
                                              cnicCheck=false;
                                            });
                                            if(!await MongoDB.checkUser(cnicController.text.trim())){
                                              setState(() {
                                                userExist=false;
                                              });
                                              if(maleGender)
                                                gender="male";
                                              else if(femaleGender)
                                                gender="female";
                                              else
                                                gender="other";
                                              var success= insertData(nameController.text.trim(), cnicController.text.trim(),gender,  ageController.text.trim(), selectedDate, numberController.text.trim(), emailController.text.trim(), passwordController.text.trim());
                                              if(await success){
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created Successfully."),duration: Duration(seconds: 2),));
                                              }
                                              else
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Problem occured while saving data"),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000)));
                                              Future.delayed(Duration(milliseconds: 1800), () {
                                                Navigator.pushNamed(context, "/loginRoute");
                                              });
                                            }
                                            else
                                            {
                                              setState(() {
                                                userExist=true;
                                                cnicController.text="";
                                              });
                                            }
                                          }
                                          else
                                            {
                                              setState(() {
                                                cnicCheck=true;
                                                cnicController.text="";
                                              });
                                            }
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all the fields to proceed !")
                                          ,duration: Duration(seconds: 3),backgroundColor: Color(0xffaa0000)));
                                      }
                                    },

                                    child: Text("Sign Up",style: TextStyle(fontSize:14.sp),),
                                    style: ButtonStyle(
                                       minimumSize: MaterialStateProperty.all(Size(75.sp, 35.sp)),
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(Colors.black),
                                        //backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                                    ),
                                ),
                                Visibility(
                                    visible: showSizedBox,
                                    child: SizedBox(height: 250.h,))
                              ],
                            )),
                      ),
                    ],
                  ),
                )),
          )
                ),
              ),
        ));
  }
  Future<bool> insertData(String name, String cnic, String gender, String age,String dob, String number, String email, String password )async {
    var _id= M.ObjectId();
    var data= {
      "_id":_id,
      "Name": name.trim(),
      "CNIC": cnic.trim(),
      "Gender": gender,
      "Age": age.trim(),
      "DOB": dob,
      "ContactNumber": number.trim(),
      "Email": email.trim(),
      "Password": password.trim(),
      "Post Id":[],
      "Favourite Ads":[]
    };
    bool result =await MongoDB.insert(data);
   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: ,))
    return result;
  }

}
