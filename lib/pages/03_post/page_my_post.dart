import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PageMyPost extends StatefulWidget {
  const PageMyPost({Key? key}) : super(key: key);

  @override
  _PageMyPostState createState() => _PageMyPostState();
}

class _PageMyPostState extends State<PageMyPost> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocationProvider>().getPinMe();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내글'),
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
                return _listItem(index, value.myPinDatas!);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: value.myPinDatas!.length),
        );
      }
    });
  }

  Widget _listItem(int index, List<ResponseGetPinData> myPinDatas) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: ClipOval(
          child: SingletonUser.singletonUser.userData.profileImage == null ||
                  SingletonUser.singletonUser.userData.profileImage == ''
              ? SvgPicture.asset(
                  'assets/images/person.svg',
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                )
              : CachedNetworkImage(
                  imageUrl: SingletonUser.singletonUser.userData.profileImage!,
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ),
        ),
      ),
      title: Text(myPinDatas[index].pin!.title!),
      subtitle: Text(myPinDatas[index].pin!.body!),
      onTap: () {
        context.read<LocationProvider>().selectedPinData = myPinDatas[index];
        LatLng location =
            LatLng(myPinDatas[index].pin!.lat!, myPinDatas[index].pin!.lng!);
        context.read<LocationProvider>().setLastLocation(location);
        Navigator.of(context).pushNamedAndRemoveUntil(
            'PageMap', (route) => false,
            arguments: myPinDatas[index].pin!.id!);
      },
    );
  }
}
