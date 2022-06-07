import 'package:flutter/cupertino.dart';

class Api {
  String QURAN_BASE_URL = 'http://api.alquran.cloud/v1/';
  String UTHMANI = 'quran/quran-uthmani';
// http://api.alquran.cloud/v1/ayah/2:255/en.asad
  String NEWS_URL = 'rss';

  String NEWS_BASE_URL = 'http://en.abna24.com/';
  String EN = "/en.asad";
  String ayah = "ayah/";

  String PRAYERTIMES_BASEURL = 'http://api.aladhan.com/v1/timings/';

  String currentTimeStamp = DateTime.now().toString();
  String method = '&method=2';
// http://api.aladhan.com/v1/timings/1398332113?latitude=51.508515&longitude=-0.1254872&method=2

  String PrayerTimesURLMaker(String latitude, String longitude) {
    String abc =
        "http://api.aladhan.com/v1/timings/$currentTimeStamp?latitude=$latitude&longitude=$longitude&method=0";
    debugPrint('URL ++++++ :' + abc);

    String url = PRAYERTIMES_BASEURL +
        currentTimeStamp +
        "?latitude=" +
        latitude +
        "?longitude=" +
        longitude +
        "&method=0";

    debugPrint('||||||||||||||||Formed url' + url);
    debugPrint("current URL:" + abc);
    return abc;
  }

// https://api.alquran.cloud/v1/edition/language/en
// https://api.quran.com/api/v4/chapters?language=en

  // http://api.alquran.cloud/v1/quran/quran-uthmani
}
