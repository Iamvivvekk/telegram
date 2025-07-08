import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/common/widgets/search_suggestions.dart';
import 'package:telegram/core/configurations/colors.dart';



class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: const Icon(
        Icons.arrow_back_outlined,
        size: 20,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SearchSuggestion();
  }

  @override


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.background),
      scaffoldBackgroundColor: AppColor.background,
    );
  }
  
}
