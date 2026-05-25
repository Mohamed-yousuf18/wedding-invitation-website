// ============================================================
// widgets/event_card.dart
//
// Card for each wedding event (Mehndi, Sangeet, Ceremony).
// Features:
//   - Slide-in animation when first built
//   - Hover glow + bottom gold bar reveal
//   - Icon, title, date, venue, dresscode rows
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/theme/app_theme.dart';

class EventCard extends StatefulWidget {
  final String icon;
  final String title;
  final String date;
  final String venue;
  final String dresscode;

  const EventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.venue,
    required this.dresscode,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard>
    with SingleTickerProviderStateMixin {

  // Slide-in animation
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Slides from left side
    _slideAnim = Tween<Offset>(
      begin: const Offset(-0.08, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _fadeAnim = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    );

    // Start slide animation shortly after build
    Future.delayed(const Duration(milliseconds: 200),
            () => _slideController.forward());
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit:  (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _hovered = true),
            onTapUp:   (_) => setState(() => _hovered = false),
            onTapCancel:() => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hovered
                      ? AppColors.gold.withValues(alpha:0.45)
                      : AppColors.gold.withValues(alpha:0.15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.gold.withValues(alpha:_hovered ? 0.07 : 0.03),
                    Colors.transparent,
                  ],
                ),
                boxShadow: _hovered
                    ? [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha:0.1),
                    blurRadius: 24,
                  )
                ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon + Title row
                  Row(
                    children: [
                      Text(widget.icon,
                          style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Text(
                        widget.title,
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          letterSpacing: 2,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),

                  // Gold separator line
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: 0.5,
                    color: AppColors.gold.withValues(alpha:0.2),
                  ),

                  // Detail rows
                  _detailRow('📅', widget.date),
                  const SizedBox(height: 10),
                  _detailRow('📍', widget.venue),
                  const SizedBox(height: 10),
                 // _detailRow('👗', 'Dress code: ${widget.dresscode}'),

                  // Bottom gold bar (animates on hover)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(top: 20),
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          _hovered
                              ? AppColors.gold
                              : AppColors.gold.withValues(alpha:0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String emoji, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: 13,
              color: AppColors.rose.withValues(alpha:0.75),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}