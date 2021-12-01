import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DSPhotoViewer extends StatefulWidget {
  const DSPhotoViewer({Key? key, String? filePath})
      : _filePath = filePath,
        super(key: key);

  final String? _filePath;

  @override
  _DSPhotoViewerState createState() => _DSPhotoViewerState();
}

class _DSPhotoViewerState extends State<DSPhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget._filePath!),
        ),
      ),
    );
  }
}
