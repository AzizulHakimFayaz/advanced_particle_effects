import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_particle_effects/advanced_particle_effects.dart';
import 'package:flutter/material.dart';

void main() {
  group('Particle Tests', () {
    test('Particle should be created with correct properties', () {
      final particle = Particle(
        position: const Offset(100, 100),
        velocity: const Offset(5, 5),
        color: Colors.white,
        size: 3.0,
        life: 1.0,
      );

      expect(particle.position, const Offset(100, 100));
      expect(particle.velocity, const Offset(5, 5));
      expect(particle.color, Colors.white);
      expect(particle.size, 3.0);
      expect(particle.life, 1.0);
    });

    test('Particle should update position based on velocity', () {
      final particle = Particle(
        position: const Offset(0, 0),
        velocity: const Offset(10, 10),
        color: Colors.white,
        size: 2.0,
      );

      particle.update(1.0); // Update with 1 second delta

      expect(particle.position.dx, greaterThan(0));
      expect(particle.position.dy, greaterThan(0));
    });

    test('Particle isDead should return true when life is 0', () {
      final particle = Particle(
        position: const Offset(0, 0),
        velocity: const Offset(0, 0),
        color: Colors.white,
        size: 2.0,
        life: 0.0,
      );

      expect(particle.isDead, true);
    });

    test('Particle isDead should return false when life is above 0', () {
      final particle = Particle(
        position: const Offset(0, 0),
        velocity: const Offset(0, 0),
        color: Colors.white,
        size: 2.0,
        life: 0.5,
      );

      expect(particle.isDead, false);
    });
  });

  group('ParticleConfig Tests', () {
    test('ParticleConfig should have correct default values', () {
      const config = ParticleConfig();

      expect(config.maxParticles, 100);
      expect(config.emissionRate, 50);
      expect(config.minSize, 2.0);
      expect(config.maxSize, 6.0);
      expect(config.bounce, false);
      expect(config.gravity, false);
      expect(config.connectParticles, false);
    });

    test('ParticleConfig.fireworks should have correct properties', () {
      final config = ParticleConfig.fireworks();

      expect(config.maxParticles, 200);
      expect(config.gravity, true);
      expect(config.explosion, true);
      expect(config.fadeOut, true);
    });

    test('ParticleConfig.snow should have correct properties', () {
      final config = ParticleConfig.snow();

      expect(config.gravity, true);
      expect(config.wind, true);
      expect(config.colors.length, 1);
      expect(config.colors.first, Colors.white);
    });

    test('ParticleConfig.networkParticles should have correct properties', () {
      final config = ParticleConfig.networkParticles;

      expect(config.connectParticles, true);
      expect(config.bounce, true);
      expect(config.emissionRate, 0);
      expect(config.fadeOut, false);
      expect(config.autoInitialize, true);
    });
  });

  group('ParticleShape Tests', () {
    test('ParticleShape enum should have all shapes', () {
      expect(ParticleShape.values.length, 7);
      expect(ParticleShape.values.contains(ParticleShape.circle), true);
      expect(ParticleShape.values.contains(ParticleShape.square), true);
      expect(ParticleShape.values.contains(ParticleShape.triangle), true);
      expect(ParticleShape.values.contains(ParticleShape.star), true);
      expect(ParticleShape.values.contains(ParticleShape.heart), true);
      expect(ParticleShape.values.contains(ParticleShape.diamond), true);
      expect(ParticleShape.values.contains(ParticleShape.line), true);
    });
  });

  group('NetworkedParticleSystem Widget Tests', () {
    testWidgets('NetworkedParticleSystem should render',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NetworkedParticleSystem(),
          ),
        ),
      );

      expect(find.byType(NetworkedParticleSystem), findsOneWidget);
    });

    testWidgets('NetworkedParticleSystem should accept custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NetworkedParticleSystem(
              particleCount: 150,
              particleSize: 3.0,
              particleColor: Colors.cyan,
            ),
          ),
        ),
      );

      expect(find.byType(NetworkedParticleSystem), findsOneWidget);
    });
  });

  group('ParticleSystem Widget Tests', () {
    testWidgets('ParticleSystem should render with config',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ParticleSystem(
              config: ParticleConfig.fireworks(),
            ),
          ),
        ),
      );

      expect(find.byType(ParticleSystem), findsOneWidget);
    });
  });

  group('ParticleBehavior Tests', () {
    test('GravityBehavior should apply downward force', () {
      final behavior = GravityBehavior(100.0);
      final particle = Particle(
        position: const Offset(100, 100),
        velocity: const Offset(0, 0),
        color: Colors.white,
        size: 2.0,
      );

      behavior.apply(particle, 0.016, const Size(800, 600));

      expect(particle.acceleration.dy, 100.0);
    });

    test('WindBehavior should apply horizontal force', () {
      final behavior = WindBehavior(const Offset(50, 0));
      final particle = Particle(
        position: const Offset(100, 100),
        velocity: const Offset(0, 0),
        color: Colors.white,
        size: 2.0,
      );

      behavior.apply(particle, 0.016, const Size(800, 600));

      expect(particle.acceleration.dx, 50.0);
    });

    test('BounceBehavior should reverse velocity at edges', () {
      final behavior = BounceBehavior();
      final particle = Particle(
        position: const Offset(-10, 100),
        velocity: const Offset(-5, 0),
        color: Colors.white,
        size: 2.0,
      );

      behavior.apply(particle, 0.016, const Size(800, 600));

      expect(particle.velocity.dx, greaterThan(0));
    });
  });

  group('Integration Tests', () {
    test('Particle system should work with all presets', () {
      final presets = [
        ParticleConfig.fireworks(),
        ParticleConfig.snow(),
        ParticleConfig.rain(),
        ParticleConfig.confetti(),
        ParticleConfig.bubbles(),
        ParticleConfig.magic,
        ParticleConfig.smoke(),
        ParticleConfig.energyField,
        ParticleConfig.networkParticles,
        ParticleConfig.subtleNetwork,
        ParticleConfig.denseNetwork,
      ];

      for (final preset in presets) {
        expect(preset.maxParticles, greaterThan(0));
        expect(preset.minSize, greaterThan(0));
        expect(preset.maxSize, greaterThanOrEqualTo(preset.minSize));
      }
    });
  });
}
