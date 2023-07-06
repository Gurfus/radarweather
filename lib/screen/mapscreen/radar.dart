// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'TileProvider/forecast_tile_provider.dart';

// class Radar extends StatefulWidget {
//   const Radar({super.key});

//   @override
//   State<Radar> createState() => RadarState();
// }

// class RadarState extends State<Radar> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(42.1995, 2.1908),
//     zoom: 8,
//   );

//   void load() {
//     http
//         .get(Uri.parse('https://tilecache.rainviewer.com/api/maps.json'))
//         .then((response) {
//       if (response.statusCode == 200) {
//         final timestamps = jsonDecode(response.body);
//         print(timestamps);
//         initTiles(timestamps);
//       } else {
//         throw Exception('Failed to load timestamps');
//       }
//     });
//   }

//   TileOverlay? tileOverlay;
//   Set<TileOverlay> _tileOverLays = {};
//   initTiles(List ts) async {
//     final String overlayId = ts[1].toString();

//     final TileOverlay tileOverlay = TileOverlay(
//       tileOverlayId: TileOverlayId(overlayId),
//       tileProvider: ForecastTileProvider(timeStamps: ts),
//       zIndex: 1,
//     );
//     setState(() {
//       _tileOverLays = {tileOverlay};
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//           load();
//         },
//         tileOverlays: _tileOverLays,
//       ),
//     );
//   }
// }
