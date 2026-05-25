/*
// ============================================================
// features/invite/view/invite_screen.dart
// Updated for: Mohamed Yousuf & Hajima Bee
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/invite_controller.dart';
import '../../../app/theme/app_theme.dart';
import '../../../widgets/gold_button.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/person_card.dart';
import '../../../widgets/event_card.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  late final InviteController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.find<InviteController>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 100)  controller.storyVisible.value  = true;
    if (offset > 500)  controller.coupleVisible.value = true;
    if (offset > 1000) controller.eventsVisible.value = true;
    if (offset > 1500) controller.mapVisible.value    = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ── APP BAR ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.bgDark,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.gold, size: 18),
              onPressed: () => Get.back(),
            ),
            // ✅ UPDATED app bar title
            title: Text(
              'MOHAMED YOUSUF & HAJIMA BEE',
              style: GoogleFonts.cinzel(
                fontSize: 11,
                letterSpacing: 2,
                color: AppColors.goldLight,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share,
                    color: AppColors.gold, size: 20),
                onPressed: controller.shareInvitation,
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildStorySection(),
                _buildDivider(),
                _buildCoupleSection(),
                _buildDivider(),
                _buildEventsSection(),
                _buildDivider(),
                _buildLocationSection(),
                _buildDivider(),
                _buildRsvpSection(),
                _buildShareSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // A. OUR STORY
  // ══════════════════════════════════════════════════════
  Widget _buildStorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          const SectionHeader(
            label: 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
            title: 'Our Story',
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.gold.withValues(alpha:0.1)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Obx(() => Text(
              controller.storyAnimDone.value
                  ? InviteController.fullStory
                  : '${controller.typedStory.value}▌',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: AppColors.rose.withValues(alpha:0.85),
                height: 1.9,
              ),
              textAlign: TextAlign.center,
            )),
          ),
          const SizedBox(height: 40),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    // ✅ UPDATED timeline milestones
    final milestones = [
      {'icon': '🌙', 'year': 'Nikkah', 'label': 'Sacred bond'},
      {'icon': '💍', 'year': '2026',   'label': 'Walima'},
      {'icon': '🤲', 'year': 'Du\'a',  'label': 'Blessings'},
      {'icon': '🏡', 'year': 'Home',   'label': 'New life'},
      {'icon': '💗', 'year': 'Always', 'label': 'Together'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: milestones.map((m) => Column(
        children: [
          Text(m['icon']!, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            m['year']!,
            style: GoogleFonts.cinzel(
                fontSize: 10, color: AppColors.gold, letterSpacing: 1),
          ),
          Text(
            m['label']!,
            style: GoogleFonts.lato(
                fontSize: 9, color: AppColors.textMuted),
          ),
        ],
      )).toList(),
    );
  }

  // ══════════════════════════════════════════════════════
  // B. COUPLE SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildCoupleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(label: 'The Couple', title: 'Groom & Bride'),
          const SizedBox(height: 36),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ UPDATED: Groom details
              Expanded(
                child: PersonCard(
                  imagePath: "assets/images/boy.png",
                  name: 'Mohamed Yousuf',
                  role: 'The Groom',
                  bio: 'A man of faith, strength, and warmth. '
                      'He walks with humility and leads with love, '
                      'ready to build a blessed home together.',
                ),
              ),
              const SizedBox(width: 16),
              // ✅ UPDATED: Bride details
              Expanded(
                child: PersonCard(
                  imagePath:"assets/images/girl.png",
                  name: 'Hajima Bee',
                  role: 'The Bride',
                  bio: 'A woman of grace, gentleness, and light. '
                      'Her smile brightens every room, and her heart '
                      'is full of kindness and beautiful dreams.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // C. EVENTS SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildEventsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(label: 'Join Us', title: 'Event Details'),
          const SizedBox(height: 36),

          // ✅ UPDATED: Single wedding event with real details
          EventCard(
            icon: '💒',
            title: 'WEDDING CEREMONY',
            date: 'July 05, 2026  ·  10:30 AM – 12:00 PM',
            venue: 'G.R.P Lakshmi Mahal,\nE.C.R Main Road, Anumandai (Old Tollgate).',
            dresscode: '',//Traditional & Formal Attire
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // D. LOCATION SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(label: 'Find Us', title: 'Venue'),
          const SizedBox(height: 36),

          // Map card
          GestureDetector(
            onTap: controller.openMapsLocation,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                ),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha:0.2),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(6, (i) => Positioned(
                    top: (i + 1) * 30.0,
                    left: 0, right: 0,
                    child: Container(
                      height: 0.5,
                      color: Colors.white.withValues(alpha:0.04),
                    ),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📍', style: TextStyle(fontSize: 44)),
                      const SizedBox(height: 10),
                      // ✅ UPDATED venue name
                      Text(
                        'G.R.P Lakshmi Mahal',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          color: AppColors.goldLight,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // ✅ UPDATED venue address
                      Text(
                        'E.C.R Main Road, Anumandai\n(Old Tollgate)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha:0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Tap for directions',
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            color: AppColors.gold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Directions button
          OutlinedButton.icon(
            onPressed: controller.openMapsLocation,
            icon: const Icon(Icons.directions, size: 18),
            label: const Text('GET DIRECTIONS'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.gold,
              side: const BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.symmetric(
                horizontal: 32, vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // E. RSVP SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildRsvpSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A0810), Color(0xFF2D1020)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha:0.2)),
      ),
      child: Column(
        children: [
          const Text('💌', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 16),
          Text(
            'Will You Join Us?',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 8),
          // ✅ UPDATED RSVP deadline text
          Text(
            'Kindly confirm by June 25, 2026',
            style: GoogleFonts.cinzel(
              fontSize: 10,
              letterSpacing: 2,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 24),
          GoldButton(
            label: 'RSVP Now  →',
            onPressed: controller.goToRsvp,
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // F. SHARE SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildShareSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Text(
            'SHARE THE JOY',
            style: GoogleFonts.cinzel(
              fontSize: 9,
              letterSpacing: 3,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _shareButton(
                icon: '💬',
                label: 'WhatsApp',
                onTap: controller.shareOnWhatsApp,
              ),
              const SizedBox(width: 16),
              _shareButton(
                icon: '↗',
                label: 'Share',
                onTap: controller.shareInvitation,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shareButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gold.withValues(alpha:0.3)),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.gold.withValues(alpha:0.05),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lato(
                color: AppColors.rose,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: 60,
          color: AppColors.gold.withValues(alpha:0.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '✦',
            style: TextStyle(
              color: AppColors.gold.withValues(alpha:0.4),
              fontSize: 12,
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: 60,
          color: AppColors.gold.withValues(alpha:0.2),
        ),
      ],
    );
  }
}*/
// ============================================================
// features/invite/view/invite_screen.dart
// Updated for: Mohamed Yousuf & Hajima Bee
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/invite_controller.dart';
import '../../../app/theme/app_theme.dart';
import '../../../widgets/gold_button.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/person_card.dart';
import '../../../widgets/event_card.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  late final InviteController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.find<InviteController>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 100) controller.storyVisible.value = true;
    if (offset > 500) controller.coupleVisible.value = true;
    if (offset > 1000) controller.eventsVisible.value = true;
    if (offset > 1500) controller.mapVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.bgDark,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.gold, size: 18),
              onPressed: () => Get.back(),
            ),
            title: Text(
              'MOHAMED YOUSUF & HAJIMA BEE',
              style: GoogleFonts.cinzel(
                fontSize: 11,
                letterSpacing: 2,
                color: AppColors.goldLight,
              ),
            ),
            centerTitle: true,
            actions: [
              // IconButton(
              //   icon: const Icon(Icons.share, color: AppColors.gold, size: 20),
              //   onPressed: controller.shareInvitation,
              // ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildStorySection(),
                _buildDivider(),
                _buildCoupleSection(),
                _buildDivider(),
                _buildDuaSection(),        // ✅ Nikkah Dua added here
                _buildDivider(),
                _buildEventsSection(),
                _buildDivider(),
                _buildLocationSection(),
                _buildDivider(),
                _buildRsvpSection(),
             //   _buildShareSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // A. OUR STORY
  // ══════════════════════════════════════════════════════
  Widget _buildStorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          const SectionHeader(
            label: 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
            title: 'Our Story',
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Obx(() => Text(
              controller.storyAnimDone.value
                  ? InviteController.fullStory
                  : '${controller.typedStory.value}▌',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: AppColors.rose.withValues(alpha: 0.85),
                height: 1.9,
              ),
              textAlign: TextAlign.center,
            )),
          ),
          const SizedBox(height: 40),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final milestones = [
      {'icon': '🌙', 'year': 'Nikkah', 'label': 'Sacred bond'},
      {'icon': '💍', 'year': '2026', 'label': 'Walima'},
      {'icon': '🤲', 'year': 'Du\'a', 'label': 'Blessings'},
      {'icon': '🏡', 'year': 'Home', 'label': 'New life'},
      {'icon': '💗', 'year': 'Always', 'label': 'Together'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: milestones.map((m) => Column(
        children: [
          Text(m['icon']!, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            m['year']!,
            style: GoogleFonts.cinzel(fontSize: 10, color: AppColors.gold, letterSpacing: 1),
          ),
          Text(
            m['label']!,
            style: GoogleFonts.lato(fontSize: 9, color: AppColors.textMuted),
          ),
        ],
      )).toList(),
    );
  }

  // ══════════════════════════════════════════════════════
  // B. COUPLE SECTION (with parents' names)
  // ══════════════════════════════════════════════════════
  Widget _buildCoupleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(label: 'The Couple', title: 'Groom & Bride'),
          const SizedBox(height: 36),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    PersonCard(
                      imagePath: "assets/images/boy.png",
                      name: 'Mohamed Yousuf',
                      role: 'The Groom',
                      bio: 'A man of faith, strength, and warmth. '
                          'He walks with humility and leads with love, '
                          'ready to build a blessed home together.',
                    ),
                    const SizedBox(height: 12),
                    // ✅ Groom's parents
                    _buildParentsRow(
                      father: 'Basheer',
                      mother: 'Jibitha Begam', parents: 'Groom Parents',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    PersonCard(
                      imagePath: "assets/images/girl.png",
                      name: 'Hajima Bee',
                      role: 'The Bride',
                      bio: 'A woman of grace, gentleness, and light. '
                          'Her smile brightens every room, and her heart '
                          'is full of kindness and beautiful dreams.',
                    ),
                    const SizedBox(height: 12),
                    // ✅ Bride's parents


                    _buildParentsRow(
                      father: 'Ikram Basha',
                      mother: 'Maimun Be', parents: 'Bride Parents',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParentsRow({required String father, required String mother,required String parents}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Text(
            parents,
            style: GoogleFonts.cinzel(
              fontSize: 9,
              letterSpacing: 2,
              color: AppColors.goldLight,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, size: 12, color: AppColors.rose),
              const SizedBox(width: 6),
              Expanded(  // ✅ THIS FIXES OVERFLOW
                child: Text(
                  '$father  &  $mother',
                  textAlign: TextAlign.center,
                  softWrap: true,  // allow wrapping to next line if needed
                  style: GoogleFonts.lato(
                    fontSize: 11,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ══════════════════════════════════════════════════════
  // C. NIKKAH DUA SECTION (Barakallahu...)
  // ══════════════════════════════════════════════════════
  Widget _buildDuaSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.bgMid, AppColors.bgDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              'ﷺ',
              style: TextStyle(
                fontSize: 32,
                color: AppColors.gold,
                fontFamily: 'serif',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nikkah Dua',
              style: GoogleFonts.cinzel(
                fontSize: 14,
                letterSpacing: 3,
                color: AppColors.goldLight,
              ),
            ),
            const SizedBox(height: 20),
            Text(
'بَارَكَ اللَّهُ لَكَ، وَبَارَكَ عَلَيْكَ, وَجَمَعَ بَيْنَكُمَا فِي خَيْرٍ',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                color: AppColors.rose,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Barakallahu lakuma wa baraka ‘alaykuma wa jama’a baynakuma fi khayr.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'May Allah bless you, shower His blessings upon you, and unite you in goodness.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: AppColors.gold.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // D. EVENTS SECTION (with Nikkah word & Arabic date)
  // ══════════════════════════════════════════════════════
  Widget _buildEventsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(label: 'Join Us', title: 'Event Details'),
          const SizedBox(height: 36),
          EventCard(
            icon: '💒',
            title: 'NIKKAH & WALIMA', // ✅ Nikkah word added
            date: 'July 05, 2026  ·  ${InviteController.arabicDateTranslit}', // ✅ Arabic date
            venue: 'G.R.P Lakshmi Mahal,\nE.C.R Main Road, Anumandai (Old Tollgate).',
            dresscode: '',
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // E. LOCATION SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(label: 'Find Us', title: 'Venue'),
          const SizedBox(height: 36),
          GestureDetector(
            onTap: controller.openMapsLocation,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                ),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(6, (i) => Positioned(
                    top: (i + 1) * 30.0,
                    left: 0, right: 0,
                    child: Container(
                      height: 0.5,
                      color: Colors.white.withValues(alpha: 0.04),
                    ),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📍', style: TextStyle(fontSize: 44)),
                      const SizedBox(height: 10),
                      Text(
                        'G.R.P Lakshmi Mahal',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          color: AppColors.goldLight,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'E.C.R Main Road, Anumandai\n(Old Tollgate)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Tap for directions',
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            color: AppColors.gold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: controller.openMapsLocation,
            icon: const Icon(Icons.directions, size: 18),
            label: const Text('GET DIRECTIONS'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.gold,
              side: const BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // F. RSVP SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildRsvpSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A0810), Color(0xFF2D1020)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          const Text('💌', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 16),
          Text(
            'Will You Join Us?',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kindly confirm by June 25, 2026',
            style: GoogleFonts.cinzel(
              fontSize: 10,
              letterSpacing: 2,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 24),
          GoldButton(
            label: 'RSVP Now  →',
            onPressed: controller.goToRsvp,
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // G. SHARE SECTION
  // ══════════════════════════════════════════════════════
  Widget _buildShareSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Text(
            'SHARE THE JOY',
            style: GoogleFonts.cinzel(
              fontSize: 9,
              letterSpacing: 3,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _shareButton(
                icon: '💬',
                label: 'WhatsApp',
                onTap: controller.shareOnWhatsApp,
              ),
              const SizedBox(width: 16),
              _shareButton(
                icon: '↗',
                label: 'Share',
                onTap: controller.shareInvitation,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shareButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.gold.withValues(alpha: 0.05),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.lato(
                color: AppColors.rose,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.5,
          width: 60,
          color: AppColors.gold.withValues(alpha: 0.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '✦',
            style: TextStyle(
              color: AppColors.gold.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: 60,
          color: AppColors.gold.withValues(alpha: 0.2),
        ),
      ],
    );
  }
}