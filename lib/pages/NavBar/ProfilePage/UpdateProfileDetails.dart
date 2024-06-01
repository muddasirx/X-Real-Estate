import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/mongoDB.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SplashPage.dart';
import '../Home_page.dart';


class UpdateProfileDetails extends StatefulWidget {

  @override
  State<UpdateProfileDetails> createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
   bool _isLoading = true;
  var c=HomePageState.cnic;
  late Map<String,dynamic> data;
  String gender = "";
  bool maleGender=false;
  bool femaleGender = false;
  bool otherGender=false;
  String selectedDate = "";
  bool showSizedBox = false;
  FocusNode _textFieldFocusNode= FocusNode();

  var nameController= new TextEditingController();
  var cnicController= new TextEditingController();
  var ageController= new TextEditingController();
  var numberController= new TextEditingController();
  var emailController= new TextEditingController();

  @override
  void initState() {
    super.initState();
    userData(c);
    _textFieldFocusNode.addListener(() {
      setState(() {
        showSizedBox = _textFieldFocusNode.hasFocus;
      });
    });
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

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:  Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff091e3a), Color(0xff2f80ed), Color(0xff3d2fed)],
                    stops: [0.05, 1, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child:_isLoading
                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):SafeArea(
                child:Center(
                    child:
                        Padding(
                          padding: EdgeInsets.only(bottom:30.h),
                          child: Container(
                            height: 700.h,
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
                                          TextStyle(color: Colors.white70, fontSize: 18.sp),
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
                                      EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                                      child: TextField(
                                        controller: cnicController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(13),
                                        ],
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: "CNIC",
                                          hintStyle:
                                          TextStyle(color: Colors.white70, fontSize: 18.sp),
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
                                            TextStyle(color: (maleGender)?Colors.white:Colors.white70, fontSize: 18.sp)),
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
                                            TextStyle(color: (femaleGender)?Colors.white:Colors.white70, fontSize: 18.sp)),

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
                                            TextStyle(color:(otherGender)?Colors.white:Colors.white70, fontSize: 18.sp)),
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
                                          TextStyle(color: Colors.white70, fontSize: 18.sp),
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
                                          TextStyle(color: Colors.white70, fontSize: 18.sp),
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
                                          TextStyle(color: Colors.white70, fontSize: 18.sp),
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
                                        focusNode: _textFieldFocusNode,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                          TextStyle(color: Colors.white70, fontSize: 18.sp),
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

                                    SizedBox(height: 20.h),
                                    ElevatedButton(
                                      onPressed: () async{
                                        if(maleGender)
                                          gender="male";
                                        else if(femaleGender)
                                          gender="female";
                                        else
                                          gender="other";
                                          if(nameController.text.trim()!=data['Name'] || cnicController.text.trim()!=data['CNIC'] || gender!= data['Gender'] ||ageController.text.trim()!=data['Age'] || selectedDate!=data['DOB'] || numberController.text.trim()!=data['ContactNumber'] || emailController.text.trim()!=data['Email'])
                                          {
                                            if(nameController.text.isNotEmpty && cnicController.text.isNotEmpty &&  ageController.text.isNotEmpty && selectedDate.isNotEmpty && numberController.text.isNotEmpty && emailController.text.isNotEmpty)
                                            {
                                              var success= updateData();
                                              if(await success){
                                                SharedPreferences prefLogin = await SharedPreferences.getInstance();
                                                await prefLogin.setString('cnic', cnicController.text);
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Updated Successfully"),duration: Duration(milliseconds: 1300),));
                                                Future.delayed(Duration(milliseconds: 1800), () {
                                                  Navigator.pop(context);
                                                });
                                              }
                                              else
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Problem occured while Updating data"),duration: Duration(seconds: 2),backgroundColor: Color(0xffaa0000)));

                                            }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all the fields to proceed !")
                                                  ,duration: Duration(seconds: 3),backgroundColor: Color(0xffaa0000)));
                                            }
                                          }else
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Change in data."),duration: Duration(seconds: 2),backgroundColor: Color(0xffaa0000)));

                                                                            },
                                      child: Text("Update",style: TextStyle(fontSize:14.sp),),
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
                        ),
                      ),
              )
          ),
        )
    );
  }

  Future<void> userData(var c) async{
    setState(() {
      _isLoading = true; // Show circular progress indicator
    });

   data= await MongoDB.fetchUserData(c);
   setState(() {
     _isLoading = false;
     nameController.text=data['Name'];
     cnicController.text=data['CNIC'];
     gender=data['Gender'];
     ageController.text=data['Age'];
     selectedDate=data['DOB'];
     numberController.text=data['ContactNumber'];
     emailController.text=data['Email'];
     if(data['Gender']=='male')
       maleGender=true;
     else if(data['Gender']=='female')
       femaleGender=true;
     else
       otherGender=true;
   });
}
  Future<bool> updateData()async {

    data['Name']=nameController.text.trim();
    data['CNIC']=cnicController.text.trim();
    data['Gender']=gender;
    data['Age']=ageController.text.trim();
    data['DOB']=selectedDate;
    data['ContactNumber']=numberController.text.trim();
    data['Email']=emailController.text.trim();
    bool result =await MongoDB.updateData(data);
    return result;
  }
}