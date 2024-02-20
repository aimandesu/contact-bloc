part of 'update_profile_cubit.dart';

sealed class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateProfileLoad extends UpdateProfileState {
  final bool isUpdateProfile;
  const UpdateProfileLoad({required this.isUpdateProfile});

  @override
  List<Object> get props => [isUpdateProfile];
}
