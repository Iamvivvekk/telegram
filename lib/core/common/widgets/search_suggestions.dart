import 'package:flutter/material.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/size.dart';

class SearchSuggestion extends StatefulWidget {
  const SearchSuggestion({super.key});

  @override
  State<SearchSuggestion> createState() => _SearchSuggestionState();
}

class _SearchSuggestionState extends State<SearchSuggestion> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: SizedBox(
        height: ScreenUtil.getSize(context).height,
        child: Column(
          children: [
            const SizedBox(
              child: TabBar(
                isScrollable: true,
                labelColor: AppColor.blueSecondary,
                unselectedLabelColor: AppColor.greyText,
                indicatorColor: AppColor.blueSecondary,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: AppColor.black,
                tabAlignment: TabAlignment.start,
                dividerHeight: 0.5,
                tabs: [
                  Tab(text: "Chats"),
                  Tab(text: "Channels"),
                  Tab(text: "Apps"),
                  Tab(text: "Media"),
                  Tab(text: "Downloads"),
                  Tab(text: "Links"),
                  Tab(text: "Files"),
                  Tab(text: "Music"),
                  Tab(text: "Voice"),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
