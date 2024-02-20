part of 'contact_bloc.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

final class ContactDatabaseInitial extends ContactState {}

final class ContactDatabaseLoaded extends ContactState {
  final List<UserModel> users;

  const ContactDatabaseLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class ContactRefreshed extends ContactState {
  final UserModel user;

  const ContactRefreshed({required this.user});

  @override
  List<Object> get props => [user];
}


// final class ContactNotFound extends ContactState {
//
//   @override
//   List<Object> get props => [];
// }
//
// final class ContactFound extends ContactState {
//   final List<UserModel> users;
//
//   const ContactFound({required this.users});
//
//   @override
//   List<Object> get props => [users];
// }
