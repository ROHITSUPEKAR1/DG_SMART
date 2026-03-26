import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ─── CHIP / BADGE ──────────────────────────────────────────────────────────

class AppChip extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final double fontSize;

  const AppChip({
    super.key,
    required this.label,
    required this.bgColor,
    required this.textColor,
    this.fontSize = 9,
  });

  factory AppChip.green(String label, {double fontSize = 9}) => AppChip(
    label: label, bgColor: AppColors.chipGreenBg,
    textColor: AppColors.chipGreenText, fontSize: fontSize,
  );
  factory AppChip.red(String label, {double fontSize = 9}) => AppChip(
    label: label, bgColor: AppColors.chipRedBg,
    textColor: AppColors.chipRedText, fontSize: fontSize,
  );
  factory AppChip.blue(String label, {double fontSize = 9}) => AppChip(
    label: label, bgColor: AppColors.chipBlueBg,
    textColor: AppColors.chipBlueText, fontSize: fontSize,
  );
  factory AppChip.amber(String label, {double fontSize = 9}) => AppChip(
    label: label, bgColor: AppColors.chipAmberBg,
    textColor: AppColors.chipAmberText, fontSize: fontSize,
  );
  factory AppChip.purple(String label, {double fontSize = 9}) => AppChip(
    label: label, bgColor: AppColors.chipPurpleBg,
    textColor: AppColors.chipPurpleText, fontSize: fontSize,
  );
  factory AppChip.pink(String label, {double fontSize = 9}) => AppChip(
    label: label,
    bgColor: const Color(0xFFFFE4F0),
    textColor: const Color(0xFFc2185b),
    fontSize: fontSize,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
    );
  }
}

// ─── SECTION TITLE ─────────────────────────────────────────────────────────

class SectionTitle extends StatelessWidget {
  final String title;
  final double marginBottom;

  const SectionTitle(this.title, {super.key, this.marginBottom = 10});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: marginBottom),
      child: Text(
        title,
        style: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// ─── WHITE CARD ────────────────────────────────────────────────────────────

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final double? marginBottom;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 18,
    this.marginBottom,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 0),
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

// ─── PILL INPUT ────────────────────────────────────────────────────────────

class PillInputField extends StatefulWidget {
  final String hint;
  final String icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const PillInputField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<PillInputField> createState() => _PillInputFieldState();
}

class _PillInputFieldState extends State<PillInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(widget.icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword && _obscure,
              keyboardType: widget.keyboardType,
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textLight,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (widget.isPassword)
            GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  _obscure ? '👁' : '🙈',
                  style: TextStyle(fontSize: 14, color: Colors.black.withValues(alpha: 0.38)),
                ),
              ),
            )
          else
            const SizedBox(width: 16),
        ],
      ),
    );
  }
}

// ─── GRADIENT BUTTON ───────────────────────────────────────────────────────

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final List<Color> colors;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.colors = const [Color(0xFF3b9ef5), Color(0xFF2b7de8)],
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(99),
        ),
        child: isLoading
            ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
            : Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}

// ─── AVATAR CIRCLE ─────────────────────────────────────────────────────────

class AvatarCircle extends StatelessWidget {
  final String initials;
  final double size;
  final Color bgColor;
  final Color textColor;
  final List<Color>? gradient;

  const AvatarCircle({
    super.key,
    required this.initials,
    this.size = 40,
    this.bgColor = AppColors.primary,
    this.textColor = Colors.white,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: gradient == null ? bgColor : null,
        gradient: gradient != null ? LinearGradient(colors: gradient!) : null,
      ),
      child: Center(
        child: Text(
          initials,
          style: GoogleFonts.nunito(
            fontSize: size * 0.32,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

// ─── PROGRESS BAR ──────────────────────────────────────────────────────────

class AppProgressBar extends StatelessWidget {
  final double percentage;
  final Color fillColor;
  final double height;

  const AppProgressBar({
    super.key,
    required this.percentage,
    required this.fillColor,
    this.height = 7,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: Container(
        height: height,
        color: AppColors.borderLight,
        child: FractionallySizedBox(
          widthFactor: (percentage / 100).clamp(0.0, 1.0),
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── BOTTOM NAVIGATION ─────────────────────────────────────────────────────

class AppBottomNav extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;

  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isActive = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(items[i].icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 3),
                Text(
                  items[i].label,
                  style: GoogleFonts.nunito(
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    color: isActive ? activeColor : AppColors.textLight,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class BottomNavItem {
  final String icon;
  final String label;
  const BottomNavItem({required this.icon, required this.label});
}

// ─── GRADIENT BACKGROUND ───────────────────────────────────────────────────

class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientBackground({
    super.key,
    required this.child,
    required this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
}

// ─── TOP BAR ───────────────────────────────────────────────────────────────

class AppTopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  const AppTopBar({super.key, required this.title, this.onBack, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 44, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.pop(context),
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.35),
              ),
              child: const Center(
                child: Text('‹', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          trailing ?? const SizedBox(width: 32),
        ],
      ),
    );
  }
}

// ─── INFO ROW ──────────────────────────────────────────────────────────────

class InfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final bool showBorder;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: showBorder
          ? BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderLight)))
          : null,
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textLight),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
