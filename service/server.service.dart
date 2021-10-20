//import 'dart:convert';

//import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:techmobie_admins/service/auth.service.dart' as auth;
import 'package:intl/intl.dart';

const db = "";

getUsername() async {
  final storage = new FlutterSecureStorage();
  var username = await storage.read(key: "username");
  return username;
}

start() async {
  final db = await Db.create(
      'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('news');
  print(await coll.find().toList());
}

main() async {
  final db = await Db.create(
      'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('news');

  print(await coll.find().toList());
  //return (coll.find().toList());
  return db;
}

articlePost(
    imageUrl, title, shortDescription, description, keywords, sourceUrl) async {
  //var data = JsonEncoder.withIndent('').convert(state.toJson());
  print("IN POST");
  print(title);
  //print(JsonEncoder.withIndent('').convert(state.toJson()));
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var time = new DateFormat('hh:mm:ss');
  String formattedDate = formatter.format(now);
  String timeFormat = time.format(now);
  print(formattedDate); // 2016-01-25
  print(timeFormat);
  var access = await auth.checkAccess();
  print("Got access");
  getArticles();
  print(access);
  if (access == "true") {
    var username = await getUsername();
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    await coll.insertOne({
      'imageUrl': imageUrl,
      'title': title,
      'shortDescription': shortDescription,
      'description': description,
      'sourceUrl': sourceUrl,
      'keywords': keywords,
      'writer': username,
      'date': formatter.format(now),
      "time": time.format(now),
      "type": "article",
    });
    print("DATA POSTED SUCCESSFULLY");
    return "posted";
  }
  if (access == "false") {
    print("IN ACCESS");
    return "NoAccess";
  } else {
    return "Something Went Wrong!";
  }
}

shortPost_Post(imageUrl, description, sourceUrl, keywords) async {
  //var data = JsonEncoder.withIndent('').convert(state.toJson());
  print("IN POST");
  //print(title);
  //print(JsonEncoder.withIndent('').convert(state.toJson()));
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var time = new DateFormat('hh:mm:ss');
  String formattedDate = formatter.format(now);
  String timeFormat = time.format(now);
  print(formattedDate); // 2016-01-25
  print(timeFormat);
  var access = await auth.checkAccess();
  print("Got access");
  getArticles();
  print(access);
  if (access == "true") {
    var username = await getUsername();
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    await coll.insertOne({
      'imageUrl': imageUrl,
      'description': description,
      'sourceUrl': sourceUrl,
      'keywords': keywords,
      'writer': username,
      'date': formatter.format(now),
      "time": time.format(now),
      "type": "short_post",
      //'date':
    });

    print("DATA POSTED SUCCESSFULLY");
    return "posted";
  }
  if (access == "false") {
    print("IN ACCESS");
    return "NoAccess";
  } else {
    return "Something Went Wrong!";
  }
}

getArticles() async {
  var access = await auth.checkAccess();
  print("Got access");
  print(access);
  if (true) {
    var username = await getUsername();
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    final val = await coll
        .find(where
            .eq("writer", username)
            .eq("type", "article")
            .sortBy('date', descending: true)
            .sortBy('time', descending: true))
        .toList();
    print("Printing Articles list");
    print("$val");
    return val;
  }
}

getShortPosts() async {
  print("In SHORT POSTS");
  var access = await auth.checkAccess();
  print("Got access");
  print(access);
  if (true) {
    var username = await getUsername();
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    final val = await coll
        .find(where
            .eq("writer", username)
            .eq("type", "short_post")
            .sortBy('date', descending: true)
            .sortBy('time', descending: true))
        .toList();
    print("Printing Short Post list");
    print("$val");
    return val;
  }
}

getSingleArticle(id) async {
  var access = await auth.checkAccess();
  print("Got access");
  //print(id);
  final ID = ObjectId.fromHexString(id);
  print(ID.toString()); // => 5f52c805df41c9df948e6135
  if (true) {
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    final val = await coll.find(where.eq("_id", ID)).toList();
    print("Printing Articles list");
    print("$val");
    return val;
  }
}

getSingleShortPost(id) async {
  var access = await auth.checkAccess();
  print("Got access");
  //print(id);
  final ID = ObjectId.fromHexString(id);
  print(ID.toString()); // => 5f52c805df41c9df948e6135
  if (true) {
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    final val = await coll.find(where.eq("_id", ID)).toList();
    print("Printing Short Post");
    print("$val");
    return val;
  }
}

articleUpdate(ID, imageUrl, title, shortDescription, description, keywords,
    sourceUrl) async {
  print("IN Article Update");
  print(title);
  //print(JsonEncoder.withIndent('').convert(state.toJson()));
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var time = new DateFormat('hh:mm:ss');
  String formattedDate = formatter.format(now);
  String timeFormat = time.format(now);
  print(formattedDate); // 2016-01-25
  print(timeFormat);
  var access = await auth.checkAccess();
  print("Got access");
  getArticles();
  print(access);
  if (access == "true") {
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    await coll.updateOne({
      "_id": ID
    }, {
      "\$set": {
        "imageUrl": imageUrl,
        "title": title,
        "shortDescription": shortDescription,
        "description": description,
        "sourceUrl": sourceUrl,
        "keywords": keywords,
        "date_updated": formatter.format(now),
        "time_updated": time.format(now)
      }
    });
    print(title);
    print("DATA UPDATED SUCCESSFULLY");
    return "posted";
  }
  if (access == "false") {
    print("IN ACCESS");
    return "NoAccess";
  } else {
    return "Something Went Wrong!";
  }
}

shortPostUpdate(ID, imageUrl, description, sourceUrl, keywords) async {
  print("IN Short Post Update");
  print(imageUrl);
  //print(JsonEncoder.withIndent('').convert(state.toJson()));
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var time = new DateFormat('hh:mm:ss');
  String formattedDate = formatter.format(now);
  String timeFormat = time.format(now);
  //print(formattedDate); // 2016-01-25
  //print(timeFormat);
  var access = await auth.checkAccess();
  print("Got access");
  getArticles();
  print(access);
  if (access == "true") {
    var username = await getUsername();
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    await coll.updateOne({
      "_id": ID
    }, {
      "\$set": {
        'imageUrl': imageUrl,
        'description': description,
        'sourceUrl': sourceUrl,
        'keywords': keywords,
        'writer': username,
        "date_updated": formatter.format(now),
        "time_updated": time.format(now)
      }
    });
    print("DATA UPDATED SUCCESSFULLY");
    return "posted";
  }
  if (access == "false") {
    print("IN ACCESS");
    return "NoAccess";
  } else {
    return "Something Went Wrong!";
  }
}

deleteArticle(ID) async {
  var access = await auth.checkAccess();
  print("Got access");
  //print(id);
  //final ID = ObjectId.fromHexString(id);
  //print(ID.toString()); // => 5f52c805df41c9df948e6135
  if (access == "true") {
    final db = await Db.create(
        'mongodb+srv://pannu:pannu123nekuenduku@news.dqrln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open();
    final coll = await db.collection('news');
    var tt = await coll.deleteOne({"_id": ID});
    //final val = await coll.find(where.eq("_id", ID)).toList();
    var val = getArticles();
    print("Printing Articles list");
    print("$val");
    print("IN DELETION, $tt");
    return "deleted";
  }
}
