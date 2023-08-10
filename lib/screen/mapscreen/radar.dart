// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:radarweather/provider/weather_provider.dart';

// import 'TileProvider/forecast_tile_provider.dart';

// class Radar extends StatefulWidget {
//   const Radar({Key? key}) : super(key: key);

//   @override
//   State<Radar> createState() => RadarState();
// }

// class RadarState extends State<Radar> with SingleTickerProviderStateMixin {
//   WeatherProvider? weatherProvider;
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   CameraPosition? _kGooglePlex;
//   TileOverlay? newTileOverlay;
//   TileOverlay? tileOverlay;
//   List<dynamic> radarImageUrls = [];
//   int timeStampsDate = 0;
//   Timer? playbackTimer;
//   int currentIndex = 0;
//   Duration playbackInterval = const Duration(milliseconds: 1500);

//   List<TileOverlay> tileOverlays = [];

//   AnimationController? animationController;
//   Animation<double>? animation;

//   @override
//   void initState() {
//     super.initState();
//     weatherProvider = context.read<WeatherProvider>();
//     _kGooglePlex = CameraPosition(
//       target: LatLng(
//         weatherProvider!.getLat().toDouble(),
//         weatherProvider!.getLong().toDouble(),
//       ),
//       zoom: 8,
//     );
//     animationController = AnimationController(
//       vsync: this,
//       duration: playbackInterval,
//     );
//     animation = Tween<double>(begin: 0, end: 1).animate(animationController!);
//   }

//   void load() {
//     http
//         .get(Uri.parse('https://tilecache.rainviewer.com/api/maps.json'))
//         .then((response) {
//       if (response.statusCode == 200) {
//         final timestamps = jsonDecode(response.body);
//         print(timestamps);
//         setState(() {
//           radarImageUrls = timestamps;

//           timeStampsDate = radarImageUrls[currentIndex];
//         });
//         initTiles();
//       } else {
//         throw Exception('Failed to load timestamps');
//       }
//     });
//   }

//   void initTiles() {
//     final String overlayId = radarImageUrls[currentIndex].toString();
//     print(overlayId);

//     tileOverlay = TileOverlay(
//         tileOverlayId: TileOverlayId(overlayId),
//         tileProvider:
//             ForecastTileProvider(timeStamps: radarImageUrls[currentIndex]),
//         zIndex: 1,
//         transparency: 0.0,
//         fadeIn: false);
//     newTileOverlay = TileOverlay(
//         tileOverlayId: TileOverlayId(overlayId),
//         tileProvider:
//             ForecastTileProvider(timeStamps: radarImageUrls[currentIndex + 1]),
//         zIndex: 10,
//         transparency: 0.0,
//         fadeIn: false);

//     setState(() {
//       tileOverlays = [tileOverlay!!];
//     });
//   }

//   void startPlayback() {
//     currentIndex = 0;

//     playbackTimer?.cancel();

//     playbackTimer = Timer.periodic(playbackInterval, (timer) {
//       loadAndShowImage();

//       currentIndex++;

//       if (currentIndex >= radarImageUrls.length) {
//         stopPlayback();
//       }
//     });

//     animationController?.reset();
//     animationController?.forward();
//   }

//   void stopPlayback() {
//     playbackTimer?.cancel();
//     playbackTimer = null;
//     animationController?.stop();
//   }

//   Future<void> loadAndShowImage() async {
//     if (currentIndex >= 0 && currentIndex < radarImageUrls.length) {
//       timeStampsDate = radarImageUrls[currentIndex];

//       setState(() {
//         tileOverlays.add(newTileOverlay!);
//       });

//       await Future.delayed(const Duration(milliseconds: 200));

//       setState(() {
//         tileOverlays.remove(tileOverlay!);
//       });

//       initTiles();
//     }
//   }

//   @override
//   void dispose() {
//     playbackTimer?.cancel();
//     animationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             mapType: MapType.terrain,
//             trafficEnabled: false,
//             initialCameraPosition: _kGooglePlex!,
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//               load();
//             },
//             tileOverlays: Set<TileOverlay>.from(tileOverlays),
//           ),
//           AnimatedBuilder(
//             animation: animation!,
//             builder: (context, child) {
//               return Opacity(
//                 opacity: animation!.value,
//                 child: child!,
//               );
//             },
//             child: Container(
//                 // Contenido de la animación
//                 ),
//           ),
//           Container(
//               alignment: Alignment.bottomCenter,
//               child: Text('${getTime(timeStampsDate)}'))
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (playbackTimer == null) {
//             startPlayback();
//           } else {
//             stopPlayback();
//           }
//         },
//         child: Icon(playbackTimer == null ? Icons.play_arrow : Icons.stop),
//       ),
//     );
//   }

//   String getTime(final timeStamp) {
//     String formattedTime;

//     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
//     formattedTime = DateFormat('MMMMd').add_Hm().format(dateTime);

//     return formattedTime;
//   }
// }
