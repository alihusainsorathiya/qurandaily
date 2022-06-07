import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:qurandaily/constants/uiconstants.dart';
import 'package:qurandaily/model/azaanmodel.dart';
import 'package:qurandaily/network/api.dart';
import 'package:qurandaily/network/apiclient.dart';
import 'package:qurandaily/widgets/prayertimes.dart';
import 'package:qurandaily/widgets/spacing.dart';

class NamazTimingforToday extends StatefulWidget {
  const NamazTimingforToday({Key? key}) : super(key: key);

  @override
  State<NamazTimingforToday> createState() => _NamazTimingforTodayState();
}

class _NamazTimingforTodayState extends State<NamazTimingforToday> {
  // late Position position;

  late Future<AzaanTime> azaanTime;

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission Denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  initState() {
    super.initState();
    // getPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrayerTimes(),
      builder: ((context, AsyncSnapshot<AzaanTime> asyncSnapshot) {
        if ((asyncSnapshot.hasData)) {
          AzaanTime prayertime = asyncSnapshot.data!;
          return Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Salamun Alaykum,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  addVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      prayerTimes(
                          "Fajr", prayertime.data!.timings!.fajr.toString()),
                      prayerTimes("Sunrise",
                          prayertime.data!.timings!.sunrise.toString()),
                      prayerTimes("Maghrib",
                          prayertime.data!.timings!.maghrib.toString()),
                      prayerTimes(
                          "Isha", prayertime.data!.timings!.isha.toString()),
                      prayerTimes("Sunrise",
                          prayertime.data!.timings!.sunset.toString()),
                      prayerTimes("Midnight",
                          prayertime.data!.timings!.midnight.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          normalText(
                              prayertime.data!.date!.gregorian!.weekday!.en
                                  .toString(),
                              Colors.white,
                              15,
                              true),
                          normalText(prayertime.data!.date!.readable.toString(),
                              Colors.white, 12),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            prayertime.data!.date!.hijri!.month!.ar.toString(),
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                          normalText(
                              (prayertime.data!.date!.hijri!.day.toString() +
                                  " " +
                                  prayertime.data!.date!.hijri!.month!.en
                                      .toString() +
                                  " " +
                                  prayertime.data!.date!.hijri!.year
                                      .toString() +
                                  " " +
                                  prayertime.data!.date!.hijri!.designation!
                                      .abbreviated
                                      .toString()),
                              Colors.white,
                              12),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent));
        }
      }),
    );
  }

  Future<AzaanTime> getPrayerTimes() async {
    //  Get current Location
    Position position = await getCurrentLocation();

    String url = Api().PrayerTimesURLMaker(
        position.latitude.toString(), position.longitude.toString());

    Response response = await ApiClient().getData(url);

    var data = response.body.toString();

    var azaanTime = azaanTimeFromJson(response.body);
    return azaanTime;
  }
}
//     position = await getCurrentLocation().then((v) async {
//       // setState(() {
//       latitude = v.latitude.toString();
//       longitude = v.longitude.toString();

//       debugPrint("Position [v] :: " + v.toString());
//       // });
// // Make URL

//       String url = Api()
//           .PrayerTimesURLMaker(v.latitude.toString(), v.longitude.toString());
//       debugPrint(url);
//       Response response = await ApiClient().getData(url);

//       // var data = response.body.toString();

//       var azaanTime = azaanTimeFromJson(response.body);

//       // timings = azaanTime.data!.timings!;
//       // var data = js   var abc = data;

//       // String fajrTimings = timings['Fajr'].toString();
//       // debugPrint("Fajr Timings :::::" + fajrTimings);
//       // debugPrint("Prayer Times +++++" + data);

// // API CALL
//     });
//     return azaanTime;
//   }