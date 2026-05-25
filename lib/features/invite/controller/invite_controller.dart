// ============================================================
// features/invite/controller/invite_controller.dart
// Updated for: Mohamed Yousuf & Hajima Bee
// ============================================================

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/routes/app_routes.dart';

class InviteController extends GetxController {

  final RxString typedStory   = ''.obs;
  final RxBool storyAnimDone  = false.obs;

  final RxBool storyVisible   = false.obs;
  final RxBool coupleVisible  = false.obs;
  final RxBool eventsVisible  = false.obs;
  final RxBool mapVisible     = false.obs;

  // ✅ UPDATED: Story for Mohamed Yousuf & Hajima Bee
  static const String fullStory =
      'What Allah has written, no pen can erase. Their story was penned in '
      'the heavens long before they ever met. Through every prayer, every '
      'patient moment, and every act of faith — they were being guided '
      'toward each other. Today, with gratitude in their hearts and joy '
      'in their souls, they step into this sacred bond together. '
      'Alhamdulillah for this beautiful blessing.';

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 800), _startTyping);
  }

  void _startTyping() async {
    typedStory.value = '';
    for (int i = 0; i < fullStory.length; i++) {
      await Future.delayed(const Duration(milliseconds: 28));
      typedStory.value = fullStory.substring(0, i + 1);
    }
    storyAnimDone.value = true;
  }

  void goToRsvp() {
    Get.toNamed(AppRoutes.rsvp);
  }

  // ✅ UPDATED: Share text with real details
  void shareInvitation() {
    Share.share(
      'Assalamu Alaikum! 🌙\n\n'
          'You are warmly invited to the Walima of\n'
          'Mohamed Yousuf & Hajima Bee 💍\n\n'
          '📅 July 05, 2026\n'
          '⏰ 10:30 AM – 12:00 PM\n'
          '📍 G.R.P Lakshmi Mahal,\n'
          '   E.C.R Main Road, Anumandai (Old Tollgate).\n\n'
          'Your presence will make this day truly special. 🌸',
      subject: 'Wedding Invitation — Mohamed Yousuf & Hajima Bee',
    );
  }

  // ✅ UPDATED: WhatsApp share text
  void shareOnWhatsApp() async {
    const message =
        'Assalamu Alaikum! 🌙%0A%0A'
        'You are warmly invited to the Walima of%0A'
        'Mohamed Yousuf %26 Hajima Bee 💍%0A%0A'
        '📅 July 05, 2026%0A'
        '⏰ 10:30 AM – 12:00 PM%0A'
        '📍 G.R.P Lakshmi Mahal, E.C.R Main Road, Anumandai (Old Tollgate)%0A%0A'
        'Your presence will make this day truly special. 🌸';

    final uri = Uri.parse('https://wa.me/?text=$message');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ✅ UPDATED: Real venue location search
  void openMapsLocation() async {
    final uri = Uri.parse(
      'https://maps.app.goo.gl/EjdmwaT9RJ9aFy7K6',//https://maps.app.goo.gl/EjdmwaT9RJ9aFy7K6

    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}