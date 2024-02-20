part of 'appstate_bloc.dart';

sealed class AppstateState extends Equatable {
  const AppstateState();

  @override
  List<Object> get props => [];
}

final class UserLoadingState extends AppstateState {
  @override
  List<Object> get props => [];
}

final class UserLoadedState extends AppstateState {
  const UserLoadedState(this.users);
  final List<UserModel> users;

  @override
  List<Object> get props => [users];
}

final class UserErrorState extends AppstateState {
  final String error;
  const UserErrorState(this.error);

  @override
  List<Object> get props => [error];
}

final class UserSuccessfullyInitialised extends AppstateState {
  @override
  List<Object> get props => [];
}

