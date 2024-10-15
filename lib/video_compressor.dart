import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'signup.dart';
import 'reset_pass.dart';
import 'EditProfilePage.dart'; 
class VideoCompressor {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

  Future<void> compressVideo(String inputPath, String outputPath) async {
    String command = '-i $inputPath -vcodec libx264 -crf 28 $outputPath'; // الأمر لضغط الفيديو
    int rc = await _flutterFFmpeg.execute(command);

    if (rc == 0) {
      print("Video compressed successfully!");
    } else {
      print("Error occurred while compressing video: $rc");
    }
  }
}
