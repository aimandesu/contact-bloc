import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pageview_state.dart';

class PageViewCubit extends Cubit<PageviewState> {
  PageViewCubit() : super(const PageviewLoader(index: 0, isSearch: false));

  void changePage(int newIndex, bool update) => emit(
        PageviewLoader(
          index: newIndex,
          isSearch: update,
        ),
      );
}
