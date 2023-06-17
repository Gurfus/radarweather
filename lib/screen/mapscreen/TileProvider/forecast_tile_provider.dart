import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ForecastTileProvider implements TileProvider {
  final List timeStamps;
  int tileSize = 1;

  ForecastTileProvider({required this.timeStamps});
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    try {
      int ts = timeStamps.last;
      final url =
          "https://tilecache.rainviewer.com/v2/radar/$ts/256/$zoom/$x/$y/2/1_1.png";

      final uri = Uri.parse(url);

      final ByteData imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
    }
    return Tile(256, 256, tileBytes);
  }
}

class TilesCache {
  static Map<String, Uint8List> tiles = {};
}
