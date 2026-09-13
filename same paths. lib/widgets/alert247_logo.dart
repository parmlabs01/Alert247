import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A fully vector rendering of the Alert 247 mark: a red shield with a
/// white double-border and a white EKG/heartbeat pulse through the
/// center. Drawn with CustomPainter so it is infinitely scalable and
/// has genuine transparency — no checkerboard/background artifacts
/// that can come from a flattened raster export.
class Alert247Logo extends StatelessWidget {
  const Alert247Logo({super.key, this.size = 180});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _ShieldPainter()),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  Path _shieldPath(Size size, {double inset = 0}) {
    final w = size.width;
    final h = size.height;
    final i = inset;

    final path = Path();
    path.moveTo(w * 0.5, i);
    path.quadraticBezierTo(w * 0.94 - i, h * 0.02 + i, w * 0.94 - i, h * 0.20 + i);
    path.lineTo(w * 0.94 - i, h * 0.42);
    path.cubicTo(
      w * 0.94 - i, h * 0.74 - i,
      w * 0.76, h * 0.90 - i,
      w * 0.5, h * 1.0 - i,
    );
    path.cubicTo(
      w * 0.24, h * 0.90 - i,
      w * 0.06 + i, h * 0.74 - i,
      w * 0.06 + i, h * 0.42,
    );
    path.lineTo(w * 0.06 + i, h * 0.20 + i);
    path.quadraticBezierTo(w * 0.06 + i, h * 0.02 + i, w * 0.5, i);
    path.close();
    return path;
  }

  Path _heartbeatPath(Size size) {
    final w = size.width;
    final midY = size.height * 0.52;
    final path = Path()..moveTo(w * 0.10, midY);
    path.lineTo(w * 0.30, midY);
    path.lineTo(w * 0.38, midY - size.height * 0.10);
    path.lineTo(w * 0.46, midY + size.height * 0.28);
    path.lineTo(w * 0.54, midY - size.height * 0.34);
    path.lineTo(w * 0.62, midY + size.height * 0.10);
    path.lineTo(w * 0.70, midY);
    path.lineTo(w * 0.90, midY);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final outer = _shieldPath(size);

    // Outer red fill.
    canvas.drawPath(
      outer,
      Paint()
        ..color = AppColors.emergencyRed
        ..style = PaintingStyle.fill,
    );

    // Outer white border.
    canvas.drawPath(
      outer,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.035,
    );

    // Inner white border (double-border look).
    final inner = _shieldPath(size, inset: size.width * 0.09);
    canvas.drawPath(
      inner,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.018,
    );

    // Heartbeat pulse line.
    canvas.drawPath(
      _heartbeatPath(size),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.035
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
