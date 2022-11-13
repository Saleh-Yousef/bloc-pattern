import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../constants/db_constans.dart';
import '../database/query_options.dart';
import '../models/login_model.dart';
import '../utils/mixin.dart';
import 'dart:convert';

class LoginService with Service {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  Future<bool> login({required String userName, required String password}) async {
    Map<String, dynamic> decodedMap = {};
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(ApiConstants.loginAPI));
    request.bodyFields = {'args': '{"USERNAME":"$userName","PASSWORD":"$password"}'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseMap = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      decodedMap = json.decode(responseMap.body);
      var jsons = json.encode(responseMap.body);
      database!.insertMany(QueryOptions(
        tableName: DatabaseConstants.loginTableName,
        data: [LoginModel(jsonlogin: jsons)],
      ));
      print(decodedMap['MESSAGE']);
    } else {
      print(response.reasonPhrase);
    }
    // to test the DB uncomment this :
    // String jsonFromDB = await getLoginJSONFromDB();
    // print('------- jsonFromDB $jsonFromDB');

    return decodedMap['MESSAGE'] == 'LOGIN.SUCCESS';
  }

  Future<String> getLoginJSONFromDB() async {
    final loginJSON = await database!.select<LoginModel>(QueryOptions<LoginModel>(
      tableName: DatabaseConstants.loginTableName,
      toModel: (source) {
        LoginModel item = LoginModel.fromDatabaseRow(source);
        return item;
      },
    ));
    return loginJSON.first!.jsonlogin!;
  }
}
