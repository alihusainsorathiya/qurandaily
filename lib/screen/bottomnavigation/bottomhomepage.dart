import 'package:flutter/material.dart';
import 'package:qurandaily/screen/dashboard/ayatoftheday.dart';
import 'package:qurandaily/screen/dashboard/latestnews.dart';
import 'package:qurandaily/screen/dashboard/marhoomlistview.dart';
import 'package:qurandaily/screen/dashboard/namaztimingfortoday.dart';
import 'package:qurandaily/screen/dashboard/quranevents.dart';
import 'package:qurandaily/widgets/spacing.dart';

class BottomHomePage extends StatefulWidget {
  const BottomHomePage({Key? key}) : super(key: key);

  @override
  State<BottomHomePage> createState() => _BottomHomePageState();
}

class _BottomHomePageState extends State<BottomHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              const NamazTimingforToday(),
              addVerticalSpace(),
              const AyatofTheDay(),
              addVerticalSpace(),
              const LatestNews(),
              addVerticalSpace(),
              const MarhoomListView(),
              addVerticalSpace(),
              const QuranEvents(),

              // const MarhoomListView(),
            ],
          ),
        ),
      ),
    );
  }
}
