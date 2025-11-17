import 'package:flutter/material.dart';
import 'package:advanced_particle_effects/advanced_particle_effects.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const ParticleDemo({Key? key}) : super(key: key);

  @override
  State<ParticleDemo> createState() => _ParticleDemoState();
}

class _ParticleDemoState extends State<ParticleDemo> {
  // User controllable values
  int particleCount = 100;
  double particleSize = 2.0;
  double lineWidth = 1.2;
  double speed = 0.008;
  Color particleColor = Colors.white;
  Color lineColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Advanced Particle Effects Demo'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfo(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Particle effect
          NetworkedParticleSystem(
            key: ValueKey('$particleCount-$particleSize-$lineWidth-$speed-$particleColor-$lineColor'),
            particleCount: particleCount,
            particleSize: particleSize,
            particleColor: particleColor,
            lineColor: lineColor,
            lineWidth: lineWidth,
            speedMultiplier: speed,
          ),

          // Control panel
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Controls',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 8),

                    // Particle Count
                    _buildSlider(
                      'Particle Count',
                      particleCount.toDouble(),
                      20,
                      200,
                      particleCount.toString(),
                          (value) => setState(() => particleCount = value.toInt()),
                    ),

                    // Particle Size
                    _buildSlider(
                      'Particle Size',
                      particleSize,
                      1.0,
                      8.0,
                      particleSize.toStringAsFixed(1),
                          (value) => setState(() => particleSize = value),
                    ),

                    // Line Width
                    _buildSlider(
                      'Line Width',
                      lineWidth,
                      0.5,
                      4.0,
                      lineWidth.toStringAsFixed(1),
                          (value) => setState(() => lineWidth = value),
                    ),

                    // Speed
                    _buildSlider(
                      'Speed',
                      speed * 1000,
                      3,
                      20,
                      (speed * 1000).toStringAsFixed(1),
                          (value) => setState(() => speed = value / 1000),
                    ),

                    const SizedBox(height: 16),

                    // Color Presets
                    const Text(
                      'Color Presets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _colorButton('White', Colors.white, Colors.white),
                        _colorButton('Cyan', Colors.cyan, Colors.blue),
                        _colorButton('Purple', Colors.purple, Colors.pink),
                        _colorButton('Green', Colors.green, Colors.lightGreen),
                        _colorButton('Red', Colors.red, Colors.orange),
                        _colorButton('Yellow', Colors.yellow, Colors.amber),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Reset button
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            particleCount = 100;
                            particleSize = 2.0;
                            lineWidth = 1.2;
                            speed = 0.008;
                            particleColor = Colors.white;
                            lineColor = Colors.white;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset to Default'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
      String label,
      double value,
      double min,
      double max,
      String displayValue,
      ValueChanged<double> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Text(
              displayValue,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[700],
          onChanged: onChanged,
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _colorButton(String name, Color particle, Color line) {
    return GestureDetector(
      onTap: () => setState(() {
        particleColor = particle;
        lineColor = line;
      }),
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: particle,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: particleColor == particle ? 3 : 1,
              ),
              boxShadow: particleColor == particle
                  ? [
                BoxShadow(
                  color: particle.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ]
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: particleColor == particle ? Colors.white : Colors.white60,
              fontSize: 11,
              fontWeight: particleColor == particle
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Advanced Particle Effects Package\n\n'
              'Features:\n'
              '• Customizable particle count\n'
              '• Adjustable particle size\n'
              '• Custom colors\n'
              '• Connection lines\n'
              '• Speed control\n'
              '• Bounce physics\n\n'
              'Try adjusting the sliders and colors!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}