import 'package:mongo_dart/mongo_dart.dart';

class User {
  String name;
  String cnic;
  String gender;
  String age;
  String dob;
  String contactNumber;
  String email;
  String password;

  User({
    required this.name,
    required this.cnic,
    required this.gender,
    required this.age,
    required this.dob,
    required this.contactNumber,
    required this.email,
    required this.password,
  });

}
