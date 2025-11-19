import 'package:flutter/material.dart';
import 'package:advanced_particle_effects/advanced_particle_effects.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Particle Effects Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const ParticleDemo(),
    );
  }
}

class ParticleDemo extends StatefulWidget {
  const ParticleDemo({super.key});

  @override
  State<ParticleDemo> createState() => _ParticleDemoState();
}

class _ParticleDemoState extends State<ParticleDemo> {
  // --------------------------------------------
  // PRESETS LIST
  // --------------------------------------------
  final Map<String, ParticleConfig> particleConfigs = {
    "Network Particles": ParticleConfig.networkParticles,
    "Subtle Network": ParticleConfig.subtleNetwork,
    "Dense Network": ParticleConfig.denseNetwork,
    "Snow": ParticleConfig.snow(),
    "Rain": ParticleConfig.rain(),
    "Fireworks": ParticleConfig.fireworks(),
    "Magic Glow": ParticleConfig.magic,
    "Smoke": ParticleConfig.smoke(),
    "Bubbles": ParticleConfig.bubbles(),
    "Confetti": ParticleConfig.confetti(),
    "Energy Field": ParticleConfig.energyField,
  };

  late List<String> allDemos;
  String selectedDemo = "Network Particles";

  @override
  void initState() {
    super.initState();
    allDemos = ["Split Screen", ...particleConfigs.keys];
  }

  // --------------------------------------------
  // --------------------------------------------
  final Map<String, ParticleShape> shapes = {
    "Circle": ParticleShape.circle,
    "Square": ParticleShape.square,
    "Triangle": ParticleShape.triangle,
    "Star": ParticleShape.star,
    "Heart": ParticleShape.heart,
    "Diamond": ParticleShape.diamond,
    "Line": ParticleShape.line,
  };

  String selectedShape = "Circle";

  // Manual parameters (affect renderer layer)
  double lineWidth = 1.2;
  double connectionDistance = 90;

  @override
  Widget build(BuildContext context) {
    Widget demoWidget;

    if (selectedDemo == "Split Screen") {
      demoWidget = const SplitScreenParticleSystem(
        splitPosition: 0.5,
        splitAngle: 0.2,
        leftBackgroundColor: Colors.white,
        rightBackgroundColor: Colors.black,
        leftParticleColor: Colors.black,
        rightParticleColor: Colors.white,
        particleCount: 150,
        speedMultiplier: 0.005,
      );
    } else {
      ParticleConfig baseConfig = particleConfigs[selectedDemo]!;

      // override shape / line fields if applicable
      ParticleConfig updatedConfig = baseConfig.copyWith(
        shape: shapes[selectedShape]!,
        connectionLineWidth: lineWidth,
        connectionDistance: connectionDistance,
      );

      demoWidget = ParticleSystem(
        key: ValueKey(selectedDemo + selectedShape + lineWidth.toString()),
        config: updatedConfig,
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Advanced Particle Effects Demo'),
        backgroundColor: Colors.black87,
      ),
      body: Stack(
        children: [
          /// PARTICLE SYSTEM
          demoWidget,

          /// CONTROL PANEL
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: _controlPanel(),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------
  // CONTROL PANEL UI
  // --------------------------------------------
  Widget _controlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------------
          // PRESET SELECTOR
          //--------------------------------------
          const Text(
            "Select Demo",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            dropdownColor: Colors.black,
            value: selectedDemo,
            items: allDemos.map((name) {
              return DropdownMenuItem(
                value: name,
                child: Text(name, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (v) => setState(() => selectedDemo = v!),
            decoration: inputStyle(),
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white24),

          //--------------------------------------
          // SHAPE SELECTOR
          //--------------------------------------
          const Text(
            "Particle Shape",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            dropdownColor: Colors.black,
            value: selectedShape,
            items: shapes.keys.map((s) {
              return DropdownMenuItem(
                value: s,
                child: Text(s, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (v) => setState(() => selectedShape = v!),
            decoration: inputStyle(),
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white24),

          //--------------------------------------
          // LINE WIDTH SLIDER
          //--------------------------------------
          const Text(
            "Line Width (for Network / Energy modes)",
            style: TextStyle(color: Colors.white70),
          ),
          Slider(
            value: lineWidth,
            min: 0.2,
            max: 5,
            divisions: 25,
            label: lineWidth.toStringAsFixed(1),
            activeColor: Colors.blue,
            onChanged: (v) => setState(() => lineWidth = v),
          ),

          //--------------------------------------
          // CONNECTION DISTANCE
          //--------------------------------------
          const Text(
            "Connection Distance",
            style: TextStyle(color: Colors.white70),
          ),
          Slider(
            value: connectionDistance,
            min: 20,
            max: 200,
            divisions: 36,
            label: connectionDistance.toStringAsFixed(0),
            activeColor: Colors.blue,
            onChanged: (v) => setState(() => connectionDistance = v),
          ),
        ],
      ),
    );
  }

  InputDecoration inputStyle() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
