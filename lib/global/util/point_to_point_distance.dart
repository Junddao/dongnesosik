import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

class PointToPointDistance {
  static int ptopDistnace(map.LatLng p1, map.LatLng p2) {
    final Distance distance = new Distance();

    // km = 423
    final double km = distance.as(
      LengthUnit.Kilometer,
      new LatLng(p1.latitude, p1.longitude),
      new LatLng(p2.latitude, p2.longitude),
    );
    return km.toInt();
  }
}
