import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({Key? key}) : super(key: key);

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final Map<String, dynamic> _deviceInfo = {};
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _getDeviceData();
  }

  Future<void> _getDeviceData() async {
    if(Platform.isAndroid) {
      _getAndroidDeviceInfo(await _deviceInfoPlugin.androidInfo);
    } else if(Platform.isIOS) {
      _getIOSDeviceInfo(await _deviceInfoPlugin.iosInfo);
    }
  }

  Future<void> _getAndroidDeviceInfo(AndroidDeviceInfo androidDeviceInfo) async {
    Map<String, String> deviceInfo = {};
    deviceInfo.addAll({
      'device_id': androidDeviceInfo.id,
      "device_name": androidDeviceInfo.model,
      "device_token": "Hello FCM",
      "device_type": "ios",
    });

    setState(() {
      _deviceInfo.addAll(deviceInfo);
    });
  }

  Future<void> _getIOSDeviceInfo(IosDeviceInfo iosDeviceInfo) async {
    Map<String, String> deviceInfo = {};
    deviceInfo.addAll({
      "device_id": iosDeviceInfo.identifierForVendor ?? '',
      "device_name": iosDeviceInfo.name ?? "",
      "device_token": "Hello FCM",
      "device_type": "ios",
    });

    setState(() {
      _deviceInfo.addAll(deviceInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Info Plus"),
      ),
      body: Center(
        child: Text(_deviceInfo.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black)
        ),
      ),
    );
  }
}
