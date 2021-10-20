import 'package:dongnesosik/global/model/pin/response_get_pin.dart';
import 'package:dongnesosik/global/provider/maps/location_provider.dart';
import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CellPostHeader extends StatelessWidget {
  const CellPostHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildPostHeader(context),
        ],
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    ResponseGetPinData selectedGetPinData =
        context.watch<LocationProvider>().selectedPinData!;
    return InkWell(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                selectedGetPinData.pin!.title ?? "",
                style: DSTextStyle.bold16Black,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                selectedGetPinData.pin!.body ?? "",
                style: DSTextStyle.regular12Black,
              ),

              // ),
            ],
          ),
        ],
      ),
    );
  }
}
