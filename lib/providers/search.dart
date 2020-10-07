import 'package:flutter/material.dart';

enum SearchState { Idle, Open, Busy }

class Search with ChangeNotifier {
  SearchState _state = SearchState.Idle;

  Set<String> queryTags = Set();

  void toggleSearch() {
    _state = _state == SearchState.Idle ? SearchState.Open : SearchState.Idle;
    notifyListeners();
  }

  void tagSelected(String tag) {
    if (queryTags.contains(tag)) {
      queryTags.remove(tag);
    } else {
      queryTags.add(tag);
    }
    notifyListeners();
  }

  SearchState get state => _state;
}
