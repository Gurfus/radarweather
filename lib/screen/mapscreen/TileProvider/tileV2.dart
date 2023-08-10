import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TileV2 implements TileProvider {
  List<dynamic> timeStamps = [];
  int tsId;
  Map<String, Uint8List> tiles = {};

  TileV2({required this.timeStamps, required this.tsId});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final tileKey = "$tsId-$zoom-$x-$y";
    if (tiles.containsKey(tileKey)) {
      // Si el tile está en caché, se recupera directamente
      return Tile(256, 256, tiles[tileKey]!);
    } else {
      try {
        final url =
            "https://tilecache.rainviewer.com/v2/radar/$tsId/256/$zoom/$x/$y/2/1_1.png";
        final uri = Uri.parse(url);
        final ByteData imageData = await NetworkAssetBundle(uri).load("");
        final tileBytes = imageData.buffer.asUint8List();

        // Guarda el tile en el caché
        tiles[tileKey] = tileBytes;
        return Tile(256, 256, tileBytes);
      } catch (e) {
        print(e.toString());
        return Tile(256, 256, Uint8List(0)); // Tile vacío en caso de error
      }
    }
  }
}

class TilesCache {
  static Map<String, Map<String, Uint8List>> tilesByZoom = {};

  static Future<void> preCacheTiles(
      TileV2 tileProvider, int zoom, int preloadTiles) async {
    int currentIndex = 0;
    final List<int> tiles =
        List.generate(preloadTiles, (index) => index - preloadTiles ~/ 2);
    final cache = tilesByZoom[zoom.toString()] ?? {};

    for (int x in tiles) {
      for (int y in tiles) {
        final tile = await tileProvider.getTile(x, y, zoom);
        final tileKey = "${tileProvider.timeStamps[currentIndex]}-$zoom-$x-$y";
        cache[tileKey] = tile.data!;
        if (currentIndex < tileProvider.timeStamps.length - 1) {
          currentIndex++;
        }
        print(tileKey);
      }
    }

    tilesByZoom[zoom.toString()] = cache;
  }

  static void clearCache() {
    tilesByZoom.clear();
  }

  static Map<String, Uint8List> getCacheForZoom(int zoom) {
    return tilesByZoom[zoom.toString()] ?? {};
  }

  static void setCacheForZoom(int zoom, Map<String, Uint8List> cache) {
    tilesByZoom[zoom.toString()] = cache;
  }
}
