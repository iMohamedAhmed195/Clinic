import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
   final String? message;
  final Data? data;
  final bool? status;
  final int? code;

 const RegisterModel({this.message, this.data, this.status, this.code});

factory RegisterModel.fromJson(Map<String , dynamic> json)=>RegisterModel(
  message: json['message'],
  data : json['data'] != null ? Data.fromJson(json['data']) : null,
  status : json['status'],
  code : json['code'],
  );

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      message,
      data,
      status,
      code,
    ];
  }
}

class Data extends Equatable{
  final String? token;
  final String? username;

  const Data({this.token, this.username});


  factory Data.fromJson(Map<String , dynamic > json)=>Data(
      token :json['token'],
      username : json['username'],
  );


  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      token,
      username
  ];
  }
}
