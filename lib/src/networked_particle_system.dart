import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Function signature for dynamic particle coloring based on position
typedef ParticleColorBuilder = Color Function(Offset position, Size systemSize);

/// NetworkedParticleSystem - Easy-to-use particle network with full customization
///
/// Simple usage with defaults:
/// ```dart
/// NetworkedParticleSystem()
/// ```
///
/// Full customization:
/// ```dart
/// NetworkedParticleSystem(
///   particleCount: 150,
///   particleSize: 3.0,
///   particleColor: Colors.blue,
///   lineColor: Colors.cyan,
///   lineWidth: 1.5,
///   connectionDistance: 100,
///   speedMultiplier: 0.01,
/// )
/// ```
class NetworkedParticleSystem extends StatefulWidget {
  /// Number of particles (default: 100)
  final int particleCount;

  /// Size of each particle (default: 2.0)
  final double particleSize;

  /// Color of particles (default: Colors.white)
  final Color particleColor;

  /// Color of connection lines (default: same as particleColor)
  final Color? lineColor;

  /// Width of connection lines (default: 1.2)
  final double lineWidth;

  /// Maximum distance for particles to connect (default: 80)
  final double connectionDistance;

  /// Speed control - higher = faster (default: 0.008)
  final double speedMultiplier;

  /// Enable particle connections (default: true)
  final bool showConnections;

  /// Enable bounce off edges (default: true)
  final bool bounce;

  /// Optional builder for dynamic particle colors based on position
  final ParticleColorBuilder? particleColorBuilder;

  /// Optional builder for dynamic line colors based on position
  final ParticleColorBuilder? lineColorBuilder;

  const NetworkedParticleSystem({
    super.key,
    this.particleCount = 100,
    this.particleSize = 2.0,
    this.particleColor = Colors.white,
    this.lineColor,
    this.lineWidth = 1.2,
    this.connectionDistance = 80.0,
    this.speedMultiplier = 0.008,
    this.showConnections = true,
    this.bounce = true,
    this.particleColorBuilder,
    this.lineColorBuilder,
  });

  @override
  State<NetworkedParticleSystem> createState() =>
      _NetworkedParticleSystemState();
}

class _NetworkedParticleSystemState extends State<NetworkedParticleSystem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final math.Random _random = math.Random();
  late List<Offset> _positions;
  late List<Offset> _velocities;

  @override
  void initState() {
    super.initState();

    // Initialize exactly like your code
    _positions = List.generate(
      widget.particleCount,
      (_) => Offset(_random.nextDouble(), _random.nextDouble()),
    );
    _velocities = List.generate(
      widget.particleCount,
      (_) => Offset(
        (_random.nextDouble() - 0.5) * widget.speedMultiplier,
        (_random.nextDouble() - 0.5) * widget.speedMultiplier,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1000),
    )
      ..addListener(_updateParticles)
      ..repeat();
  }

  void _updateParticles() {
    setState(() {
      // Update exactly like your code
      for (int i = 0; i < widget.particleCount; i++) {
        var pos = _positions[i] + _velocities[i];

        // Bounce off edges if enabled
        if (widget.bounce) {
          if (pos.dx < 0 || pos.dx > 1) {
            _velocities[i] = Offset(-_velocities[i].dx, _velocities[i].dy);
          }
          if (pos.dy < 0 || pos.dy > 1) {
            _velocities[i] = Offset(_velocities[i].dx, -_velocities[i].dy);
          }
        }

        _positions[i] = Offset(
          pos.dx.clamp(0.0, 1.0),
          pos.dy.clamp(0.0, 1.0),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _NetworkedParticlePainter(
        positions: _positions,
        particleSize: widget.particleSize,
        particleColor: widget.particleColor,
        lineColor: widget.lineColor ?? widget.particleColor,
        lineWidth: widget.lineWidth,
        connectionDistance: widget.connectionDistance,
        showConnections: widget.showConnections,
        particleColorBuilder: widget.particleColorBuilder,
        lineColorBuilder: widget.lineColorBuilder,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _NetworkedParticlePainter extends CustomPainter {
  final List<Offset> positions;
  final double particleSize;
  final Color particleColor;
  final Color lineColor;
  final double lineWidth;
  final double connectionDistance;
  final bool showConnections;
  final ParticleColorBuilder? particleColorBuilder;
  final ParticleColorBuilder? lineColorBuilder;

  _NetworkedParticlePainter({
    required this.positions,
    required this.particleSize,
    required this.particleColor,
    required this.lineColor,
    required this.lineWidth,
    required this.connectionDistance,
    required this.showConnections,
    this.particleColorBuilder,
    this.lineColorBuilder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint particlePaint = Paint();
    final Paint linePaint = Paint()
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    // Convert normalized positions to screen coordinates
    final List<Offset> screenPositions = positions
        .map((pos) => Offset(pos.dx * size.width, pos.dy * size.height))
        .toList();

    // Draw connections first
    if (showConnections) {
      for (int i = 0; i < screenPositions.length; i++) {
        for (int j = i + 1; j < screenPositions.length; j++) {
          final distance = (screenPositions[i] - screenPositions[j]).distance;

          if (distance < connectionDistance) {
            // Distance-based opacity
            double opacity = (1 - (distance / connectionDistance)) * 0.5;

            // Determine line color
            Color baseLineColor = lineColor;
            if (lineColorBuilder != null) {
              // Use midpoint for line color
              final midPoint = (screenPositions[i] + screenPositions[j]) / 2;
              // Normalize midpoint back to 0-1 range for the builder if needed,
              // but the builder takes Offset and Size, so we pass screen position?
              // The typedef says `Offset position, Size systemSize`.
              // Usually builders expect local coordinates.
              // Let's pass the screen position (midPoint) and the canvas size.
              // Wait, the user requirement said "provides the particle's position... and returns a Color".
              // "call it with the particle's current (dx, dy) position".
              // The positions in `_positions` are normalized (0-1).
              // The builder likely expects normalized positions if it's "left half of screen".
              // If I pass screen coordinates, "left half" means x < width/2.
              // If I pass normalized, "left half" means x < 0.5.
              // The user example: "if particle is on the left half of the screen...".
              // Normalized is easier for that (0.0-1.0).
              // But `Offset position` usually implies screen coords in Flutter painters.
              // However, `_positions` are normalized.
              // Let's look at the typedef again: `Color Function(Offset position, Size systemSize)`.
              // If I pass `systemSize`, then `position` should probably be screen coordinates.
              // Let's pass screen coordinates to be safe and standard for Painters.
              // But wait, `_positions` are normalized.
              // Let's pass screen coordinates.

              baseLineColor = lineColorBuilder!(midPoint, size);
            }

            linePaint.color = baseLineColor.withValues(alpha: opacity);

            canvas.drawLine(screenPositions[i], screenPositions[j], linePaint);
          }
        }
      }
    }

    // Draw particles
    for (int i = 0; i < screenPositions.length; i++) {
      final position = screenPositions[i];

      Color color = particleColor;
      if (particleColorBuilder != null) {
        color = particleColorBuilder!(position, size);
      }

      particlePaint.color = color;
      canvas.drawCircle(position, particleSize, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
