import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PagePopularPost extends StatefulWidget {
  const PagePopularPost({Key? key}) : super(key: key);

  @override
  _PagePopularPostState createState() => _PagePopularPostState();
}

class _PagePopularPostState extends State<PagePopularPost> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocationProvider>().getPinTop50();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인기글'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Consumer<LocationProvider>(builder: (context, value, child) {
      if (value.state == ViewState.Busy) {
        return Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _listItem(index, value.top50PinDatas!);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: value.myPinDatas!.length),
        );
      }
    });
  }

  Widget _listItem(int index, List<ResponseGetPinData> top50PinDatas) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(
        top50PinDatas[index].pin!.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        top50PinDatas[index].pin!.body!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        context.read<LocationProvider>().selectedPinData = top50PinDatas[index];
        LatLng location = LatLng(
            top50PinDatas[index].pin!.lat!, top50PinDatas[index].pin!.lng!);
        context.read<LocationProvider>().setLastLocation(location);
        Navigator.of(context).pushNamedAndRemoveUntil(
            'PageMap', (route) => false,
            arguments: top50PinDatas[index].pin!.id!);
      },
    );
  }
}
