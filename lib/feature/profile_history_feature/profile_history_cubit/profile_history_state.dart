part of 'profile_history_cubit.dart';

@immutable
abstract class ProfileHistoryState {}

class ProfileHistoryInitial extends ProfileHistoryState {}
class ProfileHistoryLoading extends ProfileHistoryState {}
class ProfileHistorySuccess extends ProfileHistoryState {}
class ProfileHistoryError extends ProfileHistoryState {}
