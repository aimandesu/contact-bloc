import 'package:bloc/bloc.dart';
import 'package:contact_bloc/database/db.dart';
import 'package:contact_bloc/model/user_model.dart';
import 'package:contact_bloc/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'appstate_event.dart';

part 'appstate_state.dart';

class AppStateBloc extends Bloc<AppstateEvent, AppstateState> {
  final UserRepository userRepository;
  final Db db;

  AppStateBloc({required this.userRepository, required this.db})
      : super(UserLoadingState()) {
    on<LoadUserEvent>(_onLoadUser);
    on<IsUserLoadedEvent>(_onLoadedDb);
    on<LoadUserSuccess>(_onLoadUserSuccess);
  }

  void _onLoadUser(
    LoadUserEvent event,
    Emitter<AppstateState> emit,
  ) async {
    List<UserModel> users = [];
    try {
      List<UserModel> contact = await db.contactList();

      if (contact.isEmpty) {
        users = await userRepository.getUsers();
      } else {
        users = await userRepository.getUsers();
        users = users
            .where((user) =>
                !contact.any((contactUser) => contactUser.id == user.id))
            .toList();
        await db.initializeContact(users);
      }

      emit(UserLoadedState(users));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  void _onLoadedDb(
    IsUserLoadedEvent event,
    Emitter<AppstateState> emit,
  ) async {
    List<UserModel> contact = await db.contactList();

    if (contact.isNotEmpty) {
      emit(UserSuccessfullyInitialised());
    }
  }

  void _onLoadUserSuccess(
    LoadUserSuccess event,
    Emitter<AppstateState> emit,
  ) {
    emit(UserSuccessfullyInitialised());
  }
}
