import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PageMyPost extends StatefulWidget {
  const PageMyPost({Key? key}) : super(key: key);

  @override
  _PageMyPostState createState() => _PageMyPostState();
}

class _PageMyPostState extends State<PageMyPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내글'),
      ),
      body: _body(),
    );
  }

  _body() {
    var responseGetPinData =
        context.watch<LocationProvider>().responseGetPinData;
    return SingleChildScrollView(
      child: ListView.separated(
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
