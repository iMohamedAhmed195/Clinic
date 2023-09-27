abstract class ProfileStates {}

class InitialProfileState extends ProfileStates {}

class LoadingProfileState extends ProfileStates {}
class SuccessfulProfileState extends ProfileStates {}
class FailedProfileState extends ProfileStates {}

class ChangeCheckboxState extends ProfileStates {}
class ChangeRadioState extends ProfileStates {}

class GetAllAppointmentsLoadingState extends ProfileStates {}
class GetAllAppointmentsSuccessState extends ProfileStates {}
class GetAllAppointmentsErrorState extends ProfileStates {}
