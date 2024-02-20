import 'package:bloc/bloc.dart';
import 'package:contact_bloc/database/db.dart';
import 'package:contact_bloc/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final Db db;

  ContactBloc({required this.db}) : super(ContactDatabaseInitial()) {
    on<LoadContactDatabase>(_onLoadDatabase);
    on<RenderContact>(_renderContact);
    on<DeleteContact>(_deleteContact);
    on<UpdateContact>(_updateContact);
    // on<SearchContact>(_searchContact);
  }

  void _onLoadDatabase(
    LoadContactDatabase event,
    Emitter<ContactState> emit,
  ) async {
    final List<UserModel> contact = await db.contactList();

    if (contact.isEmpty) {
      db.initializeDB();
    }
  }

  void _renderContact(
    RenderContact event,
    Emitter<ContactState> emit,
  ) async {
    final List<UserModel> contact = await db.contactList();

    emit(ContactDatabaseLoaded(contact));
  }

  void _deleteContact(
    DeleteContact event,
    Emitter<ContactState> emit,
  ) async {
    final int contactID = event.id;

    await db.deleteContact(contactID);
    final List<UserModel> contact = await db.contactList();
    emit(ContactDatabaseLoaded(contact));
  }

  void _updateContact(
    UpdateContact event,
    Emitter<ContactState> emit,
  ) async {
    final UserModel contact = event.user;

    await db.updateContact(contact);

    emit(ContactRefreshed(user: contact));
  }

  // void _searchContact(
  //   SearchContact event,
  //   Emitter<ContactState> emit,
  // ) async {
  //   print(event.keyword);
  //   List<UserModel> usersToFind = await db.searchContact(event.keyword);
  //
  //   print(usersToFind);
  //
  //   print(usersToFind.isNotEmpty);
  //
  //   if (usersToFind.isNotEmpty) {
  //     emit(ContactFound(users: usersToFind));
  //   } else if (usersToFind.isEmpty) {
  //     emit(ContactNotFound());
  //   }
  // }
}
