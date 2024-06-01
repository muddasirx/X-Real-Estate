import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/MongoDB_Ad_Connection.dart';
import 'package:my_app/mongoDB.dart';

import '../filterPage.dart';
import '../viewAd.dart';
import 'Home_page.dart';
class SearchAd extends StatefulWidget {
  var data;
  SearchAd({Key? key, this.data}) : super(key: key);
  State<SearchAd> createState() => _SearchAdState();
}

class _SearchAdState extends State<SearchAd> {
  var cnic=HomePageState.cnic;
  String sort='Sort By';
  bool loading = true;
  var ADsData;
  var ADsData2;
  void initState(){
    super.initState();
    searchData();
  }
  @override
  Widget build(BuildContext context) {
  var data=widget.data;
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/NavBar',
                (route) => false, // Remove all routes from the stack
          );//Navigator.pushReplacementNamed(context, "/loginRoute");
          return false; // Return false to prevent default back button behavior
        },
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
                  child: loading? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):
                  SafeArea(
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
                                      Text("Search Ad",
                                        style: GoogleFonts.libreBaskerville(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 29.sp,
                                          ),
                                        ),),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h,left: 14.w,right: 14.w),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2.w, color: Colors.white38),
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.transparent),
                                child:Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 18.w),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                            onPressed: () {
                                             Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => searchFilter(s:(data['State']=='Sell')?"Buy":"Rent",p:data['Property'], // Assuming UpdatePropertyAd requires 'data'
                                                ),
                                              ));
                                            },
                                            child: Text("Filter",style: TextStyle(fontSize:17.sp),),
                                            style: ButtonStyle(
                                              minimumSize: MaterialStateProperty.all(Size(100.sp, 40.sp)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(color: Colors.white54)
                                                  )
                                              ),
                                              foregroundColor:
                                              MaterialStateProperty.all<Color>(Colors.white),
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),

                                            ),
                                          ),
                                      SizedBox(width:20.h),
                                      DropdownButton<String>(
                                        value: sort,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              sort = newValue;
                                            });
                                            if(sort=='Price Low to High'){
                                              setState(() {
                                                ADsData.sort(asscendingPrices);
                                                print(ADsData.toString());
                                              });
                                            }
                                            else if(sort=='Price High to Low'){
                                              setState(() {
                                                ADsData.sort(desscendingPrices);
                                              });
                                            }
                                            /*else{
                                              print("Inside Sort By body");
                                                changeToBestMatch();
                                               print("Data 2 : "+ADsData2[0].toString());
                                            }*/
                                          }
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
                                          Icons.sort,
                                          color: Colors.white70,
                                        ),
                                        items: <String>['Sort By', 'Price Low to High','Price High to Low']
                                            .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding: EdgeInsets.only(right: 8.w),
                                                child: Text( value),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),

                                  )

                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:14.w,right: 14.w,top:11.h),
                            child:Container(
                              height: 583.h,
                                width: 400.w,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2.w, color: Colors.white38),
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Colors.transparent),
                            child:(ADsData.isEmpty || ADsData==null)?
                            Center(
                              child: Text("No Ads found.",style: TextStyle(
                                  fontSize: 25,
                                  color:Colors.white70
                              ),),
                            ):ListView.separated(
                                itemBuilder: (context,index){
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => viewAd(data: ADsData[index]), // Assuming UpdatePropertyAd requires 'data'
                                          ));
                                    },
                                    child: Padding(
                                      padding: (index==(ADsData.length-1))?EdgeInsets.only(bottom: 35):EdgeInsets.only(bottom: 0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: (index==0)?30.h:0.h),
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
                                                            Text("PKR  ",
                                                                style: GoogleFonts.schibstedGrotesk(
                                                                  textStyle: TextStyle(
                                                                    color: Colors.white54,
                                                                    fontSize: 16.sp,

                                                                  ),
                                                                )
                                                            ),
                                                            Text(formatPrice(ADsData[index]['Price'].toString()),
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
                                                          child: Text(checkState(ADsData[index]['State'],ADsData[index]['Property']),
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
                                                          child: Text(formatArea(ADsData[index]['Area'],ADsData[index]['Area Type']),
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
                                                          child: Text(ADsData[index]['Location']+" , "+ADsData[index]['City'],
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
                                                          child: (ADsData[index]['Property']=='House')?
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.bed_outlined, // Replace with the desired icon
                                                                color: Colors.white54,
                                                                size: 24.sp,
                                                              ),
                                                              Text(" : "+ADsData[index]['No. of bedrooms'], style: GoogleFonts.raleway(
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
                                                              Text(" : "+ADsData[index]['No. of washrooms'], style: GoogleFonts.raleway(
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
                                                      if (ADsData[index]['Liked By']?.contains(cnic) == true) {
                                                        MongoAD.removeLikedPost(ADsData[index]['Id'], cnic);
                                                        MongoDB.removeFavourites(ADsData[index]['Id'], cnic);
                                                        ADsData[index]['Liked By']?.remove(cnic); // Remove cnic if it exists
                                                      } else {
                                                        MongoAD.addLikedPost(ADsData[index]['Id'], cnic);
                                                        MongoDB.addFavourites(ADsData[index]['Id'], cnic);
                                                        ADsData[index]['Liked By'] ??= []; // Initialize Liked By list if it's null
                                                        ADsData[index]['Liked By']!.add(cnic); // Add cnic to Liked By list
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    ADsData[index]['Liked By']?.contains(cnic) == true
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: ADsData[index]['Liked By']?.contains(cnic) == true
                                                        ? Colors.pink
                                                        : Colors.white70,size: 35.sp,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Visibility(
                                            visible: (ADsData.length==1 && index==0||ADsData.length==2 && index==1),
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
                                itemCount: ADsData.length),
                            ),

                          ),
                        ]
                    ),

                  ),

                )

        ),
      ),
    );
  }
 Future<void> searchData()async {
    print("Data being fetched :  "+widget.data.toString());
    ADsData = await MongoAD.fetchSearchAds(widget.data);
    setState(() {
      loading =false;
    });
   /* if(ADsData2==null ){
      ADsData2=ADsData;
    }
    print("Data2 changed: "+ADsData2[0].toString());*/
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
  int asscendingPrices(Map<String, dynamic> a, Map<String, dynamic> b) {
    return a["Price"].compareTo(b["Price"]);
  }
  int desscendingPrices(Map<String, dynamic> a, Map<String, dynamic> b) {
    return b["Price"].compareTo(a["Price"]);
  }

  void changeToBestMatch(){
    setState(() {
      ADsData=ADsData2;
    });
  }
}

