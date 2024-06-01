import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'mongoDB.dart';

class MongoAD {
  static var db, collection;
  static connect() async {
    db = await Db.create("mongodb+srv://muddasir:12383510@xrealestate.mocmbji.mongodb.net/xRealEstate?retryWrites=true&w=majority&appName=xRealEstate");
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print("STATUS : $status");
    collection = db.collection('ADs');
  }
  static Future<bool> updateAd(var data) async{
    final query = where.eq('Id', data["Id"]);
    try{
      final update;
      if(data['Property']=="House"){
        update = ModifierBuilder()
            .set('State', data['State'])
            .set('Price Unit', data['Price Unit'])
            .set('City', data['City'])
            .set('Location', data['Location'])
            .set('Area', data['Area'])
            .set('Area Type', data['Area Type'])
            .set('No. of bedrooms', data['No. of bedrooms'])
            .set('No. of washrooms', data['No. of washrooms'])
            .set('No. of floors', data['No. of floors'])
            .set('Furnished', data['Furnished'])
            .set('Description', data['Description']);
      }
      else{
        update = ModifierBuilder()
            .set('State', data['State'])
            .set('Price Unit', data['Price Unit'])
            .set('City', data['City'])
            .set('Location', data['Location'])
            .set('Area', data['Area'])
            .set('Area Type', data['Area Type'])
            .set('Plot Type', data['Plot Type'])
            .set('Description', data['Description']);
      }
      await collection.update(query, update);
      return true;
    }
    catch(e){
      return false;
    }
  }
  static Future<bool> uploadData(var data) async {
   // connect();
    try {
      var result = await collection.insertOne(data);
      //db.close();
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
  static Future<int> getID() async {
    //connect();
    int id= await collection.count();
   // db.close();
    return id;
  }
  static Future<dynamic> getAds(var c) async {
    print("Cnic : "+c.toString());
    var query = where.eq('Owner CNIC', c);
    try {
      // Assuming collection is correctly initialized
      var result = await collection.find(query).toList();
      print("Fetched Data : $result");
      if (result.isEmpty) {
        print("No matching documents found.");
        return null;
      } else {
        return result;
      }
    } catch (e) {
      print("Error fetching ads: $e");
      return null;
    }
  }
  static Future<bool> deleteAd(var id,var cnic)async{
    try{
      await collection.deleteMany({'Id': id});
      var e=await MongoDB.removePostId(cnic,id);
      return e;
    }
    catch(e){
      return false;
    }

  }

  static Future<void> deletedAccountAds(var cnic)async {
    await collection.deleteMany({'Owner CNIC': cnic});
  }
  static Future<void> removeUserLikedPost(var cnic) async{
    var result = await collection.find({ "Liked By": cnic }).toList();

    for(int i=0;i<result.length;i++){
      result[i]["Liked By"].remove(cnic);

    }
    for(int i=0;i<result.length;i++){
      final update = ModifierBuilder()
          .set('Liked By', result[i]['Liked By']);

      await collection.update( where.id(result[i]['_id']), update);

    }
  }

  static Future<List<Map<String, dynamic>>> fetchSearchAds(var data) async {
    var query;
    if (data['City'].isEmpty && data['minPrice'] != 0 && data['maxPrice'] != 0) {
      query = where
          .gte('Price', data['minPrice'])
          .lte('Price', data['maxPrice'])
          .gte('Area', data['minArea'])
          .lte('Area', data['maxArea'])
          .eq('State', data['State'])
          .eq('Property', data['Property']);
      print("First query run");
    } else if (data['City'].isNotEmpty && data['minPrice'] == 0 && data['maxPrice'] == 0) {
      query = where
          .gte('Area', data['minArea'])
          .lte('Area', data['maxArea'])
          .eq('State', data['State'])
          .eq('Property', data['Property'])
          .eq('City', data['City']);
      print("Second query run");
    } else {
      query = where
          .gte('Area', data['minArea'])
          .lte('Area', data['maxArea'])
          .eq('State', data['State'])
          .eq('Property', data['Property']);
      print("Third query run");
    }

    try {
      var results = await collection.find(query).toList();
      return results;
    } catch (e) {
      print("Error occurred while fetching Ads : " + e.toString());
      return [];
    }
  }

  static Future<void> addLikedPost(var id , var cnic) async{
    var query = where.eq('Id', id);
    var result = await collection.findOne(query);
    result['Liked By'].add(cnic);

    final update = ModifierBuilder()
        .set('Liked By', result['Liked By']);

    await collection.update(query, update);
  }

  static Future<void> removeLikedPost(var id , var cnic) async{
    var query = where.eq('Id', id);
    var result = await collection.findOne(query);
    result['Liked By'].remove(cnic);

    final update = ModifierBuilder()
        .set('Liked By', result['Liked By']);

    await collection.update(query, update);
  }

  static Future<dynamic> fetchFavAds(var arrIDS) async{
    var query = where.oneFrom('Id', arrIDS);
    var results = await collection.find(query).toList();
    return results;
  }
}
