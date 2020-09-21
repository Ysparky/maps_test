part of 'search_bloc.dart';

@immutable
class SearchState {
  final List<SearchResult> searchHistory;

  SearchState({
    List<SearchResult> searchHistory,
  }) : this.searchHistory = (searchHistory == null) ? [] : searchHistory;

  SearchState copyWith({
    List<SearchResult> seachHistory,
  }) =>
      SearchState(
        searchHistory: searchHistory ?? this.searchHistory,
      );
}
