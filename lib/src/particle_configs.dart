import 'package:flutter/material.dart';
import 'particle.dart';

class ParticleConfig {
  final int maxParticles;
  final double emissionRate;
  final double particleLifespan;
  final double minSize;
  final double maxSize;
  final double minSpeed;
  final double maxSpeed;
  final List<Color> colors;
  final ParticleShape shape;
  final bool connectParticles;
  final double connectionDistance;
  final double connectionLineWidth; // NEW!
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
  final double speedMultiplier; // NEW! Control for speed like your code
  final bool autoInitialize; // NEW! Start with particles spread out

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
    this.connectionLineWidth = 1.0, // NEW!
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
    this.speedMultiplier = 1.0, // NEW!
    this.autoInitialize = false, // NEW!
  });

  // NEW! Exact replica of your code's behavior
  static ParticleConfig get networkParticles => const ParticleConfig(
        maxParticles: 100,
        emissionRate: 0, // No continuous emission
        minSpeed: 0.5,
        maxSpeed: 1.5,
        minSize: 2.0,
        maxSize: 2.0,
        colors: [Colors.white, Colors.black],
        shape: ParticleShape.circle,
        connectParticles: true,
        connectionDistance: 80,
        connectionLineWidth: 1.2, // Your value
        fadeOut: false,
        bounce: true,
        speedMultiplier: 0.008, // Your exact speed
        autoInitialize: true, // Start spread out
      );

  static ParticleConfig get fireworks => const ParticleConfig(
        maxParticles: 200,
        emissionRate: 100,
        minSpeed: 100,
        maxSpeed: 300,
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.blue,
          Colors.purple
        ],
        shape: ParticleShape.star,
        gravity: true,
        fadeOut: true,
        explosion: true,
        explosionForce: 250,
        blendMode: BlendMode.plus,
      );

  static ParticleConfig get snow => const ParticleConfig(
        maxParticles: 150,
        emissionRate: 30,
        minSpeed: 20,
        maxSpeed: 50,
        minSize: 2,
        maxSize: 5,
        colors: [Colors.white],
        shape: ParticleShape.circle,
        gravity: true,
        gravityStrength: 30,
        wind: true,
        windDirection: Offset(15, 0),
      );

  static ParticleConfig get magic => const ParticleConfig(
        maxParticles: 120,
        emissionRate: 60,
        minSpeed: 30,
        maxSpeed: 80,
        rainbow: true,
        shape: ParticleShape.star,
        randomRotation: true,
        fadeOut: true,
        blendMode: BlendMode.plus,
        trail: true,
      );

  static ParticleConfig get smoke => ParticleConfig(
        maxParticles: 80,
        emissionRate: 40,
        minSpeed: 20,
        maxSpeed: 60,
        minSize: 8,
        maxSize: 20,
        colors: [Colors.grey.withOpacity(0.5), Colors.white.withOpacity(0.3)],
        shape: ParticleShape.circle,
        gravity: false,
        wind: true,
        windDirection: const Offset(0, -30),
        fadeOut: true,
      );

  static ParticleConfig get rain => const ParticleConfig(
        maxParticles: 200,
        emissionRate: 100,
        minSpeed: 300,
        maxSpeed: 500,
        minSize: 1,
        maxSize: 2,
        colors: [Color(0x8800BFFF)],
        shape: ParticleShape.line,
        gravity: true,
        gravityStrength: 500,
      );

  static ParticleConfig get bubbles => const ParticleConfig(
        maxParticles: 100,
        emissionRate: 30,
        minSpeed: 30,
        maxSpeed: 80,
        minSize: 5,
        maxSize: 15,
        colors: [Color(0x4400BFFF), Color(0x44FFFFFF)],
        shape: ParticleShape.circle,
        gravity: false,
        wind: true,
        windDirection: Offset(0, -50),
        bounce: true,
      );

  static ParticleConfig get confetti => const ParticleConfig(
        maxParticles: 150,
        emissionRate: 80,
        minSpeed: 150,
        maxSpeed: 350,
        minSize: 4,
        maxSize: 8,
        colors: [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.purple,
          Colors.orange,
        ],
        shape: ParticleShape.square,
        gravity: true,
        gravityStrength: 200,
        randomRotation: true,
        explosion: true,
        explosionForce: 300,
      );

  static ParticleConfig get energyField => const ParticleConfig(
        maxParticles: 150,
        emissionRate: 50,
        minSpeed: 40,
        maxSpeed: 100,
        rainbow: true,
        connectParticles: true,
        connectionDistance: 80,
        connectionLineWidth: 0.8,
        blendMode: BlendMode.plus,
        magneticEffect: true,
        magneticStrength: 30,
        autoInitialize: true,
      );

  // NEW! More presets like your code
  static ParticleConfig get subtleNetwork => const ParticleConfig(
        maxParticles: 60,
        emissionRate: 0,
        minSpeed: 0.3,
        maxSpeed: 1.0,
        minSize: 1.5,
        maxSize: 2.5,
        colors: [Colors.white70, Colors.black87],
        connectParticles: true,
        connectionDistance: 100,
        connectionLineWidth: 0.8,
        fadeOut: false,
        bounce: true,
        speedMultiplier: 0.006,
        autoInitialize: true,
      );

  static ParticleConfig get denseNetwork => const ParticleConfig(
        maxParticles: 150,
        emissionRate: 0,
        minSpeed: 0.4,
        maxSpeed: 1.2,
        minSize: 1.5,
        maxSize: 2.5,
        colors: [Colors.white, Colors.black],
        connectParticles: true,
        connectionDistance: 70,
        connectionLineWidth: 1.0,
        fadeOut: false,
        bounce: true,
        speedMultiplier: 0.007,
        autoInitialize: true,
      );
}
