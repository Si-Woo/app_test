import 'dart:convert';
import 'dart:io';

import 'package:emerald/api/getPostData.dart';
import 'package:emerald/api/userInfo.dart';
import 'package:emerald/component/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = dotenv.env['API_SERVER']!;
  static const _storage = FlutterSecureStorage();

  // 게시물 데이터 get
  static Future<List<GetPostData>> getPostData() async {
    dynamic userInfo = '';
    String id, pw, atoken, rtoken, exp = '';
    userInfo = await _storage.read(key: "login");
    id = userInfo.split("/")[0];
    pw = userInfo.split(".")[1];
    atoken = userInfo.split("/")[2];
    rtoken = userInfo.split("/")[3];
    exp = userInfo.split("/")[4];
    List<GetPostData> postInstances = [];
    final url = Uri.parse('$_baseUrl/board');
    final response = await http.get(url, headers: {"access-token": atoken});
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> posts = map["data"];
      for (var post in posts) {
        postInstances.add(GetPostData.fromJson(post));
      }
      postInstances = List.from(postInstances.reversed); // 데이터 역순
      return postInstances;
    } else if (response.statusCode == 401) {
      final url = Uri.parse('$_baseUrl/re-token');
      final response = await http.post(url,
          headers: {"access-token": atoken, "refresh-token": rtoken});
      await _storage.deleteAll();
      atoken = response.body.split("\"")[3];
      await _storage.write(key: "login", value: "$id/$pw/$atoken/$rtoken/$exp");
      if (response.statusCode == 200) {
        List<GetPostData> postInstances = [];
        final url = Uri.parse('$_baseUrl/board');
        final response = await http.get(url, headers: {"access-token": atoken});
        if (response.statusCode == 200) {
          Map<String, dynamic> map = json.decode(response.body);
          List<dynamic> posts = map["data"];
          for (var post in posts) {
            postInstances.add(GetPostData.fromJson(post));
          }
          postInstances = List.from(postInstances.reversed); // 데이터 역순
          return postInstances;
        }
      }
    }
    throw Error();
  }

  // SecondPage 게시물 category별 데이터 List
  static Future<List<GetPostData>> getCategoryData(String category) async {
    dynamic userInfo = '';
    String id, pw, atoken, rtoken, exp = '';
    userInfo = await _storage.read(key: "login");
    id = userInfo.split("/")[0];
    pw = userInfo.split(".")[1];
    atoken = userInfo.split("/")[2];
    rtoken = userInfo.split("/")[3];
    exp = userInfo.split("/")[4];
    List<GetPostData> postInstances = [];
    final url = Uri.parse('$_baseUrl/board/list?category=$category');
    final response = await http.get(url, headers: {"access-token": atoken});
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> posts = map["data"]["Value"];
      for (var post in posts) {
        postInstances.add(GetPostData.fromJson(post));
      }
      postInstances = List.from(postInstances.reversed); // 데이터 역순
      return postInstances;
    } else if (response.statusCode == 401) {
      final url = Uri.parse('$_baseUrl/re-token');
      final response = await http.post(url,
          headers: {"access-token": atoken, "refresh-token": rtoken});
      await _storage.deleteAll();
      atoken = response.body.split("\"")[3];
      await _storage.write(key: "login", value: "$id/$pw/$atoken/$rtoken/$exp");
      if (response.statusCode == 200) {
        List<GetPostData> postInstances = [];
        final url = Uri.parse('$_baseUrl/board/list?category=$category');
        final response = await http.get(url, headers: {"access-token": atoken});
        if (response.statusCode == 200) {
          Map<String, dynamic> map = json.decode(response.body);
          List<dynamic> posts = map["data"]["Value"];
          for (var post in posts) {
            postInstances.add(GetPostData.fromJson(post));
          }
          postInstances = List.from(postInstances.reversed); // 데이터 역순
          return postInstances;
        }
      }
    }
    throw Error();
  }

  // ThirdPage 접속한 유저 List
  static Future<List<UserInfo>> getConnectUser() async {
    dynamic userInfo = '';
    String id, pw, atoken, rtoken, exp = '';
    userInfo = await _storage.read(key: "login");
    id = userInfo.split("/")[0];
    pw = userInfo.split(".")[1];
    atoken = userInfo.split("/")[2];
    rtoken = userInfo.split("/")[3];
    exp = userInfo.split("/")[4];
    List<UserInfo> postConnectUsers = [];
    final url = Uri.parse('$_baseUrl/userlist');
    final response = await http.get(url, headers: {"access-token": atoken});
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> users = map["data"];
      for (var user in users) {
        postConnectUsers.add(UserInfo.fromJson(user));
      }
      // postConnectUsers = List.from(postConnectUsers.reversed);
      return postConnectUsers;
    } else if (response.statusCode == 401) {
      final url = Uri.parse('$_baseUrl/re-token');
      final response = await http.post(url,
          headers: {"access-token": atoken, "refresh-token": rtoken});
      await _storage.deleteAll();
      atoken = response.body.split("\"")[3];
      await _storage.write(key: "login", value: "$id/$pw/$atoken/$rtoken/$exp");
      if (response.statusCode == 200) {
        List<UserInfo> postConnectUsers = [];
        final url = Uri.parse('$_baseUrl/userlist');
        final response = await http.get(url, headers: {"access-token": atoken});
        if (response.statusCode == 200) {
          Map<String, dynamic> map = json.decode(response.body);
          List<dynamic> users = map["data"];
          for (var user in users) {
            postConnectUsers.add(UserInfo.fromJson(user));
          }
          // postConnectUsers = List.from(postConnectUsers.reversed);
          return postConnectUsers;
        }
      }
    }
    throw Error();
  }

  // Profile - 로그인한 유저
  static Future<List<UserInfo>> getCurrentUser(String id) async {
    dynamic userInfo = '';
    String id, pw, atoken, rtoken, exp = '';
    userInfo = await _storage.read(key: "login");
    id = userInfo.split("/")[0];
    pw = userInfo.split(".")[1];
    atoken = userInfo.split("/")[2];
    rtoken = userInfo.split("/")[3];
    exp = userInfo.split("/")[4];
    List<UserInfo> userInstances = [];
    final url = Uri.parse('$_baseUrl/currentuser?user_id=$id');
    final response = await http.get(url, headers: {"access-token": atoken});
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> posts = map["data"]["Value"];
      // print("user 정보");
      for (var post in posts) {
        userInstances.add(UserInfo.fromJson(post));
      }
      return userInstances;
    } else if (response.statusCode == 401) {
      final url = Uri.parse('$_baseUrl/re-token');
      final response = await http.post(url,
          headers: {"access-token": atoken, "refresh-token": rtoken});
      await _storage.deleteAll();
      atoken = response.body.split("\"")[3];
      await _storage.write(key: "login", value: "$id/$pw/$atoken/$rtoken/$exp");
      if (response.statusCode == 200) {
        List<UserInfo> userInstances = [];
        final url = Uri.parse('$_baseUrl/currentuser?user_id=$id');
        final response = await http.get(url, headers: {"access-token": atoken});
        if (response.statusCode == 200) {
          Map<String, dynamic> map = json.decode(response.body);
          List<dynamic> posts = map["data"]["Value"];
          // print("user 정보");
          for (var post in posts) {
            userInstances.add(UserInfo.fromJson(post));
          }
          return userInstances;
        }
      }
    }
    throw Error();
  }
}
