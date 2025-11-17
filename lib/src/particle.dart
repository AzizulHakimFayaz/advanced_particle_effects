import 'package:flutter/material.dart';
import 'dart:math' as math;

class Particle {
  Offset position;
  Offset velocity;
  Color color;
  double size;
  double life; // 0.0 to 1.0
  double rotation;
  double rotationSpeed;
  double opacity;
  ParticleShape shape;
  Offset acceleration;

  Particle({
    required this.position,
    required this.velocity,
    required this.color,
    this.size = 4.0,
    this.life = 1.0,
    this.rotation = 0.0,
    this.rotationSpeed = 0.0,
    this.opacity = 1.0,
    this.shape = ParticleShape.circle,
    this.acceleration = Offset.zero,
  });

  void update(double dt) {
    velocity += acceleration * dt;
    position += velocity * dt;
    rotation += rotationSpeed * dt;
    life -= dt * 0.5;
    opacity = life.clamp(0.0, 1.0);
  }

  bool get isDead => life <= 0;
}

enum ParticleShape {
  circle,
  square,
  triangle,
  star,
  heart,
  diamond,
  line,
}