import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import '../locator.dart';
import '../services/camera_service.dart';
import 'digital_consensus.dart';

class InterceptorPage extends StatelessWidget {
  final CameraService cameraService = locator<CameraService>();

  final SharedPreferences _prefs;

  InterceptorPage(this._prefs);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<CameraDescription?>(
      future: cameraService.getFrontCameraDescription(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          CameraDescription? frontCamera = snapshot.data;
          if (frontCamera != null) {
            return DigitalConsensus(this._prefs, camera: frontCamera);
          }
           Future.delayed(Duration(milliseconds: 500), () {
              // Trigger a rebuild
              (context as Element).markNeedsBuild();
            });

          return CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
