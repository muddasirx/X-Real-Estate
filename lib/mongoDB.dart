
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_app/connection.dart';

class MongoDB {
  static var db, collection;

  static connect() async {
    db = await Db.create(mongoURL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print("STATUS : $status");
    collection = db.collection(collectionName);
  }

  static Future<bool> insert(var data) async {
    // connect();
    try {
      var result = await collection.insertOne(data);
      if (result.isSuccess) {
        return true;
      }
      else
        return false;
    }
    catch (error) {
      print(error.toString());
      return false;
    }
  }

  static Future<bool> check(var c, var p) async {
    var query = where.eq('CNIC', c).eq('Password', p);
    var result = await collection.findOne(query);
    if (result != null)
      return true;
    else
      return false;
  }
  static Future<Map<String, dynamic>> fetchUserData(var c) async {
    var query = where.eq('CNIC', c);
    var result = await collection.findOne(query);
    return result as Map<String, dynamic>;
  }

  static Future<bool> updateData(var data) async {
    // connect();
    final query = where.eq('_id', data["_id"]);
    try{

      final update = ModifierBuilder()
          .set('Name', data['Name'])
          .set('CNIC', data['CNIC'])
          .set('Gender', data['Gender'])
          .set('Age', data['Age'])
          .set('DOB', data['DOB'])
          .set('ContactNumber', data['ContactNumber'])
          .set('Email', data['Email']);

      await collection.update(query, update);
      return true;
    }
    catch(e){
      return false;
    }
  }
  static Future<bool> updatePassword(var c,var p) async {
    // connect();
    final query = where.eq('CNIC',c);
    try{
      final update = ModifierBuilder()
          .set('Password', p);

      await collection.update(query, update);
      return true;
    }
    catch(e){
      return false;
    }
  }
  static Future<bool> deleteAccount(var c) async {
    try{
      await collection.deleteMany({'CNIC': c});
      return true;
    }
    catch(e){
      return false;
    }
  }
  static Future<bool> checkUser(var c) async {
    var query = where.eq('CNIC', c);
    var result = await collection.findOne(query);
    if (result != null)
      return true;
    else
      return false;
  }
  static Future<bool> uploadData(var data) async {
    // connect();
    try {
      var result = await collection.insertOne(data);
      if (result.isSuccess) {
        return true;
      }
      else
        return false;
    }
    catch (error) {
      print(error.toString());
      return false;
    }
  }
  static Future<bool> updateNumberOfUserPosts(var c,var id) async{
    final query = where.eq('CNIC',c);
    var result = await collection.findOne(query);
    var postIDs=result['Post Id'];
    postIDs.add(id);
    try{
      final update = ModifierBuilder()
          .set('Post Id', postIDs);

      await collection.update(query, update);
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }

  }

  static Future<bool> removePostId(var c,var id)async{
    var result = await collection.findOne(where.eq('CNIC',c));
    var pid=result['Post Id'];
    pid.remove(id);
    try{
      final update = ModifierBuilder()
          .set('Post Id', pid);

      await collection.update(where.eq('CNIC',c), update);
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  static Future<void> addFavourites(var id,var cnic) async{
    var query=where.eq('CNIC',cnic);
    var result = await collection.findOne(query);
    result['Favourite Ads'].add(id);

    final update = ModifierBuilder()
        .set('Favourite Ads', result['Favourite Ads']);

    await collection.update(query, update);
  }
  static Future<void> removeFavourites(var id,var cnic) async{
    var query=where.eq('CNIC',cnic);
    var result = await collection.findOne(query);
    result['Favourite Ads'].remove(id);

    final update = ModifierBuilder()
        .set('Favourite Ads', result['Favourite Ads']);

    await collection.update(query, update);
  }

  static Future<dynamic> fetchFavAds(var cnic) async{
    var query = where.eq('CNIC',cnic);
    var result = await collection.findOne(query);
    return result['Favourite Ads'];
  }
}