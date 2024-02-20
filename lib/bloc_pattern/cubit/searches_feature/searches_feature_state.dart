part of 'searches_feature_cubit.dart';

abstract class SearchesFeatureState extends Equatable {
  const SearchesFeatureState();
}

class SearchesFeatureInitial extends SearchesFeatureState {
  String keyword;

  SearchesFeatureInitial({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

final class ContactNotFound extends SearchesFeatureState {

  @override
  List<Object> get props => [];
}

final class ContactFound extends SearchesFeatureState {
  final List<UserModel> users;

  const ContactFound({required this.users});

  @override
  List<Object> get props => [users];
}
