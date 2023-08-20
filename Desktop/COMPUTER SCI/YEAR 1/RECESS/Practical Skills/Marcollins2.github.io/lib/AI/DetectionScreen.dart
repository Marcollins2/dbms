import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'Camera.dart';
import 'Bndbox.dart';
import 'Models.dart';

class DetectionScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  DetectionScreen(this.cameras);

  @override
  _DetectionScreenState createState() => new _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  var bodyHeight = "0.0";
  var waistSize = "0.0";
  var shoulderSize = "0.0";

  @override
  void initState() {
    super.initState();
    onSelect(posenet);
  }

  loadModel() async {
    String posenet = (await Tflite.loadModel(
        model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite"))!;
    print(posenet);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    // Set state is still being called after dispose
    // fix this bug.
    try {
      setState(() {
        _recognitions = recognitions;
        _imageHeight = imageHeight;
        _imageWidth = imageWidth;
      });
    } catch (e) {
      print(e);
    }
    computeBodySize(_recognitions);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
            _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            _model,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Height: $bodyHeight",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Waist: $waistSize",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Shoulder: $shoulderSize",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Material(
                        color: Colors.black,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            confirmBodySize();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: const Text(
                            'Confirm Body Size',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confirmBodySize() {
  
    bodyHeight = (double.parse(bodyHeight) * 100 + 100).toString();
    waistSize = (double.parse(waistSize) * 100).toString();
    shoulderSize = (double.parse(shoulderSize) * 100).toString();

    print("Confirm Body Size");
    print("Height: $bodyHeight");
    print("Waist: $waistSize");
    print("Shoulder: $shoulderSize");
    Get.back(result: {
      "height": "$bodyHeight",
      "waist": "$waistSize",
      "shoulder": "$shoulderSize",
    });
  }

  void computeBodySize(List<dynamic> recognitions) {
    print("KeyPoints");
    if (recognitions.isNotEmpty) {
      var first = recognitions[0];
      var nose = first["keypoints"][0];
      // var leftEye = first["keypoints"][1];
      // var rightEye = first["keypoints"][2];
      // var leftEar = first["keypoints"][3];
      // var rightEar = first["keypoints"][4];
      var leftShoulder = first["keypoints"][5];
      var rightShoulder = first["keypoints"][6];
      // var leftElbow = first["keypoints"][7];
      // var rightElbow = first["keypoints"][8];
      // var leftWrist = first["keypoints"][9];
      // var rightWrist = first["keypoints"][10];
      var leftHip = first["keypoints"][11];
      var rightHip = first["keypoints"][12];
      // var leftKnee = first["keypoints"][13];
      // var rightKnee = first["keypoints"][14];
      var leftAnkle = first["keypoints"][15];
      // var rightAnkle = first["keypoints"][16];

      var bodyHeightt = computeDistanceBetweenTwoCoordinatesOnA2Dplane(
        x1: nose['x'],
        x2: leftAnkle['x'],
        y1: nose['y'],
        y2: leftAnkle['y'],
      );

      var waistSizee = computeDistanceBetweenTwoCoordinatesOnA2Dplane(
        x1: rightHip['x'],
        x2: leftHip['x'],
        y1: rightHip['y'],
        y2: leftHip['y'],
      );

      var shoulderSizee = computeDistanceBetweenTwoCoordinatesOnA2Dplane(
        x1: rightShoulder['x'],
        x2: leftShoulder['x'],
        y1: rightShoulder['y'],
        y2: leftShoulder['y'],
      );
      var f = NumberFormat("###.###", "en_US");
      setState(() {
        bodyHeight = f.format(bodyHeightt);
        waistSize = f.format(waistSizee);
        shoulderSize = f.format(shoulderSizee);
      });

      print("Body Height: $bodyHeight");
      print("Waist Size: $waistSize");
      print("Shoulder Size: $shoulderSize");
      print("Done");
      setState(() {});
    }
  }

  /// Formula to compute the distance between two coordinates on a 2D plane
  /// https://www.mathsisfun.com/algebra/distance-2-points.html
  /// https://byjus.com/maths/distance-between-two-points-formula/
  computeDistanceBetweenTwoCoordinatesOnA2Dplane({x1, x2, y1, y2}) {
    var distance = math.sqrt(math.pow((x2 - x1), 2) + math.pow((y2 - y1), 2));
    return distance;
  }
}
