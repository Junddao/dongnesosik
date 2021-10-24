import 'package:dongnesosik/global/dummy_data.dart';
import 'package:dongnesosik/global/model/pin/response_get_pin.dart';
import 'package:dongnesosik/global/provider/location_provider.dart';
import 'package:flutter/material.dart';
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
      title: Text(responseGetPinData[index].pin!.title!),
      subtitle: Text(responseGetPinData[index].pin!.body!),
      onTap: () {
        context.read<LocationProvider>().selectedPinData =
            responseGetPinData[index];
        Navigator.of(context).pushNamed('PagePostDetail');
      },
    );
  }
}
