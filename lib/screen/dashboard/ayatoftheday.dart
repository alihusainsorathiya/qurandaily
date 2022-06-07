import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qurandaily/constants/config.dart';
import 'package:qurandaily/model/quranmodel.dart';
import 'package:qurandaily/network/api.dart';
import 'package:qurandaily/network/apiclient.dart';
import 'package:qurandaily/screen/quran.dart';

class AyatofTheDay extends StatefulWidget {
  const AyatofTheDay({Key? key}) : super(key: key);

  @override
  State<AyatofTheDay> createState() => _AyatofTheDayState();
}

class _AyatofTheDayState extends State<AyatofTheDay> {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  int surahNumber = 0;
  int ayatNumber = 0;
  String surahName = "1";
  String ayatName = "1";
  String ayatText = "1";
  dynamic aotd = [];
  var suraName = '';
  var suraNo = '';
  var ayatNo = '';
  var ayat = '';
  var abc = '';
  late Future<String> ayatTranslation;
  String trans = "";
  int userSelectedTranslationIndex = 0;
  @override
  void initState() {
    super.initState();
    chec();
  }

//  Getting data from Quran
  chec() async {
    aotd = await fetchQuranfromjson().then((v) {
      debugPrint('hasan' + v.toString());
      setState(() {
        suraName = v[3].toString();
        ayat = v[5].toString();
        suraNo = v[0];
        ayatNo = v[1];
        debugPrint(abc.toString());
        getTranslation(suraNo, ayatNo, Config().getLanguage());
      });
    });
  }

  getOtherLanguageTranslations() async {}
  saveAyatOfTheDayToList() {}
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: <Widget>[
        Card(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          elevation: 5,
          color: Colors.blue,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                // alignment: Alignment.topCenter,
                // padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 23),
                child: Column(
                  textDirection: TextDirection.rtl,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // ignore: unnecessary_null_comparison
                    ayat != null
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              // flex: 1,
                              child: Text(
                                ayat.replaceAll("\n", " "),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                // textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                    color: Colors.yellow,
                                    // overflow: TextOverflow.visible,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        : Container(),
                    // TODO Translation Language

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        trans,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            // overflow: TextOverflow.visible,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      ),
                    ),
                    // const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            suraName != null
                                ? Align(
                                    alignment: Alignment.bottomLeft,
                                    // heightFactor: 0.8,

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "(" + suraName + ":" + ayatNo + ")",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.visible,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                  )
                                : Container(),
                            // const Spacer(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        // color: Colors.amber,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QuranIndex()),
                                ),
                                child: const Text(
                                  'Read Quran',
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: -5,

            // left: MediaQuery.,
            // left: MediaQuery.of(context).size.width * 0.35,

            child: Container(
              margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
              // elevation: 10,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  5,
                ),
                color: Colors.black,
              ),

              child: const Text(
                "  Ayat of the day  ",
                style: TextStyle(
                    // backgroundColor: Colors.black54,
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ))
      ],
    );
  }

  fetchQuranfromjson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/quranuthmani.json");
    final jsonResult = jsonDecode(data);

    final quranModel = quranModelFromJson(jsonEncode(jsonResult));

    List ayatoftheday = ayatotd(quranModel);
    // print("AOTD:================" + ayatoftheday.toString());
    return ayatoftheday;
  }

  ayatotd(QuranModel quranModel) {
    Random random = Random();
    surahNumber = random.nextInt(113);

    int ayatNumber = random
        .nextInt((quranModel.data!.surahs![surahNumber].ayahs!.length + 1));

    String ayatText = quranModel
        .data!.surahs![surahNumber].ayahs![ayatNumber].text
        .toString();
    String surahName = quranModel.data!.surahs![surahNumber].name.toString();

    String surahEnglishName =
        quranModel.data!.surahs![surahNumber].englishName.toString();

    String surahNameTranslation =
        quranModel.data!.surahs![surahNumber].englishNameTranslation.toString();

    List aotd = [];
    aotd.add((surahNumber + 1).toString());
    aotd.add(ayatNumber.toString());
    aotd.add(surahName);
    aotd.add(surahEnglishName);
    aotd.add(surahNameTranslation);
    aotd.add(ayatText);
    print("asdadsadsaddsdsad" + aotd[0]);
    return aotd;
  }

  getTranslation(String suraNo, String ayatNo, language) async {
    debugPrint("inside getTranslation");
    (userSelectedTranslationIndex == 0)
        ? getEnglishTranslations(suraNo, ayatNo)
            .then((value) => setState((() => trans = '"' + value + '"')))
        : ayatTranslation = getOtherLanguageTranslations()
            .then((value) => setState((() => trans = '"' + value + '"')));
  }
}

Future<String> getEnglishTranslations(String suraNo, String ayatNo) async {
  String urlFormation =
      Api().QURAN_BASE_URL + Api().ayah + suraNo + ":" + ayatNo;
// http://api.alquran.cloud/v1/ayah/2:255/en.asad

  var response = await ApiClient().get(urlFormation, Api().EN);

  var data = json.decode(response.body);

  // debugPrint("data::__++++++++++ : " + data.toString());
  String ayat = data['data']['text'].toString();

  // debugPrint("Ayat Translation  ::: " + ayat.toString());

  return ayat;
}
