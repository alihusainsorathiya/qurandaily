import 'package:flutter/material.dart';
import 'package:qurandaily/constants/uiconstants.dart';
import 'package:qurandaily/widgets/spacing.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/domain/rss_feed.dart';

class LatestNewsDetails extends StatefulWidget {
  final int i;
  final RssFeed? data;

  const LatestNewsDetails({Key? key, required this.i, required this.data})
      : super(key: key);

  @override
  State<LatestNewsDetails> createState() => _LatestNewsDetailsState();
}

class _LatestNewsDetailsState extends State<LatestNewsDetails> {
  @override
  Widget build(BuildContext context) {
    var items = widget.data!.items![widget.i];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(items.title.toString()),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Image.network(
            items.media.toString(),
            width: 30.h,
            height: 30.h,
            fit: BoxFit.cover,
          ),
          addVerticalSpace(15.0),
          normalText(items.title.toString(), Colors.blue, 14.0, true),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: normalText(
                items.description.toString(), Colors.black, 12.0, false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              IconButton(
                  onPressed: launchBrowser(
                    Uri.parse(
                      items.link.toString(),
                    ),
                  ),
                  icon: const Icon(Icons.read_more)),
            ],
          )
        ]),
      ),
    );
  }

  launchBrowser(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No web browser found"),
      ));
    }
  }
}
