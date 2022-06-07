import 'package:flutter/material.dart';

Widget prayerTimes(String prayerName, String prayerTime) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () => debugPrint(prayerName + " : " + prayerTime),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(9),
        primary: Colors.white.withOpacity(0.85),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: Column(
        children: [
          Text(
            prayerName,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 12.0),
          ),
          Text(prayerTime,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold))
        ],
      ),
    ),
  );
}
