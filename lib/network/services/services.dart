import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/batman.dart';
import '../../model/star_war.dart';

String endPoint1 = "batman";
String endPoint2 = "Star Wars";
String firstUrl =
    "https://fake-movie-database-api.herokuapp.com/api?s=$endPoint1";
String secondUrl =
    "https://fake-movie-database-api.herokuapp.com/api?s=$endPoint2";

abstract class NetworkServices {
  Future<BatmanModel> getBatman();

  Future<StarWarsModel> getStarWars();
}

class NetworkServicesImplement implements NetworkServices {
  NetworkServicesImplement._internalInstance();

  static get instance => NetworkServicesImplement._internalInstance();

  factory NetworkServicesImplement() => instance;

  @override
  Future<BatmanModel> getBatman() async {
    Uri url = Uri.parse(firstUrl);
    var res = await http.get(url);
    var data = jsonDecode(res.body);
    BatmanModel batmanModel = BatmanModel.fromJson(data);
    return batmanModel;
  }

  @override
  Future<StarWarsModel> getStarWars() async {
    Uri url = Uri.parse(secondUrl);
    var res = await http.get(url);

    var data = jsonDecode(res.body);
    StarWarsModel starWarsModel = StarWarsModel.fromJson(data);
    return starWarsModel;
  }
}
