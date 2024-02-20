import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(const UpdateProfileLoad(isUpdateProfile: false));

  void editProfile(bool update) =>
      emit(UpdateProfileLoad(isUpdateProfile: update));
}
