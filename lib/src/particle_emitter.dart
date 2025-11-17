import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'particle.dart';
import 'particle_configs.dart';

class ParticleEmitter {
  final ParticleConfig config;
  final Offset position;
  final math.Random _random = math.Random();
  double _emissionTimer = 0;

  ParticleEmitter({
    required this.config,
    required this.position,
  });

  List<Particle> emit(double dt) {
    final particles = <Particle>[];
    _emissionTimer += dt;

    final particlesToEmit = (_emissionTimer * config.emissionRate).floor();
    _emissionTimer -= particlesToEmit / config.emissionRate;

    for (int i = 0; i < particlesToEmit; i++) {
      particles.add(_createParticle());
    }

    return particles;
  }

  Particle _createParticle() {
    final angle = _random.nextDouble() * 2 * math.pi;
    final speed = (config.minSpeed +
            _random.nextDouble() * (config.maxSpeed - config.minSpeed)) *
        config.speedMultiplier; // NEW! Use speed multiplier

    Offset velocity;
    if (config.explosion) {
      velocity = Offset(
        math.cos(angle) * config.explosionForce,
        math.sin(angle) * config.explosionForce,
      );
    } else {
      velocity = Offset(
        math.cos(angle) * speed,
        math.sin(angle) * speed,
      );
    }

    final size = config.minSize +
        _random.nextDouble() * (config.maxSize - config.minSize);

    Color color;
    if (config.rainbow) {
      color = HSVColor.fromAHSV(
        1.0,
        _random.nextDouble() * 360,
        1.0,
        1.0,
      ).toColor();
    } else {
      color = config.colors[_random.nextInt(config.colors.length)];
    }

    return Particle(
      position: position,
      velocity: velocity,
      color: color,
      size: size,
      life: config.particleLifespan,
      rotation: config.randomRotation ? _random.nextDouble() * 2 * math.pi : 0,
      rotationSpeed:
          config.randomRotation ? (_random.nextDouble() - 0.5) * 4 : 0,
      shape: config.shape,
    );
  }
}
