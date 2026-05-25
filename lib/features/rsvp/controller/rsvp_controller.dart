// ============================================================
// features/rsvp/controller/rsvp_controller.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/rsvp_model.dart';

class RsvpController extends GetxController {

  // Form field controllers (Flutter text field standard)
  final TextEditingController nameController    = TextEditingController();
  final TextEditingController phoneController   = TextEditingController();

  // Attendance selection: null = not selected, true = yes, false = no
  final Rxn<bool> willAttend = Rxn<bool>();

  // Tracks submission state
  final RxBool isSubmitting = false.obs;
  final RxBool isSubmitted  = false.obs;

  // Error messages
  final RxString nameError  = ''.obs;
  final RxString phoneError = ''.obs;
  final RxString attendError = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // ── SET ATTENDANCE ────────────────────────────────────
  void setAttendance(bool value) {
    willAttend.value = value;
    attendError.value = '';
  }

  // ── VALIDATE & SUBMIT ─────────────────────────────────
  void submitRsvp() async {
    // Clear previous errors
    nameError.value  = '';
    phoneError.value = '';
    attendError.value = '';

    // Validation
    bool valid = true;

    if (nameController.text.trim().isEmpty) {
      nameError.value = 'Please enter your name';
      valid = false;
    }

    if (phoneController.text.trim().isEmpty) {
      phoneError.value = 'Please enter your phone number';
      valid = false;
    } else if (phoneController.text.trim().length < 10) {
      phoneError.value = 'Enter a valid phone number';
      valid = false;
    }

    if (willAttend.value == null) {
      attendError.value = 'Please select your attendance';
      valid = false;
    }

    if (!valid) return;

    // Simulate network request (replace with actual API call)
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isSubmitting.value = false;

    // Build the model
    final rsvp = RsvpModel(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      willAttend: willAttend.value!,
    );

    // TODO: Send rsvp.toMap() to Firebase/API
    debugPrint('RSVP submitted: $rsvp');

    isSubmitted.value = true;
  }
}