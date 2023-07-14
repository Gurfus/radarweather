import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ForecastTileProvider implements TileProvider {
  final int timeStamps;
  int tileSize = 1;

  ForecastTileProvider({required this.timeStamps});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    final tileKey = "$timeStamps-$zoom-$x-$y";

    if (TilesCache.tiles.containsKey(tileKey)) {
      // Si el tile está en caché, se recupera directamente
      tileBytes = TilesCache.tiles[tileKey]!;
    } else {
      try {
        final url =
            "https://tilecache.rainviewer.com/v2/radar/$timeStamps/512/$zoom/$x/$y/2/1_1.png";
        final uri = Uri.parse(url);
        final ByteData imageData = await NetworkAssetBundle(uri).load("");
        tileBytes = imageData.buffer.asUint8List();

        // Guarda el tile en el caché
        TilesCache.tiles[tileKey] = tileBytes;
      } catch (e) {
        print(e.toString());
      }
    }

    return Tile(512, 512, tileBytes);
  }
}

class TilesCache {
  static Map<String, Uint8List> tiles = {};
}
