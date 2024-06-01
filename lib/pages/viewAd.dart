import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/mongoDB.dart';


class viewAd extends StatefulWidget {
  var data;
  viewAd({Key? key, this.data}) : super(key: key);
  @override
  State<viewAd> createState() => _viewAdState();
}

class _viewAdState extends State<viewAd> {
  var owner;
  bool loading=true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }



// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var data=widget.data;
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
              child:  loading? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):
              SafeArea(
                child:Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 14.w, right: 14.w,bottom: 15.h),
                    child:Column(
                      children: [
                        Container(
                          width: 400.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: Colors.white38),
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.transparent,
                          ),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical:20.h ),
                            child:Align(
                              alignment: Alignment.center,
                              child:Text(
                                "Ad Details",
                                style: GoogleFonts.libreBaskerville(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.sp,
                                  ),
                                ),)
                          ),
                          ) ,
                        ),
                        SizedBox(height:15.h ,),
                        Container(
                          width: 400.w,
                          height: 680.h,
                           // height: 670.h,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: Colors.white38),
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.transparent,
                          ),
                          child:SingleChildScrollView(
                              child:Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,top:20.h,bottom: 20.h),
                                    child:propertyState()

                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,top:10.h),
                                    child: Row(
                                      children: [
                                        Text("Price",style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold
                                        ),),
                                        Text((data['State']=='Rent')?" (per month) :  ":":  ",style: TextStyle(
                                            fontSize: 17.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text(formatPrice(data['Price'].toString()),style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                        ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,top: 15.h),
                                    child: Row(
                                      children: [
                                        Text("Area:   ",style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text(formatArea(data['Area'],data['Area Type']),style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,top: 15.h),
                                    child: Row(
                                      children: [
                                        Text("Location:   ",style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text("${data['Location']} , ${data['City']}",style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ))
                                      ],
                                    ),
                                  ),
                                  propertyDetails(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.w,top: 40.h),
                                          child: Text("Description:   ",style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold
                                          )),

                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:  EdgeInsets.only(left:20.w,top: 8.h,right: 20.w),
                                      child: Text("${widget.data['Description']} ",softWrap:true,style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.w,top: 60.h),
                                      child: Text(
                                        "Owner Details :",
                                        style: GoogleFonts.libreBaskerville(
                                          textStyle: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 22.sp,
                                              fontWeight: FontWeight.bold
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,top: 15.h),
                                    child: Row(
                                      children: [
                                        Text("Name:   ",style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text("${owner['Name']}",style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w,top: 05.h),
                                    child: Row(
                                      children: [
                                        Text("Contact number:   ",style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text("${owner['ContactNumber']}",style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ))
                                      ],
                                    ),
                                  ),
                                  (data['Description'].length>39)?SizedBox(height: 40.h,):SizedBox()

                                ],
                              )
                          )
                        ),
                      ],
                    )
                )
              )
            ),


        )
    );
  }
  Widget propertyState(){
    if(widget.data['State']=='Sell'){
      return  (widget.data['Property']=='House')?
      Text("House for Sale  ",style: GoogleFonts.libreBaskerville(
        textStyle: TextStyle(
            color: Colors.white70,
            fontSize: 22.sp,
          fontWeight: FontWeight.bold
        ),
      ),):Text("Plot for Sale  ",style: GoogleFonts.libreBaskerville(
        textStyle: TextStyle(
            color: Colors.white70,
            fontSize: 22.sp,
          fontWeight: FontWeight.bold
        ),
      ),);
    }else{
      return  (widget.data['Property']=='House')?
      Text("House for Rent  ",style: GoogleFonts.libreBaskerville(
        textStyle: TextStyle(
            color: Colors.white70,
            fontSize: 22.sp,
          fontWeight: FontWeight.bold
        ),
      ),):Text("Plot for Rent  ",style: GoogleFonts.libreBaskerville(
        textStyle: TextStyle(
            color: Colors.white70,
            fontSize: 22.sp,
          fontWeight: FontWeight.bold
        ),
      ),);
    }
  }
  Widget propertyDetails(){
    if(widget.data['Property']=='House'){
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w,top: 25.h),
            child: Row(
              children: [
                Icon(Icons.bed_rounded,color: Colors.white70,size: 25.sp,),
                Text(" :  ${widget.data['No. of bedrooms']}",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w,top: 18.h),
            child: Row(
              children: [
                Icon(Icons.bathtub_outlined,color: Colors.white70,size: 25.sp,),
                Text(" :  ${widget.data['No. of washrooms']}",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w,top: 25.h),
            child: Row(
              children: [
                Icon(Icons.circle,color: Colors.white70,size: 9.sp,),
                Text((widget.data['Furnished'])?"  Furnished":"  Non-Furnished",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w,top: 10.h),
            child: Row(
              children: [
                Icon(Icons.circle,color: Colors.white70,size: 9.sp,),
                Text(checkStorey(),style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ))
              ],
            ),
          ),


        ],
      );
    }
    else{
      return Column(
        children:[
        Padding(
          padding: EdgeInsets.only(left: 20.w,top: 15.h),
          child: Row(
            children: [
              Text("Plot Type:   ",style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white70,
                  fontWeight: FontWeight.bold
              )),
              Text("${widget.data['Plot Type']} ",style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
              ))
            ],
          ),
        ),

        ]
      );
    }
  }
  String checkStorey(){
    if(widget.data['No. of floors']=="Single")
      return "  Single Storey";
    else if(widget.data['No. of floors']=="Double")
      return "  Double Storey";
    else
      return "  Triple Storey";
  }
 Future<void> fetchUser() async{
   owner=await MongoDB.fetchUserData(widget.data['Owner CNIC']);
   if(owner.isNotEmpty){
     setState(() {
       loading=false;
     });
   }
   else
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Server Error: Something went wrong!"),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000)));

 }
  String formatPrice(String value) {
    int length = value.length;
    String priceUnit='';
    if (length == 4) {
      if (value[1] != '0' && value[2] != '0' || value[1] == '0' && value[2] != '0')
        priceUnit = "${value[0]}.${value[1]}${value[2]} Thousand";
      else if (value[1] != '0' && value[2] == '0')
        priceUnit = "${value[0]}.${value[1]} Thousand";
      else
        priceUnit = "${value[0]} Thousand";
    }
    else if (length == 5) {
      if (value[2] != '0' && value[3] != '0' || value[2] == '0' && value[3] != '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]}${value[3]} Thousand";
      else if (value[2] != '0' && value[3] == '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]} Thousand";
      else
        priceUnit = "${value[0]}${value[1]} Thousand";
    }
    else if (length == 6) {
      if (value[1] != '0' && value[2] != '0' || value[1] == '0' && value[2] != '0')
        priceUnit = "${value[0]}.${value[1]}${value[2]} Lac";
      else if (value[1] != '0' && value[2] == '0')
        priceUnit = "${value[0]}.${value[1]} Lac";
      else
        priceUnit = "${value[0]} Lac";
    }
    else if (length == 7) {
      if (value[2] != '0' && value[3] != '0' || value[2] == '0' && value[3] != '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]}${value[3]} Lac";
      else if (value[2] != '0' && value[3] == '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]} Lac";
      else
        priceUnit = "${value[0]}${value[1]} Lac";
    }
    else if (length == 8) {
      if (value[1] != '0' && value[2] != '0' || value[1] == '0' && value[2] != '0')
        priceUnit = "${value[0]}.${value[1]}${value[2]} Crore";
      else if (value[1] != '0' && value[2] == '0')
        priceUnit = "${value[0]}.${value[1]} Crore";
      else
        priceUnit = "${value[0]} Crore";
    }
    else if (length == 9) {
      if (value[2] != '0' && value[3] != '0' || value[2] == '0' && value[3] != '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]}${value[3]} Crore";
      else if (value[2] != '0' && value[3] == '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]} Crore";
      else
        priceUnit = "${value[0]}${value[1]} Crore";
    }
    else if (length == 10) {
      if (value[1] != '0' && value[2] != '0' || value[1] == '0' && value[2] != '0')
        priceUnit = "${value[0]}.${value[1]}${value[2]} Arab";
      else if (value[1] != '0' && value[2] == '0')
        priceUnit = "${value[0]}.${value[1]} Arab";
      else
        priceUnit = "${value[0]} Arab";
    }
    else if (length == 11) {
      if (value[2] != '0' && value[3] != '0' || value[2] == '0' && value[3] != '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]}${value[3]} Arab";
      else if (value[2] != '0' && value[3] == '0')
        priceUnit = "${value[0]}${value[1]}.${value[2]} Arab";
      else
        priceUnit = "${value[0]}${value[1]} Arab";
    }
    else if (length == 12) {
      if (value[3] != '0' && value[4] != '0' || value[3] == '0' && value[4] != '0')
        priceUnit = "${value[0]}${value[1]}${value[2]}.${value[3]}${value[4]} Arab";
      else if (value[3] != '0' && value[4] == '0')
        priceUnit = "${value[0]}${value[1]}${value[2]}.${value[3]} Arab";
      else
        priceUnit = "${value[0]}${value[1]}${value[2]} Arab";
    }
    else
      return value;
    return priceUnit;
  }
  String formatArea(int area,String areaType){
    if(areaType == 'Kanal')
      area=(area/20).toInt();
    else if(areaType == 'Acre')
      area=(area/160).toInt();

    return "${area} ${areaType}";
  }
}