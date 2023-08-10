import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/screen/mapscreen/TileProvider/forecast_tile_provider.dart';

class Radarv2 extends StatefulWidget {
  const Radarv2({Key? key}) : super(key: key);

  @override
  State<Radarv2> createState() => Radarv2State();
}

class Radarv2State extends State<Radarv2> with SingleTickerProviderStateMixin {
  WeatherProvider? weatherProvider;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _kGooglePlex;
  List<dynamic> radarImageUrls = [];

  Timer? playbackTimer;
  int currentIndex = 0;
  Duration playbackInterval = const Duration(seconds: 1);
  int timeStampsDate = DateTime.now().hour;
  List<TileOverlay> tileOverlays = [];
  TileOverlay? currentTileOverlay;
  TileOverlay? nextTileOverlay;

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    weatherProvider = context.read<WeatherProvider>();
    _kGooglePlex = CameraPosition(
      target: LatLng(
        weatherProvider!.getLat().toDouble(),
        weatherProvider!.getLong().toDouble(),
      ),
      //zoom: 8,
    );
    animationController = AnimationController(
      vsync: this,
      duration: playbackInterval,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);
  }

  void load() {
    http
        .get(Uri.parse('https://tilecache.rainviewer.com/api/maps.json'))
        .then((response) {
      if (response.statusCode == 200) {
        final timestamps = jsonDecode(response.body);

        timeStampsDate = timestamps[0];
        setState(() {
          radarImageUrls = timestamps;
        });

        initTiles();
      } else {
        throw Exception('Failed to load timestamps');
      }
    });
  }

  void initTiles() {
    final int currentOverlayId = radarImageUrls[currentIndex];
    if (radarImageUrls.last == radarImageUrls[currentIndex]) {
      currentTileOverlay = TileOverlay(
          tileOverlayId: TileOverlayId(currentOverlayId.toString()),
          tileProvider: ForecastTileProvider(timeStamps: currentOverlayId),
          zIndex: currentOverlayId,
          tileSize: 256,
          fadeIn: false);
    } else {
      final int nextOverlayId =
          radarImageUrls[(currentIndex + 1) % radarImageUrls.length];

      currentTileOverlay = TileOverlay(
          tileOverlayId: TileOverlayId(currentOverlayId.toString()),
          tileProvider: ForecastTileProvider(timeStamps: currentOverlayId),
          zIndex: currentOverlayId,
          tileSize: 256,
          fadeIn: false);

      nextTileOverlay = TileOverlay(
          tileOverlayId: TileOverlayId(nextOverlayId.toString()),
          tileProvider: ForecastTileProvider(timeStamps: nextOverlayId),
          zIndex: nextOverlayId,
          tileSize: 256,
          fadeIn: false);
    }

    setState(() {
      tileOverlays = [currentTileOverlay!];
    });
  }

  Future<void> startPlayback() async {
    currentIndex = 0;

    playbackTimer?.cancel();
    // Precargar algunos tiles antes de iniciar la animación

    playbackTimer = Timer.periodic(playbackInterval, (timer) {
      if (currentIndex < radarImageUrls.length - 1) {
        loadAndShowImage();
        currentIndex++;
      } else {
        stopPlayback();
      }
    });

    animationController?.reset();
    animationController?.forward();
  }

  void stopPlayback() {
    playbackTimer?.cancel();
    playbackTimer = null;
    animationController?.stop();
  }

  Future<void> loadAndShowImage() async {
    if (currentIndex >= 0 && currentIndex < radarImageUrls.length) {
      timeStampsDate = radarImageUrls[currentIndex];
      setState(() {
        tileOverlays.add(nextTileOverlay!);
      });

      await Future.delayed(const Duration(milliseconds: 50));

      setState(() {
        tileOverlays.remove(currentTileOverlay!);
      });

      initTiles();
    }
  }

  @override
  void dispose() {
    playbackTimer?.cancel();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 26, 64),
            Color.fromARGB(255, 24, 143, 248)
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.terrain,
              trafficEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex!,
              minMaxZoomPreference: const MinMaxZoomPreference(8, 8),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                load();
              },
              tileOverlays: Set<TileOverlay>.from(tileOverlays),
            ),
            AnimatedBuilder(
              animation: animation!,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.5,
                  child: child!,
                );
              },
              child: Container(
                  // Contenido de la animación
                  ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Text(getTime(timeStampsDate)))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            if (playbackTimer == null) {
              startPlayback();
            } else {
              stopPlayback();
            }
          },
          child: Icon(playbackTimer == null ? Icons.play_arrow : Icons.stop),
        ),
      ),
    );
  }

  String getTime(final timeStamp) {
    String formattedTime;

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    formattedTime = DateFormat('MMMMd').add_Hm().format(dateTime);

    return formattedTime;
  }
}
