import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class PagePost extends StatefulWidget {
  const PagePost({Key? key}) : super(key: key);

  @override
  _PagePostState createState() => _PagePostState();
}

class _PagePostState extends State<PagePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동내 게시글'),
      ),
      body: _body(),
    );
  }

  _body() {
    var responseGetPinData =
        context.watch<LocationProvider>().responseGetPinDatas;
    return SingleChildScrollView(
      child: ListView.separated(
          padding: EdgeInsets.only(top: 0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _listItem(index, responseGetPinData!);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: responseGetPinData!.length),
    );
  }

  Widget _listItem(int index, List<ResponseGetPinData> responseGetPinData) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(responseGetPinData[index].pin!.title!),
      subtitle: Text(responseGetPinData[index].pin!.body!),
      onTap: () {
        context.read<LocationProvider>().selectedPinData =
            responseGetPinData[index];
        LatLng location = LatLng(responseGetPinData[index].pin!.lat!,
            responseGetPinData[index].pin!.lng!);
        context.read<LocationProvider>().setLastLocation(location);
        Navigator.of(context).pushNamedAndRemoveUntil(
            'PageMap', (route) => false,
            arguments: responseGetPinData[index].pin!.id!);

        // context.read<LocationProvider>().selectedPinData =
        //     responseGetPinData[index];
        // Navigator.of(context).pushNamed('PagePostDetail');
      },
      // trailing: IconButton(
      //   onPressed: () {
      //     LatLng location = LatLng(responseGetPinData[index].pin!.lat!,
      //         responseGetPinData[index].pin!.lng!);
      //     context.read<LocationProvider>().setLastLocation(location);
      //     Navigator.of(context).pushNamedAndRemoveUntil(
      //         'PageMap', (route) => false,
      //         arguments: responseGetPinData[index].pin!.id!);
      //   },
      //   icon: Icon(Ionicons.map_outline),
      // ),
    );
  }
}
