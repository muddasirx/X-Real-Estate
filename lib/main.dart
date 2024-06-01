import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/MongoDB_Ad_Connection.dart';
import 'package:my_app/mongoDB.dart';
import 'package:my_app/pages/NavBar/Home_page.dart';
import 'package:my_app/pages/NavBar.dart';
import 'package:my_app/pages/NavBar/ProfilePage/ChangePassword.dart';
import 'package:my_app/pages/NavBar/ProfilePage/DeleteProfile.dart';
import 'package:my_app/pages/NavBar/ProfilePage/MyAds.dart';
import 'package:my_app/pages/NavBar/ProfilePage/MyAds/UpdatePropertyAd.dart';
import 'package:my_app/pages/NavBar/ProfilePage/UpdateProfileDetails.dart';
import 'package:my_app/pages/NavBar/post.dart';
import 'package:my_app/pages/NavBar/settingsPage/AboutUs.dart';
import 'package:my_app/pages/NavBar/settingsPage/PrivacyPolicy.dart';
import 'package:my_app/pages/SplashPage.dart';
import 'package:my_app/pages/filterPage.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/pages/sign-up.dart';
import 'package:my_app/pages/viewAd.dart';
import 'package:my_app/pages/NavBar/SearchAd.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check internet connectivity
  bool isOnline = await InternetConnectionChecker().hasConnection;

  // Establish MongoDB connection if internet is available
  if (isOnline) {
    await MongoDB.connect();
    await MongoAD.connect();
  }

  runApp(MyApp(isOnline: isOnline));
}

class MyApp extends StatelessWidget {
  final bool isOnline;

  const MyApp({Key? key, required this.isOnline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'X Real Estate',
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => NavBar(),//"/": (context) => SplashPage()
          "/homeRoute": (context) => HomePage(),
          "/signUpRoute": (context) => SignUpPage(),
          "/loginRoute": (context) => LoginPage(),
          "/postPage": (context) => PostPage(),
          "/NavBar": (context) => NavBar(),
          "/UpdateProfile": (context) => UpdateProfileDetails(),
          "/UpdatePropertyAd": (context) => UpdatePropertyAd(data:null),
          "/DeleteProfile": (context) => DeleteProfile(),
          "/AboutUs": (context) => AboutUs(),
          "/PrivacyPolicy": (context) => PrivacyPolicy(),
          "/SplashScreen": (context) => SplashPage(),
          "/myAds": (context) => myAds(),
          "/viewAd": (context) => viewAd(data:null),
          "/ChangePassword": (context) => ChangePassword(),
          "/SearchAd": (context) => SearchAd(data:null),
          "/searchFilter":(context) => searchFilter(s:null,p:null),
        },
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,
              if (!isOnline)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: AlertDialog(
                      title: Text('Network Error'),
                      content:
                      Text('Please check your internet connection and try again.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Check internet connection again
                            InternetConnectionChecker().hasConnection.then((value) {
                              if (value) {
                                // Re-establish MongoDB connection
                                MongoDB.connect();
                              }
                            });
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
        initialRoute: '/',
      ),
      designSize: const Size(392.72727272727275, 850.9090909090909),
    );
  }
}





/*
Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await MongoDB.connect();

 /*Platform.isAndroid?
 await Firebase.initializeApp(
   options: const FirebaseOptions(
     apiKey: "AIzaSyDTVkdpYVDMKC0HsoCE4WTbHNrvWvRUuWs",
     appId: "1:250796663970:android:4199dee8012f863372a3fb",
     messagingSenderId: "250796663970",
     projectId: "the-x-real-estate",
   ),
 ):*/
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {


  const MyApp({super.key});


  void initState(){
    //super.initState();

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context,child) => MaterialApp(
        title: 'X Real Estate',
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => SplashPage(),
          "/homeRoute": (context) => HomePage(),
          "/signUpRoute": (context) => SignUpPage(),
          "/loginRoute": (context) => LoginPage(),
          "/postPage": (context) => PostPage(),
          "/NavBar": (context) => NavBar(),
          "/UpdateProfile": (context) =>UpdateProfileDetails(),
          "/UpdatePropertyAd": (context) =>UpdatePropertyAd(),
          "/DeletePropertyAd": (context) =>DeletePropertyAd(),
          "/DeleteProfile": (context) =>DeleteProfile(),
          "/AboutUs": (context) =>AboutUs(),
          "/PrivacyPolicy": (context) =>PrivacyPolicy(),
          "/SplashScreen": (context) =>SplashPage(),
          "/myAds": (context) =>myAds(),
          "/viewAd": (context) =>viewAd(),
          "/ChangePassword": (context) =>ChangePassword(),
          "/SearchAd": (context) =>SearchAd(status: null,),
        },
      ),
      designSize: const Size(392.72727272727275,850.9090909090909),//803.6363636363636),
    );
  }
}
*/