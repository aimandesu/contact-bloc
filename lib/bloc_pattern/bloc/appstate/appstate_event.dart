part of 'appstate_bloc.dart';

sealed class AppstateEvent extends Equatable {
  const AppstateEvent();

  @override
  List<Object> get props => [];
}

final class LoadUserEvent extends AppstateEvent {
  @override
  List<Object> get props => [];
}

final class IsUserLoadedEvent extends AppstateEvent {
  @override
  List<Object> get props => [];
}

final class LoadUserSuccess extends AppstateEvent {
  @override
  List<Object> get props => [];
}

