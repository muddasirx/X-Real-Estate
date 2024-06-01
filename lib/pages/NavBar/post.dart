import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_app/MongoDB_Ad_Connection.dart';
import 'package:my_app/mongoDB.dart';

import 'Home_page.dart';

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String priceUnit='';
  bool loading=false;
  var data;
  var ownerCNIC=HomePageState.cnic;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles = [];
  List<String> extensions=[];
  FocusNode _textFieldFocusNode= FocusNode();
  List<Uint8List> _imageBytes=[];
  bool hasFocus=false;
  List encodedImages=[];
  bool showSizedBox = false;
  String dropDownPriceUnit='Lac';
  bool greaterThen3=false;
  String dropDownChoose="Sell";
  String dropDownProprty="House";
  List<City>? cities;
  String? selectedCity;
  String sizeType="Marla";
  String plotType="Residential";
  String storeyHouse="Single";
  bool furnished=false;
  bool nonFurnished=true;

  var priceController=new TextEditingController();
  var cityController=new TextEditingController();
  var locationController=new TextEditingController();
  var sizeController=new TextEditingController();
  var descriptionController =new TextEditingController();
  var bedController= new TextEditingController();
  var washController= new TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCities().then((data) => setState(() => cities = data));
    _textFieldFocusNode.addListener(() {
      setState(() {
        hasFocus = _textFieldFocusNode.hasFocus;
      });
    });
  }
  @override
  void dispose() {
    priceController.dispose();
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
                child: loading? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):
                SafeArea(
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
                                  "Post Ad",
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
                      Expanded(
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 14.w, right: 14.w, top: 11.h,bottom: 13.h),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.w, color: Colors.white38),
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.transparent,
                            ),
                            child:
                            Padding(
                              padding: EdgeInsets.only(right:15.w ,left: 15.w, top:10.h ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Choose : ",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        DropdownButton<String>(
                                          value: dropDownChoose,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownChoose = newValue!;
                                            });
                                          },
                                          dropdownColor: Colors.grey[800],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                          underline: Container(
                                            height: 2.h,
                                            color: Colors.white54,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white70,
                                          ),
                                          items: <String>['Sell', 'Rent']
                                              .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                        SizedBox(width: 47.w,),
                                        Text(
                                          "Property : ",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        DropdownButton<String>(
                                          value: dropDownProprty,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownProprty = newValue!;
                                            });
                                          },
                                          dropdownColor: Colors.grey[800],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                          underline: Container(
                                            height: 2.h,
                                            color: Colors.white54,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white70,
                                          ),
                                          items: <String>['House', 'Plot']
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

                                      Padding(
                                        padding: EdgeInsets.only(right: 20.w,left:20.w,top: 10.h),
                                        child: TextFormField(
                                                      keyboardType: TextInputType.number,
                                                      controller: priceController,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(15),
                                                    ],
                                                      style: TextStyle(color: Colors.white),
                                                      cursorColor: Colors.white60,
                                                      onChanged: _formatPrice,
                                                      decoration: InputDecoration(
                                                        //contentPadding: EdgeInsets.only(left: 8.w),
                                                        errorStyle: TextStyle(color: Colors.red),
                                                        hintText: "Price",
                                                        hintStyle: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.white70,
                                                        ),
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.white54,
                                                            width: 2.w,
                                                          ),
                                                        ),
                                                        focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.white70,
                                                            width: 2.w,
                                                          ),
                                                        ),
                                                          prefixIcon: Icon(Icons.attach_money_sharp,color: Colors.white54,size: 22.sp,)
                                                      ),

                                                    ),

                                      ),
                                    Visibility(
                                      visible: priceUnit.isNotEmpty,
                                      child: Padding(
                                        padding: EdgeInsets.only(top:5.h,left: 70.w),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(priceUnit,style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white60,
                                            fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top:15.h,left: 20.w,right: 20.w),
                                      child: TypeAheadField<City>(
                                        textFieldConfiguration: TextFieldConfiguration(
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                          keyboardType: TextInputType.text,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            //contentPadding: EdgeInsets.only(left: 8.w),
                                            enabledBorder: UnderlineInputBorder(
                                             // borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(
                                                width: 2.w,
                                                color: Colors.white54, // Customize the error border color as needed
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              // borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(
                                                width: 2.w,
                                                color: Colors.white70, // Customize the error border color as needed
                                              ),
                                            ),
                                            hintText: 'City Name',
                                            hintStyle: TextStyle(color: Colors.white70),
                                              prefixIcon: Icon(Icons.location_city_outlined,color: Colors.white54,size:22.sp)
                                          ),
                                          controller: cityController
                                        ),
                                        suggestionsCallback: (pattern) {
                                          return cities!
                                              .where((cities) =>
                                              cities.name.toLowerCase().startsWith(pattern.toLowerCase()))
                                              .toList();//cities!.where((city) => city.name.toLowerCase().contains(pattern.toLowerCase())).toList();
                                        },
                                        itemBuilder: (context, suggestion) => Container(
                                          decoration: new BoxDecoration (
                                              color: Colors.white
                                          ),
                                          child: ListTile(
                                            title: Text(suggestion.name,style: TextStyle(
                                              color: Colors.black
                                            ),),

                                          ),
                                        ),
                                        onSuggestionSelected: (suggestion) {
                                          setState(() => selectedCity = suggestion.name);
                                          this.cityController.text = suggestion.name.toString();
                                        },
                                        noItemsFoundBuilder: (context) => Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 10.h),
                                            child: Text(' No city found',style: TextStyle(
                                                fontSize: 17,
                                              ),),

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w,left:20.w,top: 15.h),
                                      child: TextFormField(
                                        controller: locationController,
                                        style: TextStyle(color: Colors.white),
                                        cursorColor: Colors.white60,
                                        decoration: InputDecoration(
                                          //contentPadding: EdgeInsets.only(left: 8.w),
                                          errorStyle: TextStyle(color: Colors.red),
                                          hintText: "Location",
                                          hintStyle: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white70,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white54,
                                              width: 2.w,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white70,
                                              width: 2.w,
                                            ),
                                          ),
                                            prefixIcon: Icon(Icons.location_on_outlined,color: Colors.white54,size: 22.sp,)
                                        ),

                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 15.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 18.h),
                                              child: Container(
                                                width: 140,
                                                child:TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: sizeController,
                                                    style: TextStyle(color: Colors.white),
                                                    cursorColor: Colors.white60,
                                                    decoration: InputDecoration(
                                                     // contentPadding: EdgeInsets.only(left: 8.w),
                                                      errorStyle: TextStyle(color: Colors.red),
                                                      hintText: "Area Size",
                                                      hintStyle: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.white70,
                                                      ),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white54,
                                                          width: 2.w,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white70,
                                                          width: 2.w,
                                                        ),
                                                      ),
                                                        prefixIcon: Icon(Icons.height_outlined,color: Colors.white54,size: 23.sp,)
                                                    ),
                                                  ),

                                              ),
                                            ),

                                          SizedBox(width: 10.w), // Add some spacing between the TextFormField and the dropdown
                                          DropdownButton<String>(
                                            value: sizeType,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                sizeType = newValue!;
                                              });
                                            },
                                            dropdownColor: Colors.grey[800],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.sp,
                                            ),
                                            underline: Container(
                                              height: 2.h,
                                              color: Colors.white54,
                                            ),
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white70,
                                            ),
                                            items: <String>['Marla', 'Kanal','Acre']
                                                .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text("   "+value),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                        visible: (dropDownProprty=="Plot"),
                                        child: Padding(
                                          padding:  EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
                                          child: Row(
                                            children: [
                                              Text("Plot Type :",style: TextStyle(
                                                  fontSize:16.sp,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              SizedBox(width: 15.w,),
                                              DropdownButton<String>(
                                                value: plotType,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    plotType = newValue!;
                                                  });
                                                },
                                                dropdownColor: Colors.grey[800],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                ),
                                                underline: Container(
                                                  height: 2.h,
                                                  color: Colors.white54,
                                                ),
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white70,
                                                ),
                                                items: <String>['Residential', 'Commercial','Agricultural','industrial']
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
                                        )
                                    ),
                                    Visibility(
                                      visible: (dropDownProprty=="House"),
                                        child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.w,left:20.w,top: 15.h),
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: bedController,
                                                  style: TextStyle(color: Colors.white),
                                                  cursorColor: Colors.white60,
                                                  decoration: InputDecoration(
                                                    //contentPadding: EdgeInsets.only(left: 8.w),
                                                    errorStyle: TextStyle(color: Colors.red),
                                                    hintText: "No. of Bedrooms",
                                                    hintStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.white70,
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white54,
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white70,
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                    prefixIcon: Icon(Icons.bed_rounded,color: Colors.white54,size: 22.sp,)
                                                  ),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.w,left:20.w,top: 15.h),
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: washController,
                                                  style: TextStyle(color: Colors.white),
                                                  cursorColor: Colors.white60,
                                                  decoration: InputDecoration(
                                                    //contentPadding: EdgeInsets.only(left: 8.w),
                                                    errorStyle: TextStyle(color: Colors.red),
                                                    hintText: "No. of Washrooms",
                                                    hintStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.white70,
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white54,
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white70,
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                      prefixIcon: Icon(Icons.bathtub_outlined,color: Colors.white54,size: 22.sp,)
                                                  ),

                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(right: 20.w,left:25.w,top: 15.h),
                                                child: Row(
                                                  children: [
                                                    Text("No. of floors :",style: TextStyle(
                                                        fontSize:16.sp,
                                                        color: Colors.white70,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                    SizedBox(width: 15.w,),
                                                    DropdownButton<String>(
                                                      value: storeyHouse,
                                                      onChanged: (String? newValue) {
                                                        setState(() {
                                                          storeyHouse = newValue!;
                                                        });
                                                      },
                                                      dropdownColor: Colors.grey[800],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                      ),
                                                      underline: Container(
                                                        height: 2.h,
                                                        color: Colors.white54,
                                                      ),
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Colors.white70,
                                                      ),
                                                      items: <String>['Single', 'Double','Triple']
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
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(right: 20.w,left:12.w,top: 8.h),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    IconButton(
                                                        onPressed: (){
                                                          if(!furnished){
                                                            setState(() {
                                                              furnished=true;
                                                              nonFurnished=false;
                                                            });
                                                          }
                                                        },
                                                      iconSize: 20.sp,
                                                        icon: Icon(furnished? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Furnished",
                                                      style: TextStyle(fontSize: 16.sp, color: (furnished)?Colors.white:Colors.white70),
                                                    ),
                                                    SizedBox(width: 14.w,),
                                                    IconButton(
                                                      onPressed: (){
                                                        if(!nonFurnished){
                                                          setState(() {
                                                            furnished=false;
                                                            nonFurnished=true;
                                                          });
                                                        }
                                                      },
                                                      iconSize: 20.sp,
                                                      icon: Icon(nonFurnished? Icons.radio_button_checked : Icons.radio_button_off),color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Non-Furnished",
                                                      style: TextStyle(fontSize: 16.sp, color: (nonFurnished)?Colors.white:Colors.white70),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 22.h),
                                      child: TextFormField(
                                        focusNode: _textFieldFocusNode,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3, // Allows the text field to expand vertically based on content
                                        minLines: 3, // Minimum number of lines to display
                                        controller: descriptionController, // TextEditingController for managing text input
                                        style: TextStyle(color: Colors.white),
                                        cursorColor: Colors.blue, // Customize the cursor color
                                        decoration: InputDecoration(
                                          labelText: 'Description', // Label text for the text field
                                          labelStyle: TextStyle(color: Colors.white70), // Label text style// Hint text style
                                          border: OutlineInputBorder(), // Border style for the text field
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white70, width: 2.0.w), // Customize border color
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.white54, // Customize the error border color as needed
                                          ), // Border color when not focused
                                          ),
                                        ),
                                      ),
                                    ),
                                   /* Padding(
                                      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 30.h),
                                      child: Text("Upload any 3 Images of the property",style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white70,
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white70,
                                          ),
                                      )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(onPressed: (){

                                          _pickImages();},
                                            icon: Icon(Icons.image_outlined),color: Colors.white70,iconSize: 50,),

                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    (_imageFiles!.length>3 || _imageFiles!.length<3 && _imageFiles!.length>0)?Text("Selected images must be 3.",style: TextStyle(
                                      fontSize: 15,color: Colors.red
                                    ),):_displayImages(),*/
                                    SizedBox(height: 40.h,),
                                    ElevatedButton(onPressed: () async{
                                        if(/*_imageFiles!.isNotEmpty &&*/ priceController.text.isNotEmpty && cityController.text.isNotEmpty && locationController.text.isNotEmpty && sizeController.text.isNotEmpty && descriptionController.text.isNotEmpty && dropDownProprty=="House" && bedController.text.isNotEmpty && washController.text.isNotEmpty || dropDownProprty=="Plot" /*&& _imageFiles!.isNotEmpty*/ && priceController.text.isNotEmpty && cityController.text.isNotEmpty && locationController.text.isNotEmpty && sizeController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                                           setState(() {
                                             loading=true;
                                           });
                                          if(await insertData())
                                              {
                                                MongoDB.updateNumberOfUserPosts(ownerCNIC,data['Id']);
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ad posted Successfully."),duration: Duration(seconds: 2),));
                                                Future.delayed(Duration(milliseconds: 1800), () {
                                                  Navigator.pop(context);
                                                });
                                              }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Problem occured while uploading post."),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000)));
                                              setState(() {
                                                loading=false;
                                              });
                                          }
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all the fields to proceed."),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000)));

                                        }
                                    },
                                      child: Text("Post",style: TextStyle(fontSize:17.sp),),
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(Size(100.sp, 40.sp)),
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(Colors.black),
                                        //backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                                      ),
                                    ),
                                    Visibility(
                                      visible: true,//showSizedBox,
                                        child: SizedBox(height: hasFocus?290:25)
                                    )

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




      )
    );
  }

  Future<List<City>> loadCities() async {
    final response = await rootBundle.loadString('assets/cities.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((city) => City.fromJson(city)).toList();
  }

 /* void _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage(
      //maxImages: 3,
      imageQuality: 70,
    );

    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles;
      });
    }
  }

  Widget _displayImages() {
    if (_imageFiles == null || _imageFiles!.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 15,
          children: _imageFiles!.map((file) => Image.file(File(file.path))).toList(),
        ),
      ],
    );
  }*/

  Future<bool> insertData()async {
    //MongoAD.connect();
      /*  var imageBytes = await _imageFiles?[0].readAsBytes();
        setState(() {
          _imageBytes.add(Uint8List.fromList(imageBytes as Uint8List));
        });
        imageBytes = await _imageFiles?[1].readAsBytes();
        setState(() {
          _imageBytes.add(Uint8List.fromList(imageBytes as Uint8List));
        });
        imageBytes = await _imageFiles?[2].readAsBytes();
        setState(() {
          _imageBytes.add(Uint8List.fromList(imageBytes as Uint8List));
        }); */
  /*  extensions.add(_imageFiles![0].path.split('.').last);
    extensions.add(_imageFiles![1].path.split('.').last);
    extensions.add(_imageFiles![2].path.split('.').last); */
    var Id=0;
    var _id= M.ObjectId();
    Id= await MongoAD.getID();
    ++Id;
    var price=priceController.text.replaceAll(',', '').trim();
    var length=int.parse(sizeController.text.trim());
    if(sizeType == 'Kanal')
      length=length*20;
    else if(sizeType == 'Acre')
      length=length*160;

    if(dropDownProprty=="House"){
      data= {
        "_id":_id,
        "Id": Id,
        "Owner CNIC":ownerCNIC,
        "State":dropDownChoose,
        "Property":dropDownProprty,
        "Price": int.parse(price),
        "City": cityController.text.toString(),
        "Location": locationController.text.toString().trim(),
        "Area": length,
        "Area Type":sizeType,
        "No. of bedrooms": bedController.text.toString().trim(),
        "No. of washrooms": washController.text.toString().trim(),
        "No. of floors": storeyHouse,
        "Furnished": furnished,
        "Description": descriptionController.text.toString().trim(),
        "Liked By":[]
        //"Images": _imageBytes
       // "Extension":extensions
      };

    }
    else
      {
        data= {
          "_id":_id,
          "Id": ++Id,
          "Owner CNIC":ownerCNIC,
          "State":dropDownChoose,
          "Property":dropDownProprty,
          "Price": int.parse(price),
          "City": cityController.text.toString(),
          "Location": locationController.text.toString().trim(),
          "Area": length,
          "Area Type":sizeType,
          "Plot Type":plotType,
          "Description": descriptionController.text.toString().trim(),
          "Liked By":[]
         // "Images": _imageBytes
          //"Extension":extensions
        };
      }
  /*  saveImage(_imageFiles![0], '${Id}_${0}.${extensions[0]}');
    saveImage(_imageFiles![1], '${Id}_${0}.${extensions[1]}');
    saveImage(_imageFiles![2], '${Id}_${0}.${extensions[2]}'); */
    //print(data);
    bool result =await MongoAD.uploadData(data);
    return result;


  }
  /*Future<void> saveImage(XFile file, String filePath) async {
    await file.saveTo(filePath);
  }*/
  /*Future<void> saveImage(var image,String fileName) async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/${fileName}';
      final newImageFile = File(path);
      final imageBytes = await image.readAsBytes();

      print('Image will be converted now! ');

      await newImageFile.writeAsBytes(imageBytes);

      print('Image saved to: $path');

  }*/
  void _formatPrice(String value) {
    value = value.replaceAll(',', '');

    if (value.isEmpty) {
      priceController.value = TextEditingValue.empty;
      return;
    }

    int length = value.length;
    String formattedValue = '';
    if(length<4)
      setState(() { priceUnit=""; });
    else if(length==4){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { priceUnit="${value[0]}.${value[1]}${value[2]} Thousand"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { priceUnit="${value[0]}.${value[1]} Thousand"; });
      else
        setState(() { priceUnit="${value[0]} Thousand"; });
    }
    else if(length==5){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Thousand"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]} Thousand"; });
      else
        setState(() { priceUnit="${value[0]}${value[1]} Thousand"; });
    }
    else if(length==6){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { priceUnit="${value[0]}.${value[1]}${value[2]} Lac"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { priceUnit="${value[0]}.${value[1]} Lac"; });
      else
        setState(() { priceUnit="${value[0]} Lac"; });
    }
    else if(length==7){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Lac"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]} Lac"; });
      else
        setState(() { priceUnit="${value[0]}${value[1]} Lac"; });
    }
    else if(length==8){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { priceUnit="${value[0]}.${value[1]}${value[2]} Crore"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { priceUnit="${value[0]}.${value[1]} Crore"; });
      else
        setState(() { priceUnit="${value[0]} Crore"; });
    }
    else if(length==9){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Crore"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]} Crore"; });
      else
        setState(() { priceUnit="${value[0]}${value[1]} Crore"; });
    }
    else if(length==10){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { priceUnit="${value[0]}.${value[1]}${value[2]} Arab"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { priceUnit="${value[0]}.${value[1]} Arab"; });
      else
        setState(() { priceUnit="${value[0]} Arab"; });
    }
    else if(length==11){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Arab"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { priceUnit="${value[0]}${value[1]}.${value[2]} Arab"; });
      else
        setState(() { priceUnit="${value[0]}${value[1]} Arab"; });
    }
    else if(length==12){
      if(value[3]!='0' && value[4]!='0' || value[3]=='0' && value[4]!='0' )
        setState(() { priceUnit="${value[0]}${value[1]}${value[2]}.${value[3]}${value[4]} Arab"; });
      else if(value[3]!='0' && value[4]=='0')
        setState(() { priceUnit="${value[0]}${value[1]}${value[2]}.${value[3]} Arab"; });
      else
        setState(() { priceUnit="${value[0]}${value[1]}${value[2]} Arab"; });
    }




    if (length <= 3) {
      formattedValue = value;
    } else if (length == 4) {
      formattedValue = value.substring(0, 1) + ',' + value.substring(1);
    } else if (length == 5) {
      formattedValue = value.substring(0, 2) + ',' + value.substring(2);
    } else if (length == 6) {
      formattedValue = value.substring(0, 3) + ',' + value.substring(3);
    } else if (length == 7 ) {
      formattedValue = value.substring(0, 1) +
          ',' +
          value.substring(1, 4) +
          ',' +
          value.substring(4);
    }else if (length == 8 ) {
      formattedValue = value.substring(0, 2) +
          ',' +
          value.substring(2, 5) +
          ',' +
          value.substring(5);
    }else if (length == 9 ) {
      formattedValue = value.substring(0, 3) +
          ',' +
          value.substring(3, 6) +
          ',' +
          value.substring(6);
    }else if (length == 10) {
      formattedValue = value.substring(0, 1) +
          ',' +
          value.substring(1, 4) +
          ',' +                                 //  10 =>  1,000,000,000
          value.substring(4,7)+                 //  11 =>  100,000,000
          ','+
          value.substring(7);
    }else if (length == 11 ) {
      formattedValue = value.substring(0, 2) +
          ',' +
          value.substring(2, 5) +
          ',' +
          value.substring(5,8)+
          ','+
          value.substring(8);
    }
    else if (length == 12 ){
      formattedValue = value.substring(0, 3) +
          ',' +
          value.substring(3, 6) +
          ',' +
          value.substring(6,9)+
          ','+
          value.substring(9);
    }

    // Check if the user deleted a digit after the comma


    setState(() {
    priceController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    });
  }
}// class ending


class City {
  final String country;
  final String name;
  final double lat;
  final double lng;

  City({
    required this.country,
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      country: json['country'] as String,
      name: json['name'] as String,
      lat: double.parse(json['lat'] as String),
      lng: double.parse(json['lng'] as String),
    );
  }
}

//'Marla', 'Kanal','Sq.Ft','Sq.M','Sq.Yd'