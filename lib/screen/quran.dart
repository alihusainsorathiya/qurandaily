import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:qurandaily/constants/uiconstants.dart';
import 'package:qurandaily/model/quranmodel.dart';
import 'package:qurandaily/screen/qurandetail.dart';
import 'package:qurandaily/widgets/ayatdecoration.dart';

class QuranIndex extends StatefulWidget {
  const QuranIndex({Key? key}) : super(key: key);

  @override
  State<QuranIndex> createState() => _QuranIndexState();
}

class _QuranIndexState extends State<QuranIndex> {
  late QuranModel quranModel;
  QuranModel? quran;
  late Future<QuranModel> quranList;

  @override
  void initState() {
    super.initState();
    quranList = fetchQuranfromjson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Quran"),
          centerTitle: true,
        ),
        body: FutureBuilder<QuranModel>(
          future: quranList,
          builder: (context, snapshot) {
            //  quran = snapshot.data!;
            quran = snapshot.data!;
            // List<Surah> surah = quran.data.surahs;
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              {
                return _buildListView(quran);
              }
            }
          },
        ),
      ),
    );
  }

  // Future<QuranModel> fetchQuran() async {
  //   var response = await ApiClient().get(Api().BASE_URL, Api().UTHMANI);
  //   //   // var url = Uri.parse('http://api.alquran.cloud/v1/quran/quran-uthmani');
  //   // final quranModel = quranModelFromJson(utf8.decode(response));
  //   final quranModel = quranModelFromJson(jsonEncode(response));
  //   return quranModel;
  // }

  Future<QuranModel> fetchQuranfromjson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/quranuthmani.json");
    final jsonResult = jsonDecode(data);

    final quranModel = quranModelFromJson(jsonEncode(jsonResult));
    return quranModel;
  }
}

Widget _buildListView(QuranModel? quran) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (ctx, index) {
      double sizeNumbering = 40;
      double rowwidth = (MediaQuery.of(ctx).size.width);
      var surahs = quran!.data!.surahs![index];
      var ayahs = surahs.ayahs;
      var ayats = [];
      // print(surahs.ayahs!.length);
      for (int i = 0; i < ayahs!.length; i++) {
        ayats.add(surahs.ayahs![i].text);
      }

      return GestureDetector(
        onTap: (() => Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (context) => QuranDetail(
                  ayats: ayats,
                  surahname: surahs.englishName.toString() +
                      " (" +
                      surahs.englishNameTranslation.toString() +
                      ") " +
                      ": " +
                      surahs.number.toString(),
                ),
              ),
            )),
        child: Card(
          child: Container(
            width: rowwidth,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            color: (index % 2 == 1) ? Colors.grey.shade50 : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Surah Number
                AyatDecoration(
                  sizeNumbering: sizeNumbering,
                  text: (index + 1).toString(),
                ),

                Column(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalText(surahs.englishName.toString(), Colors.black,
                        15.0, true),
                    const SizedBox(
                      height: 5,
                    ),
                    normalText(
                        "(" + surahs.englishNameTranslation.toString() + ")",
                        Colors.black54,
                        12.0,
                        true),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      // margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Center(
                        child: normalText(
                            "Ayats : " + (surahs.ayahs!.length).toString(),
                            Colors.white,
                            11.0,
                            false),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                (surahs.revelationType
                            .toString()
                            .replaceAll("RevelationType.", "") ==
                        "MECCAN")
                    ? Image.asset(
                        'images/mecca.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'images/medina.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          ),
        ),
      );
    },
    itemCount: quran!.data!.surahs!.length,
  );
}
