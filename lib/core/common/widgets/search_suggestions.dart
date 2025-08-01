import 'package:flutter/material.dart';
import 'package:telegram/core/common/extensions/context_extensions.dart';
import 'package:telegram/core/configurations/colors.dart';

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
        height: context.screenHeight,
        child: Column(
          children: [
            SizedBox(
              child: TabBar(
                splashFactory: NoSplash.splashFactory,
                labelStyle: Theme.of(context).textTheme.bodySmall,
                isScrollable: true,
                labelColor: AppColor.blueSecondary,
                unselectedLabelColor: AppColor.greyText,
                indicatorColor: AppColor.blueSecondary,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: AppColor.black,
                tabAlignment: TabAlignment.start,
                dividerHeight: 0.5,

                tabs: const [
                  TabItem("Chats"),

                  TabItem("Channels"),
                  TabItem("Apps"),
                  TabItem("Media"),
                  TabItem("Downloads"),
                  TabItem("Links"),
                  TabItem("Files"),
                  TabItem("Music"),
                  TabItem("Voice"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  TabItem("Chats"),

                  TabItem("Channels"),
                  TabItem("Apps"),
                  TabItem("Media"),
                  TabItem("Downloads"),
                  TabItem("Links"),
                  TabItem("Files"),
                  TabItem("Music"),
                  TabItem("Voice"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
      child: Text(text),
    );
  }
}
