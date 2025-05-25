import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otp_verifkasi_controller.dart';

class OtpVerifkasiView extends GetView<OtpVerifkasiController> {
  const OtpVerifkasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtpVerifkasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OtpVerifkasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
