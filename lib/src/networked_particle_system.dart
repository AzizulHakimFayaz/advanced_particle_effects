import 'package:advanced_particle_effects/src/particle_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
import 'particle.dart';
import 'particle_configs.dart';

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

  const NetworkedParticleSystem({
    Key? key,
    this.particleCount = 100,
    this.particleSize = 2.0,
    this.particleColor = Colors.white,
    this.lineColor,
    this.lineWidth = 1.2,
    this.connectionDistance = 80.0,
    this.speedMultiplier = 0.008,
    this.showConnections = true,
    this.bounce = true,
  }) : super(key: key);

  @override
  State<NetworkedParticleSystem> createState() => _NetworkedParticleSystemState();
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
    )..addListener(_updateParticles)
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

  _NetworkedParticlePainter({
    required this.positions,
    required this.particleSize,
    required this.particleColor,
    required this.lineColor,
    required this.lineWidth,
    required this.connectionDistance,
    required this.showConnections,
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
      final Color connectionColor = lineColor ?? particleColor;

      for (int i = 0; i < screenPositions.length; i++) {
        for (int j = i + 1; j < screenPositions.length; j++) {
          final distance = (screenPositions[i] - screenPositions[j]).distance;

          if (distance < connectionDistance) {
            // Distance-based opacity
            double opacity = (1 - (distance / connectionDistance)) * 0.5;
            linePaint.color = connectionColor.withOpacity(opacity);
            canvas.drawLine(screenPositions[i], screenPositions[j], linePaint);
          }
        }
      }
    }

    // Draw particles
    particlePaint.color = particleColor;
    for (final position in screenPositions) {
      canvas.drawCircle(position, particleSize, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ============================================
// EXAMPLE USAGE - Shows all features
// ============================================

void main() => runApp(const ParticleEffectExample());

class ParticleEffectExample extends StatefulWidget {
  const ParticleEffectExample({Key? key}) : super(key: key);

  @override
  State<ParticleEffectExample> createState() => _ParticleEffectExampleState();
}

class _ParticleEffectExampleState extends State<ParticleEffectExample> {
  int _selectedEffect = 0;

  final List<String> _effectNames = [
    'Default (White)',
    'Cyan & Blue',
    'Big Purple',
    'Dense Green',
    'Fast Red',
    'Snow',
    'Rain',
    'Confetti',
    'Magic',
  ];

  Widget _buildEffect(int index) {
    switch (index) {
      case 0:
      // Default - white particles
        return const NetworkedParticleSystem();
      case 1:
      // Custom colors
        return const NetworkedParticleSystem(
          particleCount: 80,
          particleColor: Colors.cyan,
          lineColor: Colors.blue,
        );
      case 2:
      // Big particles
        return const NetworkedParticleSystem(
          particleCount: 60,
          particleSize: 4.0,
          lineWidth: 2.0,
          particleColor: Colors.purple,
        );
      case 3:
      // Dense network
        return const NetworkedParticleSystem(
          particleCount: 150,
          particleSize: 1.5,
          connectionDistance: 70,
          particleColor: Colors.green,
        );
      case 4:
      // Fast movement
        return const NetworkedParticleSystem(
          particleCount: 100,
          speedMultiplier: 0.015,
          particleColor: Colors.red,
        );
      case 5:
        return ParticleSystem(config: ParticleConfig.snow);
      case 6:
        return ParticleSystem(config: ParticleConfig.rain);
      case 7:
        return ParticleSystem(
          config: ParticleConfig.confetti,
          emissionPoint: const Offset(200, 100),
        );
      case 8:
        return ParticleSystem(config: ParticleConfig.magic);
      default:
        return const NetworkedParticleSystem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Advanced Particle Effects'),
          backgroundColor: Colors.black87,
        ),
        body: Stack(
          children: [
            // Particle effect
            _buildEffect(_selectedEffect),

            // Control panel
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _effectNames[_selectedEffect],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        _effectNames.length,
                            (index) => ElevatedButton(
                          onPressed: () => setState(() => _selectedEffect = index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedEffect == index
                                ? Colors.blue
                                : Colors.grey[800],
                          ),
                          child: Text('${index + 1}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}