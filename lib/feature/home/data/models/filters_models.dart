class CityModel {
  int id;
  String name;
  GovernorateModel governorate;

  CityModel({
    required this.id,
    required this.name,
    required this.governorate,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      governorate: GovernorateModel.fromJson(json['governrate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'governrate': governorate.toJson(),
    };
  }
}

class GovernorateModel {
  int id;
  String name;

  GovernorateModel({
    required this.id,
    required this.name,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class SpecializationModel {
  int id;
  String name;
  List<DoctorModel> doctors;

  SpecializationModel({
    required this.id,
    required this.name,
    required this.doctors,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      id: json['id'],
      name: json['name'],
      doctors: List<DoctorModel>.from(json['doctors'].map((x) => DoctorModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'doctors': List<dynamic>.from(doctors.map((x) => x.toJson())),
    };
  }
}

class DoctorModel {
  int id;
  String name;
  String email;
  String phone;
  String photo;
  String gender;
  String address;
  String description;
  String degree;
  SpecializationSemiModel specialization;
  CityModel city;
  int appointPrice;
  String startTime;
  String endTime;

  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.degree,
    required this.specialization,
    required this.city,
    required this.appointPrice,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      gender: json['gender'],
      address: json['address'],
      description: json['description'],
      degree: json['degree'],
      specialization: SpecializationSemiModel.fromJson(json['specialization']),
      city: CityModel.fromJson(json['city']),
      appointPrice: json['appoint_price'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'gender': gender,
      'address': address,
      'description': description,
      'degree': degree,
      'specialization': specialization.toJson(),
      'city': city.toJson(),
      'appoint_price': appointPrice,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}

class SpecializationSemiModel {
  int id;
  String name;

  SpecializationSemiModel({
    required this.id,
    required this.name,
  });

  factory SpecializationSemiModel.fromJson(Map<String, dynamic> json) {
    return SpecializationSemiModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
