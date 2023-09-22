part of 'singup_cubit.dart';


abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignUpState {}
class SignupLoading extends SignUpState {}
class SignupSuccess extends SignUpState {
  final RegisterModel registerModel ;

 const SignupSuccess(this.registerModel);
}

class SignupError extends SignUpState {
  final String errMessage;

 const  SignupError(this.errMessage);
}
