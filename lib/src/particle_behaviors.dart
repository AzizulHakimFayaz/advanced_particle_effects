import 'package:flutter/material.dart';
import 'particle.dart';

abstract class ParticleBehavior {
  void apply(Particle particle, double dt, Size canvasSize);
}

class GravityBehavior extends ParticleBehavior {
  final double strength;

  GravityBehavior(this.strength);

  @override
  void apply(Particle particle, double dt, Size canvasSize) {
    particle.acceleration = Offset(0, strength);
  }
}

class WindBehavior extends ParticleBehavior {
  final Offset direction;

  WindBehavior(this.direction);

  @override
  void apply(Particle particle, double dt, Size canvasSize) {
    particle.acceleration += direction;
  }
}

class MagneticBehavior extends ParticleBehavior {
  final Offset center;
  final double strength;

  MagneticBehavior(this.center, this.strength);

  @override
  void apply(Particle particle, double dt, Size canvasSize) {
    final direction = center - particle.position;
    final distance = direction.distance;
    if (distance > 0) {
      final force = direction / distance * strength / (distance * 0.1);
      particle.acceleration += force;
    }
  }
}

class BounceBehavior extends ParticleBehavior {
  final double damping;

  BounceBehavior({this.damping = 0.8});

  @override
  void apply(Particle particle, double dt, Size canvasSize) {
    if (particle.position.dx < 0 || particle.position.dx > canvasSize.width) {
      particle.velocity =
          Offset(-particle.velocity.dx * damping, particle.velocity.dy);
      particle.position = Offset(
        particle.position.dx.clamp(0, canvasSize.width),
        particle.position.dy,
      );
    }
    if (particle.position.dy < 0 || particle.position.dy > canvasSize.height) {
      particle.velocity =
          Offset(particle.velocity.dx, -particle.velocity.dy * damping);
      particle.position = Offset(
        particle.position.dx,
        particle.position.dy.clamp(0, canvasSize.height),
      );
    }
  }
}
