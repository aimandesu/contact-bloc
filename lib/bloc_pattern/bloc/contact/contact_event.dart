part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

final class LoadContactDatabase extends ContactEvent {
  @override
  List<Object> get props => [];
}

final class RenderContact extends ContactEvent {
  @override
  List<Object> get props => [];
}

final class DeleteContact extends ContactEvent {
  final int id;

  const DeleteContact({required this.id});

  @override
  List<Object> get props => [id];
}

final class UpdateContact extends ContactEvent {
  final UserModel user;

  const UpdateContact({required this.user});

  @override
  List<Object> get props => [user];
}

// final class SearchContact extends ContactEvent {
//   final String keyword;
//
//   const SearchContact({required this.keyword});
//
//   @override
//   List<Object> get props => [keyword];
// }
