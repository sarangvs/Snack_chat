import 'package:chat_app/presentation/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  LatLng? currentLatLng;

  @override
  void initState() {
    super.initState();

    /// 🔄 Delay access to context until it's mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Geolocator.getPositionStream().listen((position) {
        context.read<MapBloc>().add(UpdateLocationEvent(position));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MapLoaded) {
            final position = state.position;
            currentLatLng = LatLng(position.latitude, position.longitude);

            return GoogleMap(
              buildingsEnabled: true,
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                target: currentLatLng!,
                zoom: 17,
              ),

              myLocationEnabled: true,
              polygons: {_createRectangle(currentLatLng!)},
              markers:
                  state.waterBodies.map((latLng) {
                    return Marker(
                      markerId: MarkerId(latLng.toString()),
                      position: latLng,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                      infoWindow: const InfoWindow(title: "Pond / Lake"),
                    );
                  }).toSet(),
            );
          } else if (state is MapError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Polygon _createRectangle(LatLng center) {
    const offset = 0.009; // Approx 1km
    return Polygon(
      polygonId: const PolygonId('2km-rect'),
      points: [
        LatLng(center.latitude - offset, center.longitude - offset),
        LatLng(center.latitude - offset, center.longitude + offset),
        LatLng(center.latitude + offset, center.longitude + offset),
        LatLng(center.latitude + offset, center.longitude - offset),
      ],
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: Colors.blue.withOpacity(0.2),
    );
  }
}
