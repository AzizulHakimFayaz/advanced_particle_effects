import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'particle.dart';
import 'particle_configs.dart';

class ParticleEmitter {
  final ParticleConfig config;
  Offset position;
  final math.Random _random = math.Random();

  double _emissionTimer = 0;
  Size screenSize = Size.zero;

  ParticleEmitter({
    required this.config,
    required this.position,
  });

  void updateScreenSize(Size size) {
    screenSize = size;
  }

  List<Particle> emit(double dt) {
    final particles = <Particle>[];

    _emissionTimer += dt;

    final particlesToEmit = (_emissionTimer * config.emissionRate).floor();

    if (particlesToEmit > 0) {
      _emissionTimer -= particlesToEmit / config.emissionRate;
    }

    for (int i = 0; i < particlesToEmit; i++) {
      particles.add(_createParticle());
    }

    return particles;
  }

  // ----------------------------------------------------------
  // AUTO SPAWN BEHAVIOR BASED ON CONFIG
  // ----------------------------------------------------------
  Offset _computeSpawnPosition() {
    if (screenSize == Size.zero) return position;

    // ❄ SNOW → random along full width at top
    if (config.shape == ParticleShape.circle &&
        config.gravity &&
        !config.explosion) {
      return Offset(
        _random.nextDouble() * screenSize.width,
        -10,
      );
    }

    // 🌧 RAIN → random along full width at top
    if (config.shape == ParticleShape.line && config.gravity) {
      return Offset(
        _random.nextDouble() * screenSize.width,
        -10,
      );
    }

    // 🎇 FIREWORKS → point explosion (keep original position)
    if (config.explosion) return position;

    // 💨 SMOKE → random around emitter point
    if (config.wind && !config.gravity) {
      return Offset(
        position.dx + (_random.nextDouble() - 0.5) * 20,
        position.dy + (_random.nextDouble() - 0.5) * 20,
      );
    }

    // 🫧 BUBBLES → rise from bottom area
    if (config.bounce && !config.gravity) {
      return Offset(
        _random.nextDouble() * screenSize.width,
        screenSize.height + 10,
      );
    }

    // 🌐 NETWORK → spread everywhere once (autoInitialize)
    if (config.autoInitialize) {
      return Offset(
        _random.nextDouble() * screenSize.width,
        _random.nextDouble() * screenSize.height,
      );
    }

    // Default: emit from emitter point
    return position;
  }

  Particle _createParticle() {
    final spawnPos = _computeSpawnPosition();

    /// Angle & speed
    final angle = _random.nextDouble() * 2 * math.pi;
    final baseSpeed = config.minSpeed +
        _random.nextDouble() * (config.maxSpeed - config.minSpeed);

    final speed = baseSpeed * config.speedMultiplier;

    /// Velocity
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

    /// Size
    final size = config.minSize +
        _random.nextDouble() * (config.maxSize - config.minSize);

    /// Color
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
      position: spawnPos,
      velocity: velocity,
      color: color,
      size: size,
      life: config.particleLifespan,
      rotation: config.randomRotation ? _random.nextDouble() * 6.28 : 0,
      rotationSpeed:
          config.randomRotation ? (_random.nextDouble() - 0.5) * 4 : 0,
      shape: config.shape,
    );
  }
}
