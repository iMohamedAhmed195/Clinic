class RegisterModel {
  String? message;
  Data? data;
  bool? status;
  int? code;

  RegisterModel({this.message, this.data, this.status, this.code});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['code'] = code;
    return data;
  }
}

class Data {
  String? token;
  String? username;

  Data({this.token, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['token'] = token;
    data['username'] = username;
    return data;
  }
}