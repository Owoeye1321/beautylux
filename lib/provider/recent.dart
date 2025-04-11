import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/recent_search.dart';
import 'package:logaluxe_users/model/recent.dart';
import 'package:logaluxe_users/model/user.dart';

class RecentSearchModel {
  final List<RecentSearch> search;
  final List<UserModel> providers;
  final bool loadingState;
  const RecentSearchModel({required this.search, required this.providers, required this.loadingState});
}

class RecentSearchNotifier extends StateNotifier<RecentSearchModel> {
  RecentSearchNotifier() : super(RecentSearchModel(search: [], providers: [], loadingState: false));

  List<RecentSearch> addRecentSearches(RecentSearch search) {
    var existingSearch = state.search.where((each) => each.content == search.content).toList();
    if (existingSearch.isNotEmpty)
      return state.search;
    else
      state = RecentSearchModel(
          search: [...state.search, search], providers: state.providers, loadingState: state.loadingState);
    return state.search;
  }

  List<RecentSearch> removeSearch(RecentSearch search) {
    state = RecentSearchModel(
        search: state.search.where((existingSearch) => existingSearch != search).toList(),
        providers: state.providers,
        loadingState: state.loadingState);
    return state.search;
  }

  List<RecentSearch> clearSearchHistory() {
    state = RecentSearchModel(search: [], providers: [], loadingState: state.loadingState);
    return state.search;
  }

  Future<List<UserModel>> searchProvider(String searchQuery, String? category_id) async {
    state = RecentSearchModel(search: state.search, providers: state.providers, loadingState: true);
    try {
      var response = searchQuery != ''
          ? await http
              .get(Uri.parse('${dotenv.env['API_URL']}/customer/search-providers?searchQuery=${searchQuery}'))
          : await http.get(
              Uri.parse('${dotenv.env['API_URL']}/customer/search-providers?&category_id=${category_id}'));
      if (response.statusCode == 200) {
        state = RecentSearchModel(
            search: state.search,
            providers: UserModel.fromJsonList(
              jsonDecode(response.body),
            ),
            loadingState: false);
        if (state.providers.isNotEmpty && searchQuery.length > 2)
          this.addRecentSearches(RecentSearch(content: searchQuery, key: ObjectKey(searchQuery)));
        return state.providers;
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

var recentSearchProvider = StateNotifierProvider<RecentSearchNotifier, RecentSearchModel>(
  (ref) => RecentSearchNotifier(),
);
