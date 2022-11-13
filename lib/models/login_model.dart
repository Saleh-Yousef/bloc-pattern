import '../utils/mixin.dart';

class LoginModel extends Model {
  String? jsonlogin;

  LoginModel({
    this.jsonlogin,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    jsonlogin = json['jsonlogin'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonlogin'] = this.jsonlogin;

    return data;
  }

  Map<String, dynamic> toDatabaseRow() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonlogin'] = this.jsonlogin;

    return data;
  }

  LoginModel.fromDatabaseRow(Map<String, dynamic> rowData) {
    this.jsonlogin = rowData['jsonlogin'];
  }
}
