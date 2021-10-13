import 'package:dongnesosik/page_tabs.dart';
import 'package:dongnesosik/pages/03_post/page_post.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (settings.name) {
      case 'PageTabs':
        return CupertinoPageRoute(
          builder: (_) => PageTabs(),
          settings: settings,
        );

      case 'PageIntro':
        return CupertinoPageRoute(
          builder: (_) => PageTabs(),
          settings: settings,
        );

      case 'PagePost':
        return CupertinoPageRoute(
          builder: (_) => PagePost(),
          settings: settings,
        );

      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} 는 lib/route.dart에 정의 되지 않았습니다.'),
            ),
          ),
        );
    }
  }

  static loadMain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('PageTabs', (route) => false);
    // if (Singleton.shared.userData!.user!.agreeTerms == true) {
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('PageTabs', (route) => false);
    // } else {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //     'PageAgreement',
    //     (route) => false,
    //     arguments: true,
    //   );
    // }
  }
}
