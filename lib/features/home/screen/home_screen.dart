import 'package:flutter/material.dart';
import 'package:telegram/core/common/widgets/custom_drawer.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/common/widgets/width_spcer.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/custom_search_delegate.dart';
import 'package:telegram/core/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text("Telegram", style: normalText(fontsize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: CustomSearchDelegate()),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: 18,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColor.blueText,
                        ),
                        const WidthSpacer(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name", style: normalText()),
                            Text("Last Message", style: greyText(fontsize: 12)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("11:00 AM", style: greyText(fontsize: 12)),
                        const HeightSpacer(height: 6),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: const BoxDecoration(
                            color: AppColor.blueSecondary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text("1", style: normalText(fontsize: 8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const HeightSpacer(),
                const Divider(
                  indent: 52,
                  color: AppColor.black,
                  thickness: 0.0,
                  height: 2,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: AppColor.blueSecondary,
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}
