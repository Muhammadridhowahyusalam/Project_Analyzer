import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_screen_controller.dart';

class OtpScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verifikasi OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Masukkan kode OTP yang dikirim ke nomor Anda'),
            SizedBox(height: 20),
            TextField(
              controller: controller.otpTextController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan 6 digit kode',
                counterText: "",
              ),
              onChanged: controller.onOtpChanged,
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: controller.verifyOtp,
              child: Text('Verifikasi'),
            )),
          ],
        ),
      ),
    );
  }
}