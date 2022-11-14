import 'dart:convert';

class LocationServices {
  final MINLAT = 8.06666667; // south
  final MINLNG = 68.11666667; // west
  final MAXLAT = 37.1; // north
  final MAXLNG = 97.41666667; // east

  List<int> gridIndex(lat, lng) {
    List<int> res = [];
    var N = (MAXLAT - MINLAT) * 111.32;
    var M = (MAXLNG - MINLNG) * 111.32;

    var unitCell = 0.01;

    double iValue = (lat - MINLAT) / unitCell;
    double jValue = (lng - MINLNG) / unitCell;

    res.add(iValue.toInt());
    res.add(jValue.toInt());

    return res;
  }
}
