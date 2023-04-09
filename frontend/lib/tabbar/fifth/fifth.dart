import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// const Map<String, String> UNIT_ID = kReleaseMode
//     ? {
//         'ios': 'ca-app-pub-7064513655636813~2675423705',
//         'android': 'ca-app-pub-7064513655636813~2148810090',
//       }
//     : {
//         'ios':
//             'ca-app-pub-3940256099942544/6300978111', //'ca-app-pub-3940256099942544/2934735716',
//         'android': 'ca-app-pub-3940256099942544/6300978111',
//       };

class FifthPage extends StatelessWidget {
  final String id;
  const FifthPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // TargetPlatform os = Theme.of(context).platform;
    // BannerAd banner = BannerAd(
    //   listener: BannerAdListener(
    //     onAdFailedToLoad: (Ad ad, LoadAdError error) {},
    //     onAdLoaded: (_) {},
    //   ),
    //   size: AdSize.banner,
    //   adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
    //   request: AdRequest(),
    // )..load();

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   height: 50,
          //   width: banner.size.width.toDouble(),
          //   color: Colors.transparent,
          //   child: AdWidget(ad: banner),
          // ),
        ],
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     child: Text("5"),
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
