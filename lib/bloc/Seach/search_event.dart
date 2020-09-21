part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnAddSearchHistory extends SearchEvent {
  final SearchResult searchResult;

  OnAddSearchHistory(this.searchResult);
}
