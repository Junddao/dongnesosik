// import 'package:dongnesosik/global/model/user/model_request_guest_info.dart';
// import 'package:dongnesosik/global/provider/user_provider.dart';
// import 'package:dongnesosik/global/service/api_service.dart';
// import 'package:dongnesosik/pages/01_Login/page_login.dart';
// import 'package:dongnesosik/pages/02_map/page_map.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

// class PageRoot extends StatelessWidget {
//   const PageRoot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             // return PageLogin();
//             return PageMap();
//           } else {
//             ModelRequestGuestInfo modelRequestUserGuestInfo =
//                 ModelRequestGuestInfo(
//               uid: ApiService.deviceIdentifier,
//               osType: ApiService.osType,
//               osVersion: ApiService.osVersion,
//               deviceModel: ApiService.deviceModel,
//             );
//             context.read<UserProvider>().createGuest(modelRequestUserGuestInfo);
//             return PageMap();
//           }
//         },
//       ),
//     );
//   }
// }
