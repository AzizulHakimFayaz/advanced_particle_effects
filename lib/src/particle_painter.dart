import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'particle.dart';
import 'particle_configs.dart';

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final ParticleConfig config;

  ParticlePainter(this.particles, this.config);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw connections first (behind particles) - EXACTLY LIKE YOUR CODE
    if (config.connectParticles) {
      _drawConnections(canvas, size);
    }

    // Draw particles
    for (final particle in particles) {
      _drawParticle(canvas, particle);
    }
  }

  void _drawConnections(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..strokeWidth = config.connectionLineWidth // NEW! Your custom width
      ..style = PaintingStyle.stroke
      ..blendMode = config.blendMode;

    // EXACTLY YOUR ALGORITHM
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final distance =
            (particles[i].position - particles[j].position).distance;

        if (distance < config.connectionDistance) {
          // Your fade calculation
          final opacity = (1 - distance / config.connectionDistance) *
              particles[i].opacity *
              particles[j].opacity *
              0.5; // Your opacity multiplier

          linePaint.color = particles[i].color.withValues(alpha: opacity);

          canvas.drawLine(
            particles[i].position,
            particles[j].position,
            linePaint,
          );
        }
      }
    }
  }

  void _drawParticle(Canvas canvas, Particle particle) {
    final paint = Paint()
      ..color = particle.color.withValues(
        alpha: config.fadeOut ? particle.opacity : 1.0,
      )
      ..blendMode = config.blendMode;

    canvas.save();
    canvas.translate(particle.position.dx, particle.position.dy);
    canvas.rotate(particle.rotation);

    switch (particle.shape) {
      case ParticleShape.circle:
        canvas.drawCircle(Offset.zero, particle.size, paint);
        break;
      case ParticleShape.square:
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: particle.size * 2,
            height: particle.size * 2,
          ),
          paint,
        );
        break;
      case ParticleShape.triangle:
        _drawTriangle(canvas, particle.size, paint);
        break;
      case ParticleShape.star:
        _drawStar(canvas, particle.size, paint);
        break;
      case ParticleShape.heart:
        _drawHeart(canvas, particle.size, paint);
        break;
      case ParticleShape.diamond:
        _drawDiamond(canvas, particle.size, paint);
        break;
      case ParticleShape.line:
        canvas.drawLine(
          Offset(0, -particle.size),
          Offset(0, particle.size),
          paint..strokeWidth = 2,
        );
        break;
    }

    canvas.restore();
  }

  void _drawTriangle(Canvas canvas, double size, Paint paint) {
    final path = Path()
      ..moveTo(0, -size)
      ..lineTo(size, size)
      ..lineTo(-size, size)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawStar(Canvas canvas, double size, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + (i * 4 * math.pi / 5);
      final radius = i.isEven ? size : size * 0.5;
      final x = math.cos(angle) * radius;
      final y = math.sin(angle) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawHeart(Canvas canvas, double size, Paint paint) {
    final path = Path();
    path.moveTo(0, size * 0.3);
    path.cubicTo(
      -size,
      -size * 0.5,
      -size * 0.5,
      -size,
      0,
      -size * 0.3,
    );
    path.cubicTo(
      size * 0.5,
      -size,
      size,
      -size * 0.5,
      0,
      size * 0.3,
    );
    canvas.drawPath(path, paint);
  }

  void _drawDiamond(Canvas canvas, double size, Paint paint) {
    final path = Path()
      ..moveTo(0, -size)
      ..lineTo(size, 0)
      ..lineTo(0, size)
      ..lineTo(-size, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
