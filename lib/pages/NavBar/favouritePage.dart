import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/mongoDB.dart';

import '../../MongoDB_Ad_Connection.dart';
import '../viewAd.dart';
import 'Home_page.dart';

class FavouritePage extends StatefulWidget {
  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool loading = true;
  var arrAds;
  var cnic=HomePageState.cnic;

  void initState() {
    super.initState();
    fetchUserFav();
  }

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: Stack(
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
          loading? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):
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
                          "Favourites",
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
                    height: 570.h,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 2.w,color: Colors.white38),
                        borderRadius: BorderRadius.circular(15.r)
                    ),
                    child: (arrAds==null)?
                    Center(
                      child: Text("No Favourite Ads Available.",style: TextStyle(
                          fontSize: 25,
                          color:Colors.white70
                      ),),
                    )
                        :ListView.separated(
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => viewAd(data: arrAds[index]), // Assuming UpdatePropertyAd requires 'arrAds'
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
                                                        child: Image.asset( '${imagearrAds[index]}' //"assets/favourites/houseLogo.jpg"
                                                          ,fit: BoxFit.cover,), //Image.memory(imagearrAds[index],fit: BoxFit.cover)


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
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (arrAds[index]['Liked By']?.contains(cnic) == true) {
                                                MongoAD.removeLikedPost(arrAds[index]['Id'], cnic);
                                                MongoDB.removeFavourites(arrAds[index]['Id'], cnic);
                                                setState(() {
                                                  arrAds[index]['Liked By']?.remove(cnic);
                                                });
                                                Future.delayed(Duration(milliseconds: 500), () {
                                                  setState(() {
                                                    arrAds.removeAt(index);
                                                    if(arrAds.length==0)
                                                      arrAds=null;
                                                  });
                                                });
                                                // Remove cnic if it exists
                                              } else {
                                                MongoAD.addLikedPost(arrAds[index]['Id'], cnic);
                                                MongoDB.addFavourites(arrAds[index]['Id'], cnic);
                                                arrAds[index]['Liked By'] ??= []; // Initialize Liked By list if it's null
                                                arrAds[index]['Liked By']!.add(cnic); // Add cnic to Liked By list
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            arrAds[index]['Liked By']?.contains(cnic) == true
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: arrAds[index]['Liked By']?.contains(cnic) == true
                                                ? Colors.pink
                                                : Colors.white70,size: 35.sp,
                                          ),
                                        ),
                                      )

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

        


      
    ));
  }
  Future<void> fetchUserFav()async {
    var adIDs = await MongoDB.fetchFavAds(cnic);
    if (adIDs.isNotEmpty) {
      arrAds = await MongoAD.fetchFavAds(adIDs);
    }
    else
      arrAds = null;
    setState(() {
      loading = false;
    });
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
  
  String formatArea(int area,String areaType){
    if(areaType == 'Kanal')
      area=(area/20).toInt();
    else if(areaType == 'Acre')
      area=(area/160).toInt();

    return "${area} ${areaType}";
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


  
}
