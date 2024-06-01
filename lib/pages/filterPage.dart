import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/mongoDB.dart';
import 'package:my_app/pages/NavBar/SearchAd.dart';

import 'NavBar/post.dart';


class searchFilter extends StatefulWidget {
  var s,p;
  searchFilter({Key? key, this.s,this.p}) : super(key: key);
  @override
  State<searchFilter> createState() => _searchFilterState();
}

class _searchFilterState extends State<searchFilter> {
  String minPriceUnit='';
  String maxPriceUnit='';
  var owner;
  var minAreaController= new TextEditingController();
  var maxAreaController= new TextEditingController();
  var minPriceController= new TextEditingController();
  var maxPriceController= new TextEditingController();
  var cityController = new TextEditingController();
  String areaType='Marla';
  List<City>? cities;
  String? selectedCity;
  String dropDownChoose = 'Buy';
  String dropDownProprty = 'House';
  var data;
  FocusNode minPriceFocusNode= FocusNode();
  FocusNode maxPriceFocusNode = FocusNode();
  FocusNode minAreaFocusNode= FocusNode();
  FocusNode maxAreaFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  bool hasFocus=false;
  @override
  void initState() {
    super.initState();
    loadCities().then((data) => setState(() => cities = data));
    dropDownProprty= widget.p;
    dropDownChoose = widget.s;
    minPriceFocusNode.addListener(() {
      setState(() {
        hasFocus = minPriceFocusNode.hasFocus;
      });
    });
    maxPriceFocusNode.addListener(() {
      setState(() {
        hasFocus = maxPriceFocusNode.hasFocus;
      });
    });
    cityFocusNode.addListener(() {
      setState(() {
        hasFocus = cityFocusNode.hasFocus;
      });
    });
    minAreaFocusNode.addListener(() {
      setState(() {
        hasFocus = minAreaFocusNode.hasFocus;
      });
    });
    maxAreaFocusNode.addListener(() {
      setState(() {
        hasFocus = maxAreaFocusNode.hasFocus;
      });
    });
  }
  @override
  void dispose() {
    minPriceFocusNode.dispose();
    maxPriceFocusNode.dispose();
    cityFocusNode.dispose();
    minAreaFocusNode.dispose();
    maxAreaFocusNode.dispose();
    super.dispose();
  }


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
                  child:Padding(
                      padding: EdgeInsets.only(top: 15.h, left: 14.w, right: 14.w,bottom: 15.h),
                      child:Container(
                              width: 400.w,
                              height: 985.h,
                              // height: 670.h,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2.w, color: Colors.white38),
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.transparent,
                              ),
                          child:SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 40.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Choose : ",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.sp,
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
                                          fontSize: 18.sp,
                                        ),
                                        underline: Container(
                                          height: 2.h,
                                          color: Colors.white54,
                                        ),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white70,
                                        ),
                                        items: <String>['Buy', 'Rent']
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
                                  padding:  EdgeInsets.only(left:20.w ,top:20.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Property : ",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.sp,
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
                                          fontSize: 18.sp,
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
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:20.w,top:50.h),
                                  child: Row(
                                    children: [
                                      Icon(Icons.height_outlined,color: Colors.white60,size: 23.sp,),
                                      Text("Area Range",style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:25.w,top:20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 23.h),
                                        child: Container(
                                            width: 80,
                                            child:TextFormField(
                                              keyboardType: TextInputType.number,
                                              controller: minAreaController,
                                              focusNode: minAreaFocusNode,
                                              style: TextStyle(color: Colors.white),
                                              cursorColor: Colors.white60,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: 20.w),
                                                errorStyle: TextStyle(color: Colors.red),
                                                hintText: "Min",
                                                hintStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.white70,
                                                ),
                                                focusedErrorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2.w,
                                                  color: Colors.white70, // Customize the error border color as needed
                                                ),
                                              ),
                                                errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2.w,
                                                    color: Colors.red, // Customize the error border color as needed
                                                  ),
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
                                              ),
                                            )
                                        ),
                                      ),
                                      Text("To",style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold

                                      ),),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 23.h),
                                        child: Container(
                                            width: 80,
                                            child:TextFormField(
                                              keyboardType: TextInputType.number,
                                              controller: maxAreaController,
                                              focusNode: maxAreaFocusNode,
                                              style: TextStyle(color: Colors.white),
                                              cursorColor: Colors.white60,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: 20.w),
                                                errorStyle: TextStyle(color: Colors.red),
                                                hintText: "Max",
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
                                                focusedErrorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2.w,
                                                    color: Colors.white70, // Customize the error border color as needed
                                                  ),
                                                ),
                                                errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2.w,
                                                    color: Colors.red, // Customize the error border color as needed
                                                  ),
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w,bottom: 5.h),
                                        child: DropdownButton<String>(
                                          value: areaType,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              areaType = newValue!;
                                            });
                                          },
                                          dropdownColor: Colors.grey[800],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
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
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      SizedBox(width: 7.w,)
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top:40.h,left: 20.w,right: 0.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 250.w,
                                        child: TypeAheadField<City>(
                                          textFieldConfiguration: TextFieldConfiguration(
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                              keyboardType: TextInputType.text,
                                              autofocus: false,
                                              focusNode: cityFocusNode,
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
                                                  hintText: 'City',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white70,
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp
                                                  ),
                                                  prefixIcon: Icon(Icons.location_city_outlined,color: Colors.white54,size:25.sp)
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
                                        padding:EdgeInsets.only(top: 40.h),
                                        child: Text("  (Optional)",style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white70,
                                          // fontWeight: FontWeight.bold
                                        ),),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:20.w,top:80.h),
                                  child: Row(
                                    children: [
                                      Icon(Icons.attach_money_sharp,color: Colors.white60,size: 23.sp,),
                                      Text("Price Range",style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text("  (Optional)",style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white70,
                                         // fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:16.w,top:20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 0.h),
                                        child: Container(
                                          width: 133,
                                          child:TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: minPriceController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(15),
                                            ],
                                            focusNode: minPriceFocusNode,
                                            style: TextStyle(color: Colors.white),
                                            cursorColor: Colors.white60,
                                            onChanged: formatMinPrice,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: 5.w),
                                              errorStyle: TextStyle(color: Colors.red),
                                              hintText: "      Min",
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
                                            ),
                                          ),
                                        ),

                                      ),
                                      SizedBox(width: 8.w,),
                                      Padding(
                                        padding: EdgeInsets.only(top:23.h),
                                        child: Text("To",style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold

                                        ),),
                                      ),
                                      SizedBox(width: 8.w,),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 0.h),
                                        child: Container(
                                            width: 133,
                                            child:TextFormField(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(15),
                                              ],
                                              controller: maxPriceController,
                                              focusNode: maxPriceFocusNode,
                                              style: TextStyle(color: Colors.white),
                                              onChanged: formatMaxPrice,
                                              cursorColor: Colors.white60,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: 5.w),
                                                errorStyle: TextStyle(color: Colors.red),
                                                hintText: "      Max",
                                                hintStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.white70,
                                                ),errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(29.r),
                                                borderSide: BorderSide(
                                                  width: 2.w,
                                                  color: Colors.red, // Customize the error border color as needed
                                                ),
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
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 7.w,)
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 190.w,
                                      child: Visibility(
                                        visible: minPriceUnit.isNotEmpty,
                                        child: Padding(
                                          padding: EdgeInsets.only(top:5.h,left: 23),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(minPriceUnit,style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white60,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Visibility(
                                      visible: maxPriceUnit.isNotEmpty,
                                      child: Padding(
                                        padding: EdgeInsets.only(top:5.h,left: 30),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(maxPriceUnit,style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                                SizedBox(height: 60.h,),
                                ElevatedButton(
                                  onPressed: (){
                                    if(checkArea()){
                                      if(checkPrice()){
                                        objectCreation();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchAd(
                                                data:
                                                data), // Assuming UpdatePropertyAd requires 'data'
                                          ),
                                        );
                                      }
                                    }

                                },
                                  child: Text("Submit",style: TextStyle(
                                    fontSize: 17.sp,

                                  ),),
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(Size(100.sp, 40.sp)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.white70)
                                        )
                                    ),
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),

                                  ),
                                ),
                                Visibility(
                                    visible: true,//showSizedBox,
                                    child: SizedBox(height: hasFocus?230:0)
                                ),

                              ],
                            ),
                          )
                          ),

                  )
              )
          ),


        )
    );
  }
  Future<List<City>> loadCities() async {
    final response = await rootBundle.loadString('assets/cities.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((city) => City.fromJson(city)).toList();
  }
  void objectCreation(){
    if(minPriceController.text.isEmpty)
      minPriceController.text='0';
    if(maxPriceController.text.isEmpty)
      maxPriceController.text='0';

    var min=int.parse(minAreaController.text);
    var max=int.parse(maxAreaController.text);
    if(areaType == 'Kanal'){
      min=min*20;
      max=max*20;
    }
    else if(areaType == 'Acre'){
      min=min*160;
      max=max*160;
    }
    var state= (dropDownChoose=="Buy")?"Sell":"Rent";
    data={
      "State":state,
      "Property":dropDownProprty,
      "minArea":min,
      "maxArea":max,
      "Area Type":areaType,
      "City":cityController.text,
      "minPrice":int.parse(minPriceController.text.replaceAll(',', '')),
      "maxPrice":int.parse(maxPriceController.text.replaceAll(',', '')),
    };
  }
  void formatMinPrice(String value) {
    value = value.replaceAll(',', '');

    if (value.isEmpty) {
      minPriceController.value = TextEditingValue.empty;
      return;
    }

    int length = value.length;
    String formattedValue = '';
    if(length<4)
      setState(() { minPriceUnit=""; });
    else if(length==4){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { minPriceUnit="${value[0]}.${value[1]}${value[2]} Thousand"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { minPriceUnit="${value[0]}.${value[1]} Thousand"; });
      else
        setState(() { minPriceUnit="${value[0]} Thousand"; });
    }
    else if(length==5){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Thousand"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]} Thousand"; });
      else
        setState(() { minPriceUnit="${value[0]}${value[1]} Thousand"; });
    }
    else if(length==6){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { minPriceUnit="${value[0]}.${value[1]}${value[2]} Lac"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { minPriceUnit="${value[0]}.${value[1]} Lac"; });
      else
        setState(() { minPriceUnit="${value[0]} Lac"; });
    }
    else if(length==7){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Lac"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]} Lac"; });
      else
        setState(() { minPriceUnit="${value[0]}${value[1]} Lac"; });
    }
    else if(length==8){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { minPriceUnit="${value[0]}.${value[1]}${value[2]} Crore"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { minPriceUnit="${value[0]}.${value[1]} Crore"; });
      else
        setState(() { minPriceUnit="${value[0]} Crore"; });
    }
    else if(length==9){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Crore"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]} Crore"; });
      else
        setState(() { minPriceUnit="${value[0]}${value[1]} Crore"; });
    }
    else if(length==10){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { minPriceUnit="${value[0]}.${value[1]}${value[2]} Arab"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { minPriceUnit="${value[0]}.${value[1]} Arab"; });
      else
        setState(() { minPriceUnit="${value[0]} Arab"; });
    }
    else if(length==11){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Arab"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { minPriceUnit="${value[0]}${value[1]}.${value[2]} Arab"; });
      else
        setState(() { minPriceUnit="${value[0]}${value[1]} Arab"; });
    }
    else if(length==12){
      if(value[3]!='0' && value[4]!='0' || value[3]=='0' && value[4]!='0' )
        setState(() { minPriceUnit="${value[0]}${value[1]}${value[2]}.${value[3]}${value[4]} Arab"; });
      else if(value[3]!='0' && value[4]=='0')
        setState(() { minPriceUnit="${value[0]}${value[1]}${value[2]}.${value[3]} Arab"; });
      else
        setState(() { minPriceUnit="${value[0]}${value[1]}${value[2]} Arab"; });
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
      minPriceController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    });
  }
  void formatMaxPrice(String value) {
    value = value.replaceAll(',', '');

    if (value.isEmpty) {
      maxPriceController.value = TextEditingValue.empty;
      return;
    }

    int length = value.length;
    String formattedValue = '';
    if(length<4)
      setState(() { maxPriceUnit=""; });
    else if(length==4){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { maxPriceUnit="${value[0]}.${value[1]}${value[2]} Thousand"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { maxPriceUnit="${value[0]}.${value[1]} Thousand"; });
      else
        setState(() { maxPriceUnit="${value[0]} Thousand"; });
    }
    else if(length==5){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Thousand"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]} Thousand"; });
      else
        setState(() { maxPriceUnit="${value[0]}${value[1]} Thousand"; });
    }
    else if(length==6){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { maxPriceUnit="${value[0]}.${value[1]}${value[2]} Lac"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { maxPriceUnit="${value[0]}.${value[1]} Lac"; });
      else
        setState(() { maxPriceUnit="${value[0]} Lac"; });
    }
    else if(length==7){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Lac"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]} Lac"; });
      else
        setState(() { maxPriceUnit="${value[0]}${value[1]} Lac"; });
    }
    else if(length==8){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { maxPriceUnit="${value[0]}.${value[1]}${value[2]} Crore"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { maxPriceUnit="${value[0]}.${value[1]} Crore"; });
      else
        setState(() { maxPriceUnit="${value[0]} Crore"; });
    }
    else if(length==9){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Crore"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]} Crore"; });
      else
        setState(() { maxPriceUnit="${value[0]}${value[1]} Crore"; });
    }
    else if(length==10){
      if(value[1]!='0' && value[2]!='0' || value[1]=='0' && value[2]!='0' )
        setState(() { maxPriceUnit="${value[0]}.${value[1]}${value[2]} Arab"; });
      else if(value[1]!='0' && value[2]=='0')
        setState(() { maxPriceUnit="${value[0]}.${value[1]} Arab"; });
      else
        setState(() { maxPriceUnit="${value[0]} Arab"; });
    }
    else if(length==11){
      if(value[2]!='0' && value[3]!='0' || value[2]=='0' && value[3]!='0' )
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]}${value[3]} Arab"; });
      else if(value[2]!='0' && value[3]=='0')
        setState(() { maxPriceUnit="${value[0]}${value[1]}.${value[2]} Arab"; });
      else
        setState(() { maxPriceUnit="${value[0]}${value[1]} Arab"; });
    }
    else if(length==12){
      if(value[3]!='0' && value[4]!='0' || value[3]=='0' && value[4]!='0' )
        setState(() { maxPriceUnit="${value[0]}${value[1]}${value[2]}.${value[3]}${value[4]} Arab"; });
      else if(value[3]!='0' && value[4]=='0')
        setState(() { maxPriceUnit="${value[0]}${value[1]}${value[2]}.${value[3]} Arab"; });
      else
        setState(() { maxPriceUnit="${value[0]}${value[1]}${value[2]} Arab"; });
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
      maxPriceController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    });
  }

  bool checkPrice(){
    if(minPriceController.text.isNotEmpty && maxPriceController.text.isNotEmpty){
      var min = int.parse(minPriceController.text.replaceAll(',', ''));
      var max = int.parse(maxPriceController.text.replaceAll(',', ''));
      if(min<max && min!=max)
        return true;
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Price Range!"),duration: Duration(milliseconds: 2000),backgroundColor: Color(0xffaa0000)));
        maxPriceController.text='';
        return false;
      }
  }
    else if(minPriceController.text.isEmpty && maxPriceController.text.isEmpty)
    return true;
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Price Range should be empty or completely filled!"),duration: Duration(milliseconds: 2000),backgroundColor: Color(0xffaa0000)));
      return false;
    }
  }

  bool checkArea(){
    print("check Area Body");
    try{
      if(minAreaController.text.isNotEmpty  && maxAreaController.text.isNotEmpty){
        var min = int.parse(minAreaController.text);
        var max = int.parse(maxAreaController.text);
        print("Area is not empty");
        if(min<max && min!=max)
          return true;
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Area Range!"),duration: Duration(milliseconds: 2000),backgroundColor: Color(0xffaa0000)));
          maxAreaController.text='';
          return false;
        }
      }
      else{
        print("Area is empty!");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Area Range cannot be empty!"),duration: Duration(milliseconds: 2000),backgroundColor: Color(0xffaa0000)));
        return false;
      }
    }
    catch(e){
      print("Error : "+e.toString());
      return false;
    }

  }
}