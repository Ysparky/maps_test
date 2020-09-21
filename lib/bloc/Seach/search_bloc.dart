import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:maps_test/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnAddSearchHistory) {
      final exists = state.searchHistory
          .where(
              (element) => element.targetName == event.searchResult.targetName)
          .length;

      if (exists == 0) {
        state.searchHistory.add(event.searchResult);
        yield state.copyWith(seachHistory: state.searchHistory);
      }
    }
  }
}
