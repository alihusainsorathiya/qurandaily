import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qurandaily/constants/uiconstants.dart';
import 'package:qurandaily/screen/dashboard/latestnewsdetailed.dart';
import 'package:sizer/sizer.dart';
// import 'pack';

import 'package:webfeed/domain/rss_feed.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({Key? key}) : super(key: key);

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  RssFeed? data;

  @override
  initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normalText("Latest News", Colors.blue, 18.0, true),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: 20.h,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  // margin: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  // separatorBuilder: (context, index) => const Divider(),
                  itemCount: data!.items!.length,
                  // itemCount: 1,
                  itemBuilder: (c, i) {
                    var title = data!.items![i].title.toString();
                    var image = data!.items![i].media!.toString();
                    var category = data!.items![i].categories.toString();
                    var publishdate = data!.items![i].pubDate.toString();
                    var link = data!.items![i].link.toString();
                    var description = data!.items![i].description.toString();
                    // debugPrint("IMG :" + data!.items![i].title.toString());
                    // return Container(
                    //   padding: const EdgeInsets.all(0),
                    //   margin: const EdgeInsets.all(0),
                    //   width: MediaQuery.of(context).size.width * 0.35,
                    //   height: MediaQuery.of(context).size.height * 0.25,
                    //   child: Card(
                    //     clipBehavior: Clip.antiAlias,
                    //     elevation: 8,
                    //     child: Stack(
                    //       alignment: Alignment.bottomCenter,
                    //       clipBehavior: Clip.none,
                    //       children: <Widget>[
                    //         Container(
                    //             margin: const EdgeInsets.all(0),

                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(3.0),
                    //               child: Image.network(
                    //                 data!.items![i].media!.toString(),
                    //                 fit: BoxFit.contain,
                    //                 width:
                    //                     MediaQuery.of(context).size.width * 0.35,
                    //                 height:
                    //                     MediaQuery.of(context).size.height * 0.25,
                    //               ),
                    //             )

                    //             ),
                    //         Positioned(
                    //           child: Container(
                    //             height: MediaQuery.of(context).size.width * 0.05,
                    //             color: Colors.white.withOpacity(0.65),
                    //             child: Text(
                    //               data!.items![i].title.toString(),
                    //               maxLines: 2,
                    //               overflow: TextOverflow.ellipsis,
                    //               softWrap: false,
                    //               style: const TextStyle(
                    //                 fontSize: 10,
                    //                 fontWeight: FontWeight.normal,
                    //                 color: Color(0xff185a9d),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),

                    //     //  image:
                    //     margin: const EdgeInsets.only(
                    //         left: 20.0, right: 20.0, top: 5.0),
                    //   ),
                    // );

                    // return GestureDetector(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(3),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         ClipRRect(
                    //           child: Image.network(
                    //             data!.items![i].media!.toString(),
                    //             fit: BoxFit.cover,
                    //             height: 15.h,
                    //             width: 24.w,
                    //           ),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         const SizedBox(
                    //           // height: 0.5.h,
                    //           height: 0.7,
                    //         ),
                    //         Container(
                    //           color: Colors.blue.withOpacity(0.65),
                    //           width: 24.w,
                    //           child: Text(
                    //             data!.items![i].title.toString(),
                    //             maxLines: 2,
                    //             overflow: TextOverflow.ellipsis,
                    //             style: const TextStyle(color: Colors.black),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );

                    return Container(
                      width: 40.w,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      // width: MediaQuery.of(context).size.width * 0.5,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => LatestNewsDetails(
                          //       i: i,
                          //       data: data,
                          //     ),
                          //   ),
                          // );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LatestNewsDetails(i: i, data: data),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    data!.items![i].media!.toString(),
                                    fit: BoxFit.cover,
                                    width: 40.w,
                                    height: 60.w,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                      gradient: LinearGradient(
                                        end: const Alignment(0.0, -1),
                                        begin: const Alignment(0.0, 0.2),
                                        colors: [
                                          Colors.black,
                                          Colors.black.withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        data!.items![i].title.toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  getNews() async {
    Response response =
        // await ApiClient().get(Api().NEWS_BASE_URL, Api().NEWS_URL);
        await get(
      Uri.parse("https://en.abna24.com/rss"),
      //  headers: {
      // "Access-Control-Allow-Origin": "*",
      // "Content-Type": "application/xml",
      // "Accept": "text/html,application/xhtml+xml,application/xml",
      // }
    );

    // debugPrint('URL NEWS' + Api().NEWS_URL);
    // if (response.statusCode == 200) {
    debugPrint('NEWS 200');
    data = RssFeed.parse(response.body.toString());

    debugPrint("IMG :" + data!.items![0].description.toString());
    // debugPrint("DATAAAAAAAA" + data.toString());
    setState(() {});
    // }
  }
}
