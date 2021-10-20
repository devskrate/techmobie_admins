import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const admins = const {
  "satyalovesandy": "manakuendukuivanni",
  "ironmannikhil": "chalalitemanaku",
  "puneethkanna": "edotestchestunna",
  "vasavi": "simpleeekada",
  "test@gmail.com": "test",
  "test": "test"
};
const adminsGitList = const {
  "satyalovesandy": "1",
  "ironmannikhil": "2",
  "puneethkanna": "3",
  "vasavi": "4",
  "test": "5"
};
const adminsUsername = const {
  "satyalovesandy": "satya",
  "ironmannikhil": "nikhil",
  "puneethkanna": "puneeth",
  "vasavi": "vasavi",
  "test": "test"
};

checkAccess() async {
  try {
    final storage = new FlutterSecureStorage();
    var username = await storage.read(key: "username");
    var password = await storage.read(key: "password");
    print("In AUTH");
    var aList = await fetchAdmins(http.Client());
    //if(aList[adminsGitList.access)
    var valueindex = adminsGitList[username];
    int valueIndex = int.parse(valueindex!);
    //print(valueIndex);

    if ((aList[valueIndex - 1].access) == "true") {
      //server.post();
      print("Sending TRUE");
      return "true";
    }
    print("Sneding FLASE");
    return "false";
  } catch (error) {
    return ("Something Went wrong!, contact admins for bug fix. $error");
  }
}

Future<List<AdminsList>> fetchAdmins(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://devskrate.github.io/app_admin_permission/admins.json'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseAdmins, response.body);
}

// A function that converts a response body into a List<Photo>.
List<AdminsList> parseAdmins(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<AdminsList>((json) => AdminsList.fromJson(json)).toList();
}

class AdminsList {
  final String admin;
  final String access;
  final String name;

  const AdminsList({
    required this.admin,
    required this.access,
    required this.name,
  });

  factory AdminsList.fromJson(Map<String, dynamic> json) {
    return AdminsList(
      admin: json['admin'] as String,
      access: json['access'] as String,
      name: json['name'] as String,
    );
  }
}
