import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;
import 'particle.dart';
import 'particle_painter.dart';
import 'particle_emitter.dart';
import 'particle_configs.dart';
import 'particle_behaviors.dart';

class ParticleSystem extends StatefulWidget {
  final ParticleConfig config;
  final Offset? emissionPoint;
  final bool autoStart;
  final VoidCallback? onComplete;

  final dynamic position;

  const ParticleSystem({
    super.key,
    required this.config,
    this.emissionPoint,
    this.position = Offset.zero,
    this.autoStart = true,
    this.onComplete,
  });

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

class _ParticleSystemState extends State<ParticleSystem>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final List<Particle> _particles = [];
  ParticleEmitter? _emitter;
  Duration _lastElapsed = Duration.zero;
  final List<ParticleBehavior> _behaviors = [];
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    _emitter = ParticleEmitter(
      config: widget.config,
      position: widget.position,
    );

    _setupBehaviors();

    _ticker = createTicker(_onTick);

    if (widget.autoStart) {
      _ticker.start();
    }
  }

  void _setupBehaviors() {
    if (widget.config.gravity) {
      _behaviors.add(GravityBehavior(widget.config.gravityStrength));
    }
    if (widget.config.wind) {
      _behaviors.add(WindBehavior(widget.config.windDirection));
    }
    if (widget.config.magneticEffect) {
      _behaviors.add(MagneticBehavior(
        widget.config.magneticCenter,
        widget.config.magneticStrength,
      ));
    }
    if (widget.config.bounce) {
      _behaviors.add(BounceBehavior());
    }
  }

  // NEW! Initialize particles spread out like your code
  void _initializeParticles(Size size) {
    if (_initialized) return;
    _initialized = true;

    if (!widget.config.autoInitialize) return;

    final random = math.Random();
    for (int i = 0; i < widget.config.maxParticles; i++) {
      final speed = widget.config.minSpeed +
          random.nextDouble() *
              (widget.config.maxSpeed - widget.config.minSpeed);

      Color color;
      if (widget.config.rainbow) {
        color = HSVColor.fromAHSV(1.0, random.nextDouble() * 360, 1.0, 1.0)
            .toColor();
      } else {
        color =
            widget.config.colors[random.nextInt(widget.config.colors.length)];
      }

      _particles.add(Particle(
        position: Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        velocity: Offset(
          (random.nextDouble() - 0.5) * speed,
          (random.nextDouble() - 0.5) * speed,
        ),
        color: color,
        size: widget.config.minSize +
            random.nextDouble() *
                (widget.config.maxSize - widget.config.minSize),
        life: widget.config.particleLifespan,
        shape: widget.config.shape,
      ));
    }
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;

    setState(() {
      final size = MediaQuery.of(context).size;

      // Initialize if needed
      _initializeParticles(size);

      // Initialize emitter if needed (for non-auto-initialize mode)
      if (widget.config.emissionRate > 0) {
        _emitter ??= ParticleEmitter(
          config: widget.config,
          position:
              widget.emissionPoint ?? Offset(size.width / 2, size.height / 2),
        );

        // Emit new particles
        if (_particles.length < widget.config.maxParticles) {
          _particles.addAll(_emitter!.emit(dt));
        }
      }

      // Update particles - EXACTLY LIKE YOUR CODE
      for (final particle in _particles) {
        // Apply behaviors
        particle.acceleration = Offset.zero;
        for (final behavior in _behaviors) {
          behavior.apply(particle, dt, size);
        }

        particle.update(dt);
      }

      // Remove dead particles (only if fadeOut is enabled)
      if (widget.config.fadeOut) {
        _particles.removeWhere((p) => p.isDead);
      }

      // Check for completion
      if (_particles.isEmpty && widget.onComplete != null) {
        widget.onComplete!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: ParticlePainter(_particles, widget.config),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
