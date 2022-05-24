import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_user_info.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/pages/components/ds_two_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PageUserPost extends StatefulWidget {
  const PageUserPost({
    Key? key,
  }) : super(key: key);

  @override
  _PageUserPostState createState() => _PageUserPostState();
}

class _PageUserPostState extends State<PageUserPost> {
  ModelUserInfo? selectedUser;
  @override
  void initState() {
    Future.microtask(() {
      selectedUser = context.read<UserProvider>().selectedUser;
      context.read<LocationProvider>().getUserPin(selectedUser!.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserProvider>(builder: (context, value, child) {
          if (value.state == ViewState.Busy) {
            return Text('');
          }
          return Text(
            '${value.selectedUser!.name} 님의 글',
            overflow: TextOverflow.ellipsis,
          );
        }),
        // centerTitle: true,
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
                return _listItem(index, value.userPinDatas!);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: value.userPinDatas!.length),
        );
      }
    });
  }

  Widget _listItem(int index, List<ResponseGetPinData> userPinDatas) {
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
      title: Text(
        userPinDatas[index].pin!.title!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        userPinDatas[index].pin!.body!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: () {
        context.read<LocationProvider>().selectedPinData = userPinDatas[index];
        context
            .read<LocationProvider>()
            .getPinReply(userPinDatas[index].pin!.id!);
        LatLng location = LatLng(
            userPinDatas[index].pin!.lat!, userPinDatas[index].pin!.lng!);
        context.read<LocationProvider>().setLastLocation(location);
        Navigator.of(context).pushNamedAndRemoveUntil(
            'PageMap', (route) => false,
            arguments: userPinDatas[index].pin!.id!);
      },
    );
  }
}
