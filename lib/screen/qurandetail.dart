import 'package:flutter/material.dart';
import 'package:qurandaily/widgets/ayatdecoration.dart';

class QuranDetail extends StatefulWidget {
  QuranDetail({Key? key, required this.ayats, required this.surahname})
      : super(key: key);
  var ayats, surahname;

  @override
  State<QuranDetail> createState() => _QuranDetailState();
}

class _QuranDetailState extends State<QuranDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        title: Text(widget.surahname),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.ayats.length,
                itemBuilder: ((context, index) {
                  var ayats = widget.ayats;
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              AyatDecoration(
                                  sizeNumbering: 40,
                                  text: (index + 1).toString()),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  ayats[index] + " ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: (() => {print(index.toString())}),
                                  icon: const Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }
}
