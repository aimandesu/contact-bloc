import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/db.dart';
import '../../../model/user_model.dart';

part 'searches_feature_state.dart';

class SearchesFeatureCubit extends Cubit<SearchesFeatureState> {
  final Db db;
  SearchesFeatureCubit({required this.db}) : super(SearchesFeatureInitial(keyword: ""));

  void searchingContact(String keyword) async {
    List<UserModel> usersToFind = await db.searchContact(keyword);
    if (usersToFind.isNotEmpty) {
      emit(ContactFound(users: usersToFind));
    } else if (usersToFind.isEmpty) {
      emit(ContactNotFound());
    }
  }

}
