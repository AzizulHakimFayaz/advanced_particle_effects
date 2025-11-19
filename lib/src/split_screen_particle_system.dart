import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'networked_particle_system.dart';

/// A ready-to-use widget that creates a split-screen effect with particles
/// that change color based on which side of the split they are on.
///
/// Supports diagonal splits via [splitAngle].
class SplitScreenParticleSystem extends StatelessWidget {
  /// The normalized x-coordinate (0.0 to 1.0) where the split occurs.
  /// Default is 0.5 (center).
  final double splitPosition;

  /// The angle of the split line in radians.
  /// 0.0 is vertical. Positive values rotate clockwise.
  /// Default is 0.0.
  final double splitAngle;

  /// Background color for the left side.
  final Color leftBackgroundColor;

  /// Background color for the right side.
  final Color rightBackgroundColor;

  /// Particle color when on the left side.
  final Color leftParticleColor;

  /// Particle color when on the right side.
  final Color rightParticleColor;

  /// Number of particles.
  final int particleCount;

  /// Size of particles.
  final double particleSize;

  /// Speed multiplier for particles.
  final double speedMultiplier;

  /// Connection distance for lines.
  final double connectionDistance;

  const SplitScreenParticleSystem({
    super.key,
    this.splitPosition = 0.5,
    this.splitAngle = 0.0,
    this.leftBackgroundColor = Colors.white,
    this.rightBackgroundColor = Colors.black,
    this.leftParticleColor = Colors.black,
    this.rightParticleColor = Colors.white,
    this.particleCount = 100,
    this.particleSize = 2.0,
    this.speedMultiplier = 0.008,
    this.connectionDistance = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Background
        CustomPaint(
          size: Size.infinite,
          painter: _SplitBackgroundPainter(
            splitPosition: splitPosition,
            splitAngle: splitAngle,
            leftColor: leftBackgroundColor,
            rightColor: rightBackgroundColor,
          ),
        ),

        // 2. Particles
        NetworkedParticleSystem(
          particleCount: particleCount,
          particleSize: particleSize,
          speedMultiplier: speedMultiplier,
          connectionDistance: connectionDistance,

          // Dynamic particle color
          particleColorBuilder: (position, size) => _getColorForPosition(
            position,
            size,
            leftParticleColor,
            rightParticleColor,
          ),

          // Dynamic line color
          lineColorBuilder: (position, size) => _getColorForPosition(
            position,
            size,
            leftParticleColor.withValues(alpha: 0.5),
            rightParticleColor.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Color _getColorForPosition(
    Offset position,
    Size size,
    Color leftColor,
    Color rightColor,
  ) {
    if (_isLeft(position, size)) {
      return leftColor;
    } else {
      return rightColor;
    }
  }

  bool _isLeft(Offset position, Size size) {
    // 1. Translate relative to split point
    // The split point is at (splitPosition * width, height / 2)
    final splitPoint = Offset(splitPosition * size.width, size.height / 2);
    final relativePos = position - splitPoint;

    // 2. Rotate by -splitAngle to align split line with Y-axis
    // If the point's x is < 0 after rotation, it's on the "left"
    final cosA = math.cos(-splitAngle);
    final sinA = math.sin(-splitAngle);

    final rotatedX = relativePos.dx * cosA - relativePos.dy * sinA;

    return rotatedX < 0;
  }
}

class _SplitBackgroundPainter extends CustomPainter {
  final double splitPosition;
  final double splitAngle;
  final Color leftColor;
  final Color rightColor;

  _SplitBackgroundPainter({
    required this.splitPosition,
    required this.splitAngle,
    required this.leftColor,
    required this.rightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw Right Background (Base)
    paint.color = rightColor;
    canvas.drawRect(Offset.zero & size, paint);

    // Draw Left Background (Polygon)
    paint.color = leftColor;

    // We need to define the polygon for the "left" side.
    // The split line passes through (splitX, centerY) with angle splitAngle.
    // Line equation:
    // Normal vector N = (cos(angle), sin(angle))
    // Point P on line.
    // But simpler: we can just draw a massive rectangle rotated around the split point
    // and clipped to the screen, OR calculate the intersection points.

    // Let's use the rotation method which is robust.
    // We want to fill the area where x < 0 in the rotated coordinate system.

    canvas.save();

    // Move to split point
    final splitPoint = Offset(splitPosition * size.width, size.height / 2);
    canvas.translate(splitPoint.dx, splitPoint.dy);

    // Rotate
    canvas.rotate(splitAngle);

    // Draw a huge rectangle on the "left" side (x < 0)
    // Size needs to be big enough to cover the screen even when rotated.
    final diag = math.sqrt(size.width * size.width + size.height * size.height);

    canvas.drawRect(Rect.fromLTWH(-diag, -diag, diag, diag * 2), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SplitBackgroundPainter oldDelegate) {
    return oldDelegate.splitPosition != splitPosition ||
        oldDelegate.splitAngle != splitAngle ||
        oldDelegate.leftColor != leftColor ||
        oldDelegate.rightColor != rightColor;
  }
}
