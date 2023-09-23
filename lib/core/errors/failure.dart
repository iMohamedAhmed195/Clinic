import 'package:dio/dio.dart';

abstract class Failure{
  final String errorMessage ;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure{
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException){
    switch(dioException.type){
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connection time out');
      case DioExceptionType.sendTimeout:
        return ServerFailure('send time out');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive time out');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode,dioException.response!.data  );
      case DioExceptionType.cancel:
      return ServerFailure('cancel time out');
      case DioExceptionType.connectionError:
        return ServerFailure('connectionError time out');
      case DioExceptionType.unknown:
        if(dioException.message!.contains('SocketException')){
          return ServerFailure('no internet Connection');
        }
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate time out');
      default : return ServerFailure('opps there was an error , please try again');
    }
    return ServerFailure('Unexpected Error , Please try later');

  }

  factory ServerFailure.fromResponse(int? statusCode , dynamic response){
    //hena 7ot el error 3la 7sb el etfak m3 bta3 el back end hyrg3 ehh
    if(statusCode ==  422){

      return ServerFailure(response);

    }else if(statusCode == 404){
      return ServerFailure('your request not found , please try again later');
    }else if(statusCode == 500){
      return ServerFailure('internal server error , please try later ');
    }else{
      return ServerFailure('opps there was an error , please try again');
    }

  }
}