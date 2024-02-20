part of 'pageview_cubit.dart';

sealed class PageviewState extends Equatable {
  const PageviewState();

  @override
  List<Object> get props => [];
}

final class PageviewLoader extends PageviewState {
  final int index;
  final bool isSearch;
  const PageviewLoader({required this.index, required this.isSearch,});

  @override
  List<Object> get props => [index, isSearch];
}


