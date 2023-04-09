import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emerald/component/currentUser.dart';
import 'package:emerald/register/signin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Server {
  // static const _API_PREFIX = 'http://192.168.0.23:3000';
  static final String _baseUrl = dotenv.env['API_SERVER']!;
  final _storage = const FlutterSecureStorage();

  // SignUp API Connection
  Future<String> signUpReq(String id, String name, String password) async {
    Response response;
    Dio dio = Dio();
    Map<String, dynamic> data = {"ID": id, "Name": name, "Pw": password};

    var body = json.encode(data);
    try {
      response = await dio.post("$_baseUrl/signup", data: body);
      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return "400";
      } else {
        return "error";
      }
    }
  }

  // SignIn API Connection
  Future signInReq(String id, String password) async {
    Response response;
    Dio dio = Dio();
    Map<String, dynamic> data = {"ID": id, "Pw": password};

    var body = json.encode(data);
    try {
      response = await dio.post("$_baseUrl/signin", data: body);
      if (response.statusCode == 200) {
        String id = body.split("\"")[3];
        String pw = body.split("\"")[7];
        String atoken = response.data["accessToken"];
        String rtoken = response.data["refreshToken"];
        String exp = response.data["exp"];
        await _storage.write(
            key: "login", value: "$id/$pw/$atoken/$rtoken/$exp");
        // storage.writeSecureData('login', body + atoken);
        return 200;
      } else {
        throw Exception;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return "400";
      } else {
        return "error";
      }
    }
  }

  // 게시판 글 쓰기
  Future<String> writeReq(
      String id, String title, String content, String category) async {
    Response response;
    Dio dio = Dio();
    Map<String, dynamic> data = {
      "ID": id,
      "Title": title,
      "Content": content,
      "Category": category
    };

    var body = json.encode(data);
    try {
      response = await dio.post("$_baseUrl/write", data: body);
      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return "400";
      } else {
        return "error";
      }
    }
  }
}

Server server = Server();
