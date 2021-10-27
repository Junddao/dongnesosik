import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/provider/post_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:dongnesosik/pages/components/ds_photo_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PageMap extends StatefulWidget {
  const PageMap({Key? key}) : super(key: key);

  @override
  _PageMapState createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Marker> _markers = [];
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();

  BitmapDescriptor? customIcon;
  Timer? _timer;
  var _time = 0;
  var _isRunning = false;
  List<String> imageUrls = [test_image_url, test_image_url, test_image_url];
  TextEditingController tecMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _start();
    getMyLocation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/marker.png',
    );
  }

  void getMyLocation() async {
    // final GoogleMapController controller = await _controller.future;
    if (context.read<LocationProvider>().myLocation != null) {
      moveCameraToMyLocation();
      return;
    }

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location services are disabled.');
      }
    }

    LocationData locationData = await location.getLocation();
    print(locationData.latitude!);
    print(locationData.longitude!);
    LatLng latlng = LatLng(locationData.latitude!, locationData.longitude!);

    context.read<LocationProvider>().setMyLocation(latlng);
    context.read<LocationProvider>().setLastLocation(latlng);
    moveCameraToMyLocation();
  }

  void moveCameraToMyLocation() {
    var provider = context.read<LocationProvider>();
    _controller.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(
              provider.myLocation!.latitude, provider.myLocation!.longitude),
          zoom: 15,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
        drawer: _drawer(),
        extendBodyBehindAppBar: true,
        drawerEnableOpenDragGesture: true,
        // resizeToAvoidBottomInset: true,
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add, color: DSColors.white),

        //   // child: Text('글쓰기', style: DSTextStyle.bold12Black),
        //   backgroundColor: DSColors.tomato,
        //   onPressed: () async {
        //     Navigator.of(context).pushNamed('PagePostCreate');
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  AppBar _appBar() {
    var provider = context.watch<LocationProvider>();
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(
          provider.placemarks.isEmpty
              ? ''
              : provider.placemarks[0].subLocality!,
          style: DSTextStyles.bold18Black),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('PagePostCreate');
          },
          child: Text('새글쓰기', style: DSTextStyles.bold14Tomato),
        ),
      ],
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(left: 10),
        children: <Widget>[
          // drawer header
          _drawerHeader(),

          // my history

          ListTile(
            leading: Icon(Ionicons.document_text_outline),
            title: Text(
              '내글보기',
              style: DSTextStyles.bold14Black,
            ),
            onTap: () {
              Navigator.of(context).pop(); // drawer 닫기
            },
          ),
          ListTile(
            leading: Icon(Ionicons.documents_outline),
            title: Text(
              '인기글보기',
              style: DSTextStyles.bold14Black,
            ),
            onTap: () {
              Navigator.of(context).pop(); // drawer 닫기
            },
          ),
          ListTile(
            leading: Icon(Ionicons.share_social_outline),
            title: Text(
              '계정 연결',
              style: DSTextStyles.bold14Black,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('PageLogin', (route) => false);
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil('PageRoot', (route) => false);
            },
          ),

          ListTile(
            leading: Icon(Ionicons.log_out_outline),
            title: Text(
              '로그아웃',
              style: DSTextStyles.bold14Black,
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil('PageRoot', (route) => false);
            },
          ),
        ],
      ),
    );
    // Disable opening the drawer with a swipe gesture.
  }

  Widget _body() {
    return Consumer(builder: (_, LocationProvider value, child) {
      if (value.lastLocation == null || value.responseGetPinData == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        LatLng _lastLocation = value.lastLocation!;
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) async {
                await _onMapCreated(controller, _lastLocation);
              },
              initialCameraPosition: CameraPosition(
                target: _lastLocation,
                zoom: 15,
              ),
              markers: _markers.toSet(),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              // padding: EdgeInsets.only(bottom: 60, right: 8),
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              onCameraMove: _onCameraMove,
              onCameraIdle: _onCameraIdle,
              // onTap: (point) {
              //   _handleTap(point);
              // },
            ),
            Positioned(
              bottom: 30,
              left: 24,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('PagePost');
                  },
                  child: _newsInfoWidget()),
            ),
            // Positioned(
            //   top: AppBar().preferredSize.height +
            //       MediaQuery.of(context).padding.top +
            //       30,
            //   right: 12,
            //   child: InkWell(
            //     onTap: () async {
            //       getMyLocation();
            //     },
            //     child: CircleAvatar(
            //       backgroundColor: DSColors.white,
            //       foregroundColor: DSColors.black,
            //       child: Icon(Icons.my_location),
            //     ),
            //   ),
            // ),
          ],
        );
      }
    });
  }

  Widget _drawerHeader() {
    return Container(
      height: 200,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('memil님', style: DSTextStyles.bold16Black),
              subtitle: Text('반갑습니다.', style: DSTextStyles.regular12WarmGrey),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pushNamed('PageUserSetting');
              },
            ),
          ],
        ),
      ),
    );
  }

  addMyPin() {
    var provider = context.read<LocationProvider>();
    _markers.clear();
    addMarker(0, provider.lastLocation!);
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, LatLng location) async {
    _markers.clear();
    var provider = context.read<LocationProvider>();

    print('onMapCreate');
    print(location.toString());
    addMarker(0, location);

    _controller.complete(controller);
    provider.getAddress(location);
  }

  void _onCameraIdle() async {
    _markers.clear();
    var provider = context.read<LocationProvider>();

    // addMyPin();
    await provider.getPinInRagne(provider.lastLocation!.latitude,
        provider.lastLocation!.longitude, 1000);
    provider.responseGetPinData!.forEach((element) {
      addMarker(element.id!, LatLng(element.pin!.lat!, element.pin!.lng!));
    });

    // await provider.getPinAll();
    print("Idle");
  }

  void _onCameraMove(CameraPosition position) {
    var provider = context.read<LocationProvider>();
    provider.setLastLocation(position.target);
    print("move");
  }

  void addMarker(int id, LatLng latLng) {
    final marker = Marker(
        markerId: MarkerId(id.toString()),
        position: latLng,
        // icon: customIcon!,

        onTap: () async {
          print('marker onTap()');

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: buildBottomSheet(context, id),
              );
            },
          );
        });
    _markers.add(marker);
  }

//   _handleTap(LatLng point) {

//     var provider = context.read<LocationProvider>();

//     print('handelTap');
//     provider.setLastLocation(point);
//     provider.getAddress(point);

// _markers.clear();
// addMarker(id, latLng)
//     final marker = Marker(
//       markerId: MarkerId(provider.lastLocation.toString()),
//       position: provider.lastLocation!,

//       // TODO : Info Window는 내 주변 일정거리 안에 글의 갯수를 긁어서 보여주게 함.

//       // icon: customIcon!,
//     );

//     _markers.add(marker);
//   }

  Widget _newsInfoWidget() {
    var provider = context.read<LocationProvider>();

    return provider.responseGetPinData!.length == 0
        ? SizedBox.shrink()
        : InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('PagePost');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: DSColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              width: SizeConfig.screenWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: ' ${provider.responseGetPinData!.length}개',
                            style: DSTextStyles.bold14Black),
                        TextSpan(
                            text: '의 글이 검색되었어요.',
                            style: DSTextStyles.regular12WarmGrey),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  getAnimatedTitle(provider),
                ],
              ),
            ),
          );
  }

  Widget buildBottomSheet(BuildContext context, int id) {
    var responseGetPinDatas =
        context.read<LocationProvider>().responseGetPinData!.where((element) {
      return element.id == id;
    }).toList();
    context.read<LocationProvider>().selectedPinData =
        responseGetPinDatas.first;
    return viewPostContents(responseGetPinDatas);
  }

  Widget viewPostContents(List<ResponseGetPinData> responseGetPinDatas) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 30,
              width: double.infinity,
              child: Center(child: Icon(Ionicons.chevron_down_outline))),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DSPhotoView(iamgeUrls: imageUrls),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(responseGetPinDatas.first.pin!.title!,
                            style: DSTextStyles.bold18Black),
                        SizedBox(height: 20),
                        Text(responseGetPinDatas.first.pin!.body!),
                        SizedBox(height: 20),
                        Divider(),
                        // TODO 댓글 리스트

                        _buildReviewList(),
                      ],
                      //iimage - size는 작게
                      //body
                    ),
                  ),
                  // const SizedBox(height: 90),
                ],
              ),
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  void goDetailPage() async {
    Navigator.of(context).pushNamed('PagePostDetail');
  }

  void goCommunityPage() async {
    Navigator.of(context).pushNamed('PagePostCommunity');
  }

  void onClosePress() async {
    Navigator.of(context).pop();
  }

  getAnimatedTitle(LocationProvider provider) {
    return Row(
      children: [
        const SizedBox(width: 0.0, height: 50.0),
        DefaultTextStyle(
          style: DSTextStyles.regular12Black,
          overflow: TextOverflow.ellipsis,
          child: AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            animatedTexts: [
              for (ResponseGetPinData data in provider.responseGetPinData!)
                buildText(data),
            ],
          ),
        ),
      ],
    );
  }

  buildText(ResponseGetPinData data) {
    return RotateAnimatedText(data.pin!.title!);
  }

  Widget _buildMessageComposer() {
    return SafeArea(
      child: Consumer<PostProvider>(
        builder: ((_, data, __) {
          return Column(
            children: [
              data.reviewTarget == ''
                  ? SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        color: DSColors.warm_grey08,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: data.reviewTarget,
                                    style: DSTextStyles.bold12Black),
                                TextSpan(
                                    text: '글에 댓글',
                                    style: DSTextStyles.regular10Grey06),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                context
                                    .read<PostProvider>()
                                    .setReviewTarget('');
                              },
                              child: Icon(Icons.close)),
                        ],
                      ),
                    ),
              Container(
                // height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.add_a_photo),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFEFEFEF)),
                          borderRadius: BorderRadius.circular(21),
                          color: Color(0xFFF8F8F8),
                        ),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextField(
                                controller: tecMessage,
                                onChanged: (value) {},
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration.collapsed(
                                  hintText: '메세지를 입력하세요',
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                child: Icon(Icons.send),
                                padding: EdgeInsets.all(4),
                              ),
                              onTap: () {
                                sendMessage();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void sendMessage() {
    if (tecMessage.text.isEmpty) {
      return;
    }

    // ChatMessage chatMessage = ChatMessage(
    //   sendUserId: Singleton.shared.userData!.userId,
    //   sendUserName: Singleton.shared.userData!.user!.name,
    //   message: tecMessage.text,
    //   type: MessageType.text,
    //   chatRoomId: _chatRoomId,
    // );
    tecMessage.text = '';
    // _sendMessageToServer(chatMessage);
  }

  Widget _buildReviewList() {
    return
        // ratings!.length == 0
        //     ? emptyReview()
        //     :
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String reviewTarget = '종팔이';
              return InkWell(
                onTap: () {
                  context.read<PostProvider>().setReviewTarget(reviewTarget);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(reviewTarget, style: DSTextStyles.bold12Black),
                        SizedBox(width: 8),
                        Text('2021-10-24 10:24',
                            style: DSTextStyles.regular10WarmGrey),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '내가 일빠임.',
                      style: DSTextStyles.regular12Black,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: 3);
  }

  Widget emptyReview() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('리뷰 없음'),
        ],
      ),
    );
  }
}
