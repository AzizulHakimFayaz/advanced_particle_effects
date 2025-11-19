import 'package:flutter/material.dart';
import 'particle.dart';

class ParticleConfig {
  final int maxParticles;
  final double emissionRate;

  /// How long each particle lives (in seconds)
  final double particleLifespan;

  final double minSize;
  final double maxSize;

  final double minSpeed;
  final double maxSpeed;

  final List<Color> colors;
  final ParticleShape shape;

  final bool connectParticles;
  final double connectionDistance;
  final double connectionLineWidth;

  final bool fadeOut;
  final bool gravity;
  final double gravityStrength;

  final bool wind;
  final Offset windDirection;

  final bool randomRotation;
  final bool rainbow;
  final bool trail;

  final BlendMode blendMode;

  final bool magneticEffect;
  final Offset magneticCenter;
  final double magneticStrength;

  final bool bounce;
  final bool explosion;
  final double explosionForce;

  /// Multiplier applied to speed in emitter
  final double speedMultiplier;

  /// If true, particles can be initialized across the whole screen
  final bool autoInitialize;

  const ParticleConfig({
    this.maxParticles = 100,
    this.emissionRate = 50,
    this.particleLifespan = 2.0,
    this.minSize = 2.0,
    this.maxSize = 6.0,
    this.minSpeed = 50.0,
    this.maxSpeed = 150.0,
    this.colors = const [Colors.white],
    this.shape = ParticleShape.circle,
    this.connectParticles = false,
    this.connectionDistance = 100.0,
    this.connectionLineWidth = 1.0,
    this.fadeOut = true,
    this.gravity = false,
    this.gravityStrength = 100.0,
    this.wind = false,
    this.windDirection = const Offset(20, 0),
    this.randomRotation = false,
    this.rainbow = false,
    this.trail = false,
    this.blendMode = BlendMode.srcOver,
    this.magneticEffect = false,
    this.magneticCenter = Offset.zero,
    this.magneticStrength = 50.0,
    this.bounce = false,
    this.explosion = false,
    this.explosionForce = 200.0,
    this.speedMultiplier = 1.0,
    this.autoInitialize = false,
  });

  ParticleConfig copyWith({
    int? maxParticles,
    double? emissionRate,
    double? particleLifespan,
    double? minSize,
    double? maxSize,
    double? minSpeed,
    double? maxSpeed,
    List<Color>? colors,
    ParticleShape? shape,
    bool? connectParticles,
    double? connectionDistance,
    double? connectionLineWidth,
    bool? fadeOut,
    bool? gravity,
    double? gravityStrength,
    bool? wind,
    Offset? windDirection,
    bool? randomRotation,
    bool? rainbow,
    bool? trail,
    BlendMode? blendMode,
    bool? magneticEffect,
    Offset? magneticCenter,
    double? magneticStrength,
    bool? bounce,
    bool? explosion,
    double? explosionForce,
    double? speedMultiplier,
    bool? autoInitialize,
  }) {
    return ParticleConfig(
      maxParticles: maxParticles ?? this.maxParticles,
      emissionRate: emissionRate ?? this.emissionRate,
      particleLifespan: particleLifespan ?? this.particleLifespan,
      minSize: minSize ?? this.minSize,
      maxSize: maxSize ?? this.maxSize,
      minSpeed: minSpeed ?? this.minSpeed,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      colors: colors ?? this.colors,
      shape: shape ?? this.shape,
      connectParticles: connectParticles ?? this.connectParticles,
      connectionDistance: connectionDistance ?? this.connectionDistance,
      connectionLineWidth: connectionLineWidth ?? this.connectionLineWidth,
      fadeOut: fadeOut ?? this.fadeOut,
      gravity: gravity ?? this.gravity,
      gravityStrength: gravityStrength ?? this.gravityStrength,
      wind: wind ?? this.wind,
      windDirection: windDirection ?? this.windDirection,
      randomRotation: randomRotation ?? this.randomRotation,
      rainbow: rainbow ?? this.rainbow,
      trail: trail ?? this.trail,
      blendMode: blendMode ?? this.blendMode,
      magneticEffect: magneticEffect ?? this.magneticEffect,
      magneticCenter: magneticCenter ?? this.magneticCenter,
      magneticStrength: magneticStrength ?? this.magneticStrength,
      bounce: bounce ?? this.bounce,
      explosion: explosion ?? this.explosion,
      explosionForce: explosionForce ?? this.explosionForce,
      speedMultiplier: speedMultiplier ?? this.speedMultiplier,
      autoInitialize: autoInitialize ?? this.autoInitialize,
    );
  }

  // ----------------------------------------------------------
  // NETWORK PRESETS
  // ----------------------------------------------------------

  static ParticleConfig get networkParticles => const ParticleConfig(
        maxParticles: 100,
        emissionRate: 0,
        particleLifespan: 999.0, // long-lived nodes

        minSpeed: 20,
        maxSpeed: 40,

        minSize: 2,
        maxSize: 2,

        colors: [Colors.white],

        connectParticles: true,
        connectionDistance: 90,
        connectionLineWidth: 1.2,

        bounce: true,
        fadeOut: false,

        speedMultiplier: 0.015,
        autoInitialize: true,
      );

  static ParticleConfig get subtleNetwork => const ParticleConfig(
        maxParticles: 60,
        emissionRate: 0,
        particleLifespan: 999.0,
        minSpeed: 10,
        maxSpeed: 20,
        minSize: 1.5,
        maxSize: 2.5,
        connectParticles: true,
        connectionDistance: 110,
        colors: [Colors.white70],
        bounce: true,
        speedMultiplier: 0.01,
        autoInitialize: true,
        fadeOut: false,
      );

  static ParticleConfig get denseNetwork => const ParticleConfig(
        maxParticles: 160,
        emissionRate: 0,
        particleLifespan: 999.0,
        minSpeed: 15,
        maxSpeed: 30,
        minSize: 2,
        maxSize: 2.5,
        connectParticles: true,
        connectionDistance: 70,
        colors: [Colors.white],
        bounce: true,
        speedMultiplier: 0.012,
        autoInitialize: true,
        fadeOut: false,
      );

  // ----------------------------------------------------------
  // FIREWORKS
  // ----------------------------------------------------------

  static ParticleConfig fireworks({
    List<Color> colors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.blue,
      Colors.purple,
    ],
  }) =>
      ParticleConfig(
        maxParticles: 200,
        emissionRate: 100,
        particleLifespan: 2.0,
        minSpeed: 120,
        maxSpeed: 300,
        shape: ParticleShape.star,
        gravity: true,
        gravityStrength: 200,
        fadeOut: true,
        explosion: true,
        explosionForce: 250,
        blendMode: BlendMode.plus,
        colors: colors,
      );

  // ----------------------------------------------------------
  // SNOW
  // ----------------------------------------------------------

  static ParticleConfig snow({
    Color color = Colors.white,
  }) =>
      ParticleConfig(
        maxParticles: 150,
        emissionRate: 40,
        particleLifespan: 6.0, // float longer
        minSpeed: 10,
        maxSpeed: 25,
        minSize: 2,
        maxSize: 5,
        colors: [color],
        shape: ParticleShape.circle,
        gravity: true,
        gravityStrength: 20,
        wind: true,
        windDirection: const Offset(2, 0),
        fadeOut: false,
        autoInitialize: true,
      );

  // ----------------------------------------------------------
  // RAIN
  // ----------------------------------------------------------

  static ParticleConfig rain({
    Color color = const Color(0x8800BFFF),
    int maxParticles = 1000, // Increased for continuous sheet
    double emissionRate = 300, // Increased for continuous sheet
  }) =>
      ParticleConfig(
        maxParticles: maxParticles,
        emissionRate: emissionRate,
        particleLifespan: 1.5,
        minSpeed: 350,
        maxSpeed: 600,
        minSize: 1,
        maxSize: 2,
        shape: ParticleShape.line,
        gravity: true,
        gravityStrength: 900,
        wind: false,
        autoInitialize: true,
        colors: [color],
      );

  // ----------------------------------------------------------
  // MAGIC
  // ----------------------------------------------------------

  static ParticleConfig get magic => const ParticleConfig(
        maxParticles: 120,
        emissionRate: 60,
        particleLifespan: 2.5,
        minSpeed: 40,
        maxSpeed: 90,
        shape: ParticleShape.star,
        rainbow: true,
        randomRotation: true,
        fadeOut: true,
        blendMode: BlendMode.plus,
        trail: true,
      );

  // ----------------------------------------------------------
  // SMOKE
  // ----------------------------------------------------------

  static ParticleConfig smoke({
    List<Color> colors = const [
      Color(0x809E9E9E), // Colors.grey.withValues(alpha: 0.5)
      Color(0x4DFFFFFF), // Colors.white.withValues(alpha: 0.3)
    ],
  }) =>
      ParticleConfig(
        maxParticles: 80,
        emissionRate: 40,
        particleLifespan: 3.0,
        minSpeed: 20,
        maxSpeed: 60,
        minSize: 8,
        maxSize: 20,
        colors: colors,
        wind: true,
        windDirection: const Offset(0, -30),
        fadeOut: true,
      );

  // ----------------------------------------------------------
  // BUBBLES
  // ----------------------------------------------------------

  static ParticleConfig bubbles({
    List<Color> colors = const [
      Color(0x4400BFFF),
      Color(0x44FFFFFF),
    ],
  }) =>
      ParticleConfig(
        maxParticles: 100,
        emissionRate: 30,
        particleLifespan: 4.0,
        minSpeed: 30,
        maxSpeed: 60,
        minSize: 5,
        maxSize: 15,
        bounce: true,
        wind: true,
        windDirection: const Offset(0, -40),
        colors: colors,
      );

  // ----------------------------------------------------------
  // CONFETTI
  // ----------------------------------------------------------

  static ParticleConfig confetti({
    List<Color> colors = const [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ],
  }) =>
      ParticleConfig(
        maxParticles: 150,
        emissionRate: 90,
        particleLifespan: 2.0,
        minSpeed: 150,
        maxSpeed: 350,
        minSize: 4,
        maxSize: 8,
        randomRotation: true,
        gravity: true,
        gravityStrength: 200,
        explosion: true,
        explosionForce: 300,
        colors: colors,
      );

  // ----------------------------------------------------------
  // ENERGY FIELD
  // ----------------------------------------------------------

  static ParticleConfig get energyField => const ParticleConfig(
        maxParticles: 150,
        emissionRate: 50,
        particleLifespan: 3.0,
        minSpeed: 30,
        maxSpeed: 80,
        rainbow: true,
        connectParticles: true,
        connectionDistance: 85,
        connectionLineWidth: 0.8,
        magneticEffect: true,
        magneticStrength: 30,
        blendMode: BlendMode.plus,
        autoInitialize: true,
      );
}
