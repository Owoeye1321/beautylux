import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/recent_search.dart';
import 'package:logaluxe_users/model/recent.dart';

class RecentSearchNotifier extends StateNotifier<List<RecentSearch>> {
  RecentSearchNotifier() : super(allSearches);
}

var recentSearchProvider = StateNotifierProvider<RecentSearchNotifier, List<RecentSearch>>(
  (ref) => RecentSearchNotifier(),
);
