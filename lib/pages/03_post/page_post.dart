import 'package:dongnesosik/global/dummy_data.dart';
import 'package:flutter/material.dart';

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
    return Container(
      child: SingleChildScrollView(
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _listItem(index);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: DummyData().responsePostModel.data!.length),
      ),
    );
  }

  Widget _listItem(int index) {
    return ListTile(
      title: Text(DummyData().responsePostModel.data![index].title!),
      subtitle: Text(DummyData().responsePostModel.data![index].contents!),
    );
  }
}
