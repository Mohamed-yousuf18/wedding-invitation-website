// ============================================================
// features/rsvp/view/rsvp_screen.dart
// ============================================================

import 'package:my_wedding_app/app/theme/app_theme.dart';
import 'package:my_wedding_app/features/rsvp/controller/rsvp_controller.dart';
import 'package:my_wedding_app/widgets/gold_button.dart';
import 'package:my_wedding_app/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';


class RsvpScreen extends StatefulWidget {
  const RsvpScreen({super.key});

  @override
  State<RsvpScreen> createState() => _RsvpScreenState();
}

class _RsvpScreenState extends State<RsvpScreen> {
  late final RsvpController controller;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<RsvpController>();
    _confettiController = ConfettiController(
        duration: const Duration(seconds: 5));

    // When form is submitted successfully → play confetti
    ever(controller.isSubmitted, (bool submitted) {
      if (submitted) _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.bgMid, AppColors.bgDark],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Back button
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: AppColors.gold, size: 18),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),

                  const SectionHeader(
                    label: 'Kindly Reply By Nov 30',
                    title: 'RSVP',
                  ),
                  const SizedBox(height: 32),

                  // Toggle between form and success
                  Obx(() => controller.isSubmitted.value
                      ? _buildSuccessView()
                      : _buildForm()),
                ],
              ),
            ),
          ),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 40,
              colors: const [
                AppColors.gold, AppColors.rose,
                AppColors.goldLight, Colors.white,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── FORM ─────────────────────────────────────────────────
  Widget _buildForm() {
    return Column(
      children: [
        // Name field
        Obx(() => _inputField(
          controller: controller.nameController,
          label: 'YOUR NAME',
          hint: 'Enter your full name',
          icon: Icons.person_outline,
          error: controller.nameError.value,
        )),
        const SizedBox(height: 16),

        // Phone field
        Obx(() => _inputField(
          controller: controller.phoneController,
          label: 'PHONE NUMBER',
          hint: 'Your contact number',
          icon: Icons.phone_outlined,
          error: controller.phoneError.value,
          keyboardType: TextInputType.phone,
        )),
        const SizedBox(height: 24),

        // Attendance toggle
        _buildAttendanceSelector(),
        const SizedBox(height: 32),

        // Submit button
        Obx(() => controller.isSubmitting.value
            ? const CircularProgressIndicator(color: AppColors.gold)
            : GoldButton(
          label: 'Send My Response  ✦',
          onPressed: controller.submitRsvp,
        )),
      ],
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String error,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: GoogleFonts.lato(
              color: AppColors.textLight, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,
                color: AppColors.gold.withValues(alpha:0.5), size: 18),
            errorText: error.isEmpty ? null : error,
            errorStyle: GoogleFonts.lato(
                color: AppColors.roseDeep, fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WILL YOU ATTEND?', style: AppTextStyles.label),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Obx(() => _attendanceOption(
                emoji: '🎊',
                label: 'Joyfully Accept',
                selected: controller.willAttend.value == true,
                onTap: () => controller.setAttendance(true),
              )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Obx(() => _attendanceOption(
                emoji: '💌',
                label: 'Regretfully Decline',
                selected: controller.willAttend.value == false,
                onTap: () => controller.setAttendance(false),
              )),
            ),
          ],
        ),
        Obx(() => controller.attendError.value.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            controller.attendError.value,
            style: GoogleFonts.lato(
                color: AppColors.roseDeep, fontSize: 11),
          ),
        )
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _attendanceOption({
    required String emoji,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppColors.gold
                : AppColors.gold.withValues(alpha:0.2),
            width: selected ? 1.5 : 1,
          ),
          color: selected
              ? AppColors.gold.withValues(alpha:0.1)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: selected ? AppColors.gold : AppColors.textMuted,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── SUCCESS VIEW ──────────────────────────────────────────
  Widget _buildSuccessView() {
    final attending = Get.find<RsvpController>().willAttend.value == true;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          attending ? '🌸' : '💌',
          style: const TextStyle(fontSize: 64),
        ),
        const SizedBox(height: 24),
        Text(
          attending ? 'We\'re overjoyed!' : 'You will be missed',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          attending
              ? 'Thank you! We can\'t wait to celebrate with you on December 14th. '
              'See you at The Leela Palace! 🥂'
              : 'Thank you for letting us know. Your love and blessings mean '
              'the world to us, even from afar. 💕',
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 17,
            fontStyle: FontStyle.italic,
            color: AppColors.rose.withValues(alpha:0.85),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 40),
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Back to Invitation',
            style: GoogleFonts.cinzel(
              fontSize: 12,
              color: AppColors.gold,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}