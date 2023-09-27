class HistoryModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? code;

  HistoryModel({this.message, this.data, this.status, this.code});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'];
  }

}

class Data {
  int? id;
  Doctor? doctor;
  Patient? patient;
  String? appointmentTime;
  String? appointmentEndTime;
  String? status;
  String? notes;
  int? appointmentPrice;

  Data(
      {this.id,
        this.doctor,
        this.patient,
        this.appointmentTime,
        this.appointmentEndTime,
        this.status,
        this.notes,
        this.appointmentPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    appointmentTime = json['appointment_time'];
    appointmentEndTime = json['appointment_end_time'];
    status = json['status'];
    notes = json['notes'];
    appointmentPrice = json['appointment_price'];
  }

}

class Doctor {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? gender;
  String? address;
  String? description;
  String? degree;
  Specialization? specialization;
  City? city;
  int? appointPrice;
  String? startTime;
  String? endTime;

  Doctor(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.gender,
        this.address,
        this.description,
        this.degree,
        this.specialization,
        this.city,
        this.appointPrice,
        this.startTime,
        this.endTime});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    gender = json['gender'];
    address = json['address'];
    description = json['description'];
    degree = json['degree'];
    specialization = json['specialization'] != null
        ? new Specialization.fromJson(json['specialization'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    appointPrice = json['appoint_price'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

}

class Specialization {
  int? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

class City {
  int? id;
  String? name;
  Specialization? governrate;

  City({this.id, this.name, this.governrate});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    governrate = json['governrate'] != null
        ? new Specialization.fromJson(json['governrate'])
        : null;
  }

}

class Patient {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? gender;

  Patient({this.id, this.name, this.email, this.phone, this.gender});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
  }


}
