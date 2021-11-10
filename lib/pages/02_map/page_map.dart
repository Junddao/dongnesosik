import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:dongnesosik/global/model/model_shared_preferences.dart';
import 'package:dongnesosik/global/model/pin/model_request_create_pin_reply.dart';
import 'package:dongnesosik/global/model/pin/model_response_get_pin.dart';
import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_user_info.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/global/util/range_by_zoom.dart';
import 'package:dongnesosik/pages/03_post/page_post.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:dongnesosik/pages/components/ds_photo_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PageMap extends StatefulWidget {
  const PageMap({Key? key, this.pinId}) : super(key: key);

  final int? pinId;

  @override
  _PageMapState createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Marker> _markers = [];
  List<Marker> _temporaryMaker = [];
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();

  BitmapDescriptor? customIcon;
  Timer? _timer;
  int? range = 1000;

  List<String> imageUrls = [test_image_url, test_image_url, test_image_url];
  TextEditingController _tecMessage = TextEditingController();
  final PanelController panelController = new PanelController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // panelController.hide(); //초기에 slideUpPanel 숨기고 시작
    // setCustomMarker();
    Future.microtask(() async {
      await getLocation();
      Future.delayed(Duration(milliseconds: 500), () {
        if (widget.pinId != null) {
          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   builder: (context) {
          //     return Padding(
          //       padding: EdgeInsets.only(
          //           bottom: MediaQuery.of(context).viewInsets.bottom),
          //       child: buildBottomSheet(context, widget.pinId!),
          //     );
          //   },
          // );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void setCustomMarker() async {
    // id에 맞게 설정해줘야함...
    customIcon = await createCustomMarkerBitmap('aaaaaaaaaa'.substring(0, 5));
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(String title) async {
    TextSpan span = new TextSpan(
      style: DSTextStyles.bold16Black,
      text: title,
    );

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.text = TextSpan(text: title, style: DSTextStyles.bold40black);

    var myPaint = Paint();
    myPaint.color = DSColors.white;
    PictureRecorder recorder = new PictureRecorder();
    Canvas c = new Canvas(recorder);

    c.drawRRect(RRect.fromRectAndRadius(Rect.largest, Radius.zero), myPaint);

    tp.layout();
    tp.paint(c, new Offset(20.0, 10.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Picture p = recorder.endRecording();
    ByteData? pngBytes =
        await (await p.toImage(tp.width.toInt() + 40, tp.height.toInt() + 20))
            .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  }

  Future<void> getLocation() async {
    if (context.read<LocationProvider>().lastLocation != null) {
      moveCameraToLastLocation();
      return;
    }
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

  void moveCameraToLastLocation() {
    var provider = context.read<LocationProvider>();
    _controller.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(provider.lastLocation!.latitude,
              provider.lastLocation!.longitude),
          zoom: 15,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: _appBar(),
          body: _body(),
          drawer: _drawer(),
          extendBodyBehindAppBar: true,
          drawerEnableOpenDragGesture: true,
          resizeToAvoidBottomInset: false
          // resizeToAvoidBottomInset: false,

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

  Future<bool> _onWillPop() async {
    if (panelController.isPanelOpen) {
      panelController.close();
      return false;
    } else {
      return true;
    }
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
            context.read<LocationProvider>().setMyPostLocation(null);
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
              Navigator.of(context).pushNamed('PageMyPost');
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
          SingletonUser.singletonUser.userData.email == null ||
                  SingletonUser.singletonUser.userData.email!.isEmpty
              ? ListTile(
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
                )
              : SizedBox.shrink(),

          ListTile(
            leading: Icon(Ionicons.log_out_outline),
            title: Text(
              '로그아웃',
              style: DSTextStyles.bold14Black,
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              SingletonUser.singletonUser.userData = ModelUserInfo();
              ModelSharedPreferences.removeToken();

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('PageSplash', (route) => false);
            },
          ),
        ],
      ),
    );
    // Disable opening the drawer with a swipe gesture.
  }

  Widget _body() {
    return Consumer(builder: (_, LocationProvider value, child) {
      if (value.lastLocation == null || value.responseGetPinDatas == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        LatLng _lastLocation = value.lastLocation!;

        return SafeArea(
          top: false,
          child: SlidingUpPanel(
            controller: panelController,
            backdropEnabled: true,
            minHeight: kDefaultCollapseHeight,
            maxHeight: SizeConfig.screenHeight * 0.8,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            // renderPanelSheet: false,
            collapsed: _floatingCollapsed(),
            panel: _floatingPanel(),
            onPanelClosed: () {
              FocusScope.of(context).unfocus();
            },

            body: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) async {
                    await _onMapCreated(controller, _lastLocation);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _lastLocation,
                    zoom: 15,
                  ),
                  markers: [..._markers, ..._temporaryMaker].toSet(),
                  rotateGesturesEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,

                  padding: EdgeInsets.only(bottom: 130, right: 0),
                  // mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  onCameraMove: _onCameraMove,
                  onCameraIdle: _onCameraIdle,
                  onTap: (point) {
                    _handleTap(point);
                  },
                ),
                // Positioned(
                //   bottom: 30,
                //   left: 24,
                //   child: InkWell(
                //       onTap: () {
                //         Navigator.of(context).pushNamed('PagePost').then((value) {
                //           setState(() {});
                //         });
                //       },
                //       child: _newsInfoWidget()),
                // ),
              ],
            ),
          ),
        );
      }
    });
  }

  Widget _floatingCollapsed() {
    var provider = context.read<LocationProvider>();

    return provider.selectedPinData == null
        ? postSummaryWidget()
        : postContentsBottomSheet(provider.responseGetPinDatas!);
  }

  Widget postSummaryWidget() {
    return _newsInfoWidget();
  }

  Widget _floatingPanel() {
    var provider = context.read<LocationProvider>();

    if (provider.selectedPinData == null) {
      return postListWidget();
    } else {
      return SafeArea(
        bottom: true,
        top: false,
        child: viewPostContents(),
      );
    }
  }

  Widget postListWidget() {
    var responseGetPinData =
        context.watch<LocationProvider>().responseGetPinDatas;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          buildDragHandle(),
          Container(
              height: 90,
              padding: EdgeInsets.all(kDefaultPadding),
              child: Center(
                  child: Text('동내 게시글', style: DSTextStyles.bold18Black))),
          Divider(),
          ListView.separated(
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
        ],
      ),
    );
  }

  Widget _listItem(int index, List<ResponseGetPinData> responseGetPinData) {
    return InkWell(
      onTap: () {
        context.read<LocationProvider>().selectedPinData =
            responseGetPinData[index];
        LatLng location = LatLng(responseGetPinData[index].pin!.lat!,
            responseGetPinData[index].pin!.lng!);
        context.read<LocationProvider>().setLastLocation(location);
        setState(() {
          moveCameraToLastLocation();
        });
        // panelController.close();
      },
      child: ListTile(
        leading: responseGetPinData[index].pin!.images == null ||
                responseGetPinData[index].pin!.images!.isEmpty
            ? SvgPicture.asset(
                'assets/images/void.svg',
                height: 40,
                width: 40,
              )
            : CachedNetworkImage(
                imageUrl: responseGetPinData[index].pin!.images!.first,
                width: 40,
                height: 40,
                errorWidget: (_, __, ___) {
                  return SvgPicture.asset(
                    'assets/images/void.svg',
                    height: 40,
                    width: 40,
                  );
                },
              ),
        title: Text(responseGetPinData[index].pin!.title!),
        subtitle: Text(responseGetPinData[index].pin!.body!),

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
      ),
    );
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
              title: Text(SingletonUser.singletonUser.userData.name!,
                  style: DSTextStyles.bold16Black),
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

  Future<void> _onMapCreated(
      GoogleMapController controller, LatLng location) async {
    _markers.clear();
    var provider = context.read<LocationProvider>();

    print('onMapCreate');
    print(location.toString());

    _controller.complete(controller);
    provider.getAddress(location);
  }

  void _onCameraIdle() async {
    _markers.clear();

    var provider = context.read<LocationProvider>();

    await provider.getPinInRagne(provider.lastLocation!.latitude,
        provider.lastLocation!.longitude, range);
    provider.responseGetPinDatas!.forEach((element) async {
      customIcon = await createCustomMarkerBitmap(element.pin!.title!);
      addCustomMarker(element.pin!.id!,
          LatLng(element.pin!.lat!, element.pin!.lng!), element);
    });
    if (provider.selectedPinData == null) {
      return;
    }
    LatLng selectedLocation = LatLng(provider.selectedPinData!.pin!.lat!,
        provider.selectedPinData!.pin!.lng!);
    if (selectedLocation != provider.lastLocation) {
      provider.selectedPinData = null;
    }

    print("Idle");
  }

  void _onCameraMove(CameraPosition position) {
    var provider = context.read<LocationProvider>();

    provider.setLastLocation(position.target);
    print("move");
    print(position.zoom.toString());
    range = RangeByZoom.getRangeByZooom(position.zoom);
  }

  void addCustomMarker(int id, LatLng latLng, ResponseGetPinData? data) async {
    final marker = Marker(
      markerId: MarkerId(id.toString()),
      position: latLng,
      icon: customIcon!,
      onTap: () async {
        print('marker onTap()');
        var responseGetPinDatas = context
            .read<LocationProvider>()
            .responseGetPinDatas!
            .where((element) {
          return element.pin!.id == id;
        }).toList();
        context.read<LocationProvider>().selectedPinData =
            responseGetPinDatas.first;
        context.read<LocationProvider>().getPinReply(id);
        panelController.open();
      },
    );
    _markers.add(marker);
    setState(() {});
  }

  void addMarker(int id, LatLng latLng) async {
    final marker = Marker(
        markerId: MarkerId(id.toString()),
        position: latLng,
        onTap: () async {
          print('marker onTap()');
          context.read<LocationProvider>().getPinReply(id);

          // context.read<LocationProvider>().setSelectedId(id);

          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   builder: (context) {
          //     return Padding(
          //       padding: EdgeInsets.only(
          //           bottom: MediaQuery.of(context).viewInsets.bottom),
          //       child: buildBottomSheet(context, id),
          //     );
          //   },
          // );
        });
    _markers.add(marker);
  }

  _handleTap(LatLng point) {
    var provider = context.read<LocationProvider>();

    print('handelTap');
    provider.setMyPostLocation(point);
    provider.getAddress(point);

    _temporaryMaker.clear();
    addTemporaryMarker(0, point);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return buildSelectLocationBottomSheet(context);
      },
    ).then((value) {
      if (value != true) {
        // 취소하면 postLocation 초기화 필요.
        context.read<LocationProvider>().setMyPostLocation(null);
      }
      _temporaryMaker.clear();
    });
  }

  Widget buildSelectLocationBottomSheet(BuildContext context) {
    var provider = context.watch<LocationProvider>();
    // String? address = provider.placemarks[0].name!;
    String? address = provider.placemarks[0].locality! +
        " " +
        provider.placemarks[0].subLocality! +
        " " +
        provider.placemarks[0].thoroughfare! +
        " " +
        provider.placemarks[0].subThoroughfare!;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: DSColors.white),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(address, style: DSTextStyles.bold14Black),
            SizedBox(
              height: 10,
            ),
            Divider(),
            DSButton(
              text: '여기에 새글을 쓰겠어요!',
              width: SizeConfig.screenWidth,
              press: () {
                Navigator.of(context)
                    .popAndPushNamed('PagePostCreate', result: true);
              },
            ),
            DSButton(
              text: '다음에 쓸께요.',
              width: SizeConfig.screenWidth,
              type: ButtonType.transparent,
              press: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void addTemporaryMarker(int id, LatLng latLng) {
    final marker = Marker(
      markerId: MarkerId(id.toString()),
      position: latLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      // icon: customIcon!,
    );
    _temporaryMaker.add(marker);
  }

  Widget _newsInfoWidget() {
    var provider = context.read<LocationProvider>();

    return provider.responseGetPinDatas!.length == 0
        ? Container(
            decoration: BoxDecoration(
              color: DSColors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [Text('주변에 글이 없어요. 첫 글을 작성해보세요. 😀')],
            ),
          )
        : InkWell(
            onTap: () {
              panelController.open();
            },
            child: Container(
              decoration: BoxDecoration(
                color: DSColors.white,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultHorizontalPadding, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: ' ${provider.responseGetPinDatas!.length}개',
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

  Widget postContentsBottomSheet(List<ResponseGetPinData> responseGetPinDatas) {
    return Consumer<LocationProvider>(builder: (_, data, __) {
      if (data.state == ViewState.Busy) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return InkWell(
        onTap: () {
          panelController.open();
        },
        child: Container(
          height: kDefaultCollapseHeight,
          decoration: BoxDecoration(
            color: DSColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultHorizontalPadding,
                vertical: kDefaultVerticalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: data.selectedPinData!.pin!.images == null ||
                            data.selectedPinData!.pin!.images!.isEmpty
                        ? SvgPicture.asset(
                            'assets/images/void.svg',
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: data.selectedPinData!.pin!.images!.first,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) {
                              return SvgPicture.asset(
                                'assets/images/void.svg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data.selectedPinData!.pin!.title!,
                        style: DSTextStyles.bold18Black),
                    SizedBox(height: 10),
                    Text(
                      data.selectedPinData!.pin!.body!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget viewPostContents() {
    return Consumer<LocationProvider>(builder: (_, data, __) {
      if (data.state == ViewState.Busy) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: SizeConfig.screenHeight * 0.8,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                buildDragHandle(),
                Container(
                  height: 90,
                  child: Center(
                    child: Text(data.selectedPinData!.pin!.title!,
                        style: DSTextStyles.bold18Black),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    // reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: DSPhotoView(
                                iamgeUrls:
                                    data.selectedPinData!.pin!.images ?? []),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultHorizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(data.selectedPinData!.pin!.body!),
                              SizedBox(height: 10),
                              Divider(),
                              _buildReviewList(data),
                            ],
                          ),
                        ),

                        // const SizedBox(height: 90),
                      ],
                    ),
                  ),
                ),
                _buildMessageComposer(data),
              ],
            ),
          ),
        ),
      );
    });
  }

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  Widget buildDragHandle() {
    return Center(
      child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: DSColors.warm_grey,
          )),
    );
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
              for (ResponseGetPinData data in provider.responseGetPinDatas!)
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

  Widget _buildMessageComposer(LocationProvider data) {
    return Container(
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
                      controller: _tecMessage,
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
                      createReply();
                      FocusScope.of(context).unfocus();
                      WidgetsBinding.instance!
                          .addPostFrameCallback((_) => _scrollToEnd());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createReply() {
    var provider = context.read<LocationProvider>();
    if (_tecMessage.text.isEmpty) {
      return;
    }

    // 대댓글 처리용
    if (provider.selectedReplyData != null) {}

    ModelRequestCreatePinReply modelRequestCreatePinReply =
        ModelRequestCreatePinReply(
      pinId: provider.selectedPinData!.pin!.id,
      body: _tecMessage.text,
      password: '0000',
    );
    _tecMessage.text = '';
    provider.createReply(modelRequestCreatePinReply).then((value) {
      context
          .read<LocationProvider>()
          .getPinReply(provider.selectedPinData!.pin!.id!);
    });
  }

  Widget _buildReviewList(LocationProvider provider) {
    return provider.responseGetPinReplyData!.length == 0
        ? emptyReview()
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 0),
            itemCount: provider.responseGetPinReplyData!.length,
            itemBuilder: (context, index) {
              var data = provider.responseGetPinReplyData![index];

              return InkWell(
                onTap: () {
                  context.read<LocationProvider>().setReplyTarget(data);
                  _tecMessage.text = '@${data.name} ';
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data.name!, style: DSTextStyles.bold12Black),
                        SizedBox(width: 16),
                        Text(data.createAt ?? '20000',
                            style: DSTextStyles.regular10WarmGrey),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      data.reply!.body!,
                      style: DSTextStyles.regular12Black,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          );
  }

  Widget emptyReview() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('리뷰 없음'),
        ],
      ),
    );
  }
}
