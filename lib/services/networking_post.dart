import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:truth_or_dare/services/game.dart';
import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:truth_or_dare/services/game_package.dart';

// Make network request.
// http().get returns a Future that contains Response.
/*
Future<Game> fetchGame() async {
  final response = await http.get('http://10.0.2.2:8080/demo/premiumpackages');

  if (response.statusCode == 200) {
    // Convert the response body into a JSON Map
    // Convert the JSON Map into a Game
    return Game.fromJason(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
*/

const String em_api = "http://10.0.2.2:8080/"; // Emulator
const String api = "http://37.152.178.33:8080/"; // Server

// For Logging HTTP
class LogginInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

// Headers needed in my HTTP Request
const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

// Like Game by User
Future<bool> gameLike(int id, {Map body}) async {
  return HttpWithInterceptor.build(interceptors: [LogginInterceptor()])
      .post(api + "demo/likegame/" + id.toString(),
          headers: header, body: json.encode(body))
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data \n ${response.body}");
    }
//    return Game.fromJson(json.decode(response.body));
    return true;
  });
}

// Like Game by User
Future<bool> gameDislike(int id, {Map body}) async {
  return HttpWithInterceptor.build(interceptors: [LogginInterceptor()])
      .post(api + "demo/dislikegame/" + id.toString(),
          headers: header, body: json.encode(body))
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data \n ${response.body}");
    }
    return true; /*Game.fromJson(json.decode(response.body));*/
  });
}

// Post Game by User
Future<bool> postGame({Map body}) async {
  return HttpWithInterceptor.build(interceptors: [LogginInterceptor()])
      .post(api + "demo/addusergame", headers: header, body: json.encode(body))
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data \n ${response.body}");
    }
    return true; /*Game.fromJson(json.decode(response.body));*/
  });
}

/*Future<http.Response> */ /*
 postLike(int id) async {
//  final response = await http.post(api + 'demo/likegame');

//  Map<String, String> datas = {
//    'id' = id,
//    'like' = like,
//    'dislike' = 0,
//  };

//  String json = '{"id":"2","like_count":"1","dislike_count":"0"}';

//  var map = new Map<String, dynamic>();
//  map['id'] = '2';
//  map['like_count'] = '1';
//  map['username'] = 'example@mail.com.us';
//  map['password'] = 'ABC1234563Af88jesKxPLVirJRW8wXvj3D';

  */
/*var response */ /*
 http.Response response =
      await http.post(api + 'demo/likegame', body: id) ;

  return response;
}
//  if (response.statusCode == 200) {
//    return allPGPFromJson(response.body);
//  } else {
//    throw Exception('Failed to load data');
//  }
//}

//Future<List<Game>> fetchGames() async {
//  final response = await http.get(api + 'demo/freepackages');
//
//  if (response.statusCode == 200) {
//    return gameByPackage(response.body);
//  } else {
//    throw Exception('Failed to load data');
//  }
//}
*/
