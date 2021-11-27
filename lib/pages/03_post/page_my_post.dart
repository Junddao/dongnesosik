import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/pages/components/ds_two_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (slidableContext) {
              deletePost(slidableContext, myPinDatas[index]);
            },
            flex: 2,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
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
                    imageUrl:
                        SingletonUser.singletonUser.userData.profileImage!,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
          ),
        ),
        title: Text(
          myPinDatas[index].pin!.title!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          myPinDatas[index].pin!.body!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        onTap: () {
          context.read<LocationProvider>().selectedPinData = myPinDatas[index];
          context.read<LocationProvider>().getPinReply(myPinDatas[index].pin!.id!);
          LatLng location =
              LatLng(myPinDatas[index].pin!.lat!, myPinDatas[index].pin!.lng!);
          context.read<LocationProvider>().setLastLocation(location);
          Navigator.of(context).pushNamedAndRemoveUntil(
              'PageMap', (route) => false,
              arguments: myPinDatas[index].pin!.id!);
        },
      ),
    );
  }

  void deletePost(
      BuildContext slidableContext, ResponseGetPinData pinData) async {
    var result = await DSTwoButtonDialog.showCancelDialog(
        context: context,
        title: '게시글 삭제',
        subTitle: '정말 삭제하시겠습니까?',
        btn1Text: '아니요,',
        btn2Text: '네,');
    if (result == true) {
      context
          .read<LocationProvider>()
          .pinDelete(pinData.pin!.id!)
          .then((value) {
        context.read<LocationProvider>().getPinMe();
      });
    }
  }
}
