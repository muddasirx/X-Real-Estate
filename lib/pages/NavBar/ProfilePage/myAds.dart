import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/MongoDB_Ad_Connection.dart';
import 'package:my_app/pages/viewAd.dart';
import 'package:path_provider/path_provider.dart';

import '../Home_page.dart';
import 'MyAds/UpdatePropertyAd.dart';


class myAds extends StatefulWidget {

  @override
  State<myAds> createState() => _myAdsState();
}


class _myAdsState extends State<myAds> {
  List<XFile> imageData=[];
  var cnic=HomePageState.cnic;
  var arrAds;
  bool isLoading=true;
// This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    fetchUserAds();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body:Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff091e3a), Color(0xff2f80ed), Color(0xff3d2fed)],
                    stops: [0.05, 1, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              isLoading? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):
              Column(
                children: [
                SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.h,left: 14.w, right: 14.w),
                      child: Container(
                        //height: 80,

                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 2.w,color: Colors.white38),
                            borderRadius: BorderRadius.circular(15.r)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 26.h),
                          child: Center(
                            child: Text(
                              "My Ads",
                              style: GoogleFonts.libreBaskerville(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  //decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 11.h, left: 14.w,right: 14.w),
                      child:Container (
                        height: 675.h,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 2.w,color: Colors.white38),
                            borderRadius: BorderRadius.circular(15.r)
                        ),
                        child:(arrAds==null)?
                        Center(
                          child: Text("No Ads posted yet.",style: TextStyle(
                            fontSize: 25,
                            color:Colors.white70
                          ),),
                        ):
                        ListView.separated(
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => viewAd(data: arrAds[index]), // Assuming UpdatePropertyAd requires 'data'
                                      ));
                                },
                                child: Padding(
                                  padding: (index==(arrAds.length-1))?EdgeInsets.only(bottom: 25):EdgeInsets.only(bottom: 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                                  //mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    /*Padding(
                                                      padding:  EdgeInsets.only(left:15.w, bottom: 5.h),
                                                      child: Container(
                                                        height: 180.h,width: 120.w,
                                                        child: Image.asset( '${imageData[index]}' //"assets/favourites/houseLogo.jpg"
                                                          ,fit: BoxFit.cover,), //Image.memory(imageData[index],fit: BoxFit.cover)


                                                      ),
                                                    ),*/
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 15.w),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(width: 20.w,),
                                                              Text("PKR ",
                                                                  style: GoogleFonts.schibstedGrotesk(
                                                                    textStyle: TextStyle(
                                                                      color: Colors.white54,
                                                                      fontSize: 16.sp,

                                                                    ),
                                                                  )
                                                              ),
                                                              Text(formatPrice(arrAds[index]['Price'].toString()),
                                                                  style: GoogleFonts.schibstedGrotesk(
                                                                    textStyle: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 26.sp,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top:5.h,right: 0.w,left: 0.w ),
                                                            child: Text(checkState(arrAds[index]['State'],arrAds[index]['Property']),
                                                                style: GoogleFonts.raleway(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.white70,
                                                                    fontSize: 15.sp,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:  EdgeInsets.only(top:15.h,right: 0.w),
                                                            child: Text(formatArea(arrAds[index]['Area'],arrAds[index]['Area Type']),
                                                                style: GoogleFonts.schibstedGrotesk(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 19.sp,
                                                                    //fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top:5.h,left: 20.w),
                                                            child: Text(arrAds[index]['Location']+" , "+arrAds[index]['City'],
                                                                style: GoogleFonts.raleway(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 19.sp,
                                                                    //fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top:20.h,right: 0.w,left: 0.w ),
                                                            child: (arrAds[index]['Property']=='House')?
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.bed_outlined, // Replace with the desired icon
                                                                  color: Colors.white54,
                                                                  size: 24.sp,
                                                                ),
                                                                Text(" : "+arrAds[index]['No. of bedrooms'], style: GoogleFonts.raleway(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 17.sp,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                                ),
                                                                SizedBox(width: 30.w,),
                                                                Icon(
                                                                  Icons.bathtub_outlined, // Replace with the desired icon
                                                                  color: Colors.white54,
                                                                  size: 24.sp,
                                                                ),
                                                                Text(" : "+arrAds[index]['No. of washrooms'], style: GoogleFonts.raleway(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 17.sp,
                                                                    // fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                                ),
                                                              ],
                                                            ):SizedBox(height: 0,), //Part of a if else statement
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),


                                          Padding(
                                            padding: EdgeInsets.only(bottom: 130.h),
                                            child: PopupMenuButton<String>(
                                              color:Colors.white,
                                              icon: Icon(
                                                Icons.more_vert, // Change the icon to more_vert
                                                color: Colors.white, // Change the color of the icon
                                              ),
                                              onSelected: (value) {
                                                if (value == 'update') {
                                                  print("Array Ad : "+arrAds[index].toString());
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => UpdatePropertyAd(data: arrAds[index]), // Assuming UpdatePropertyAd requires 'data'
                                                    ),
                                                  );
                                                } else if (value == 'delete') {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                    return DeleteAd(index);
                                                  }
                                                  );
                                                }
                                              },
                                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: 'update',
                                                  child: Text('Update Ad',),
                                                ),
                                                 PopupMenuDivider(),
                                                 PopupMenuItem<String>(
                                                  value: 'delete',
                                                  child: Container(
                                                      child: Text('Delete Ad'),
                                                    //color: Colors.white38,
                                                  ),

                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: (arrAds.length==1 && index==0||arrAds.length==2 && index==1),
                                          child:Padding(
                                            padding: EdgeInsets.only(top: 20.h),
                                            child: Divider(
                                              thickness: 2.sp,
                                              color: Colors.white38,
                                            ),
                                          ),)
                                    ],
                                  ),
                                ),
                              );

                            },
                            separatorBuilder: (context,index){
                              return Divider(height: 70.h,thickness: 2.sp,color: Colors.white38,);
                            },
                            itemCount: arrAds.length),
                      )
                  )
                ],
              ),
            ],
          ),

        )
    );

  }
  Future<void> fetchUserAds()async{
    arrAds= await MongoAD.getAds(cnic);
  /*  if(arrAds!=null) {
      print("converting images now!");
      final Directory directory = await getApplicationDocumentsDirectory();
      for (int i = 0; i < arrAds.length; i++) {
        setState(() {
          imageData.add(Image.file(File('${directory.path}/${arrAds[i]['Id']}_0.${arrAds[i]['Extension'][0]}')) as XFile);
        });
      }
    }
   print("image Data = "+imageData.toString());*/
    setState(() {
      isLoading=false;
    });
   // print(imageData);
    print("Array Data : "+arrAds.toString());
    //print("Lenght of Array : "+arrAds.length.toString());

  }

  Widget DeleteAd(int index){
    return AlertDialog(
      title: Text('Delete Ad'),
      content: Text('Are you sure you want to delete this ad?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async{
            if(await MongoAD.deleteAd(arrAds[index]['Id'], cnic)){
               setState(() { arrAds.removeAt(index); });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ad Deleted Successfully."),duration: Duration(seconds: 3),));
                  Navigator.of(context).pop();

             }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Problem occured while deleting ad."),duration: Duration(milliseconds: 1300),backgroundColor: Color(0xffaa0000)));
              Navigator.of(context).pop();
            }
            if(arrAds.isEmpty){
              setState(() {
                arrAds=null;
              });
            }

          },
          child: Text('Delete'),
        ),
      ],
    );
  }
  String checkState(String state,String property){
    if(state=="Sell" && property=="House"){
      return "House for Sale";
    }
    else if(state=="Sell" && property=="Plot"){
      return "Plot for Sale";
    }
    else if(state=="Rent" && property=="Plot"){
      return "Plot for Rent";
    }
    else
      return "House for Rent";
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
}   // Sign Up button
