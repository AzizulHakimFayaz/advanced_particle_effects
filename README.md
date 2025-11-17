import 'package:flutter/material.dart';
import 'package:advanced_particle_effects/advanced_particle_effects.dart';

// ============================================
// SUPER EASY USAGE EXAMPLES
// ============================================

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Particle Effects - Easy Usage',
theme: ThemeData.dark(),
home: const EasyExamplesScreen(),
);
}
}

// ============================================
// EXAMPLE 1: DEFAULT (No customization needed!)
// ============================================

class Example1_Default extends StatelessWidget {
const Example1_Default({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Default - Just Works!')),
body: const NetworkedParticleSystem(), // That's it! ✨
);
}
}

// ============================================
// EXAMPLE 2: CHANGE PARTICLE COUNT
// ============================================

class Example2_ParticleCount extends StatelessWidget {
const Example2_ParticleCount({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Custom Particle Count')),
body: const NetworkedParticleSystem(
particleCount: 150, // More particles!
),
);
}
}

// ============================================
// EXAMPLE 3: CHANGE PARTICLE SIZE
// ============================================

class Example3_ParticleSize extends StatelessWidget {
const Example3_ParticleSize({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Big Particles')),
body: const NetworkedParticleSystem(
particleSize: 5.0, // Bigger particles!
),
);
}
}

// ============================================
// EXAMPLE 4: CHANGE COLORS
// ============================================

class Example4_Colors extends StatelessWidget {
const Example4_Colors({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Custom Colors')),
body: const NetworkedParticleSystem(
particleColor: Colors.cyan,  // Particle color
lineColor: Colors.blue,      // Line color
),
);
}
}

// ============================================
// EXAMPLE 5: CHANGE LINE WIDTH
// ============================================

class Example5_LineWidth extends StatelessWidget {
const Example5_LineWidth({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Thick Lines')),
body: const NetworkedParticleSystem(
lineWidth: 2.5, // Thicker lines!
),
);
}
}

// ============================================
// EXAMPLE 6: FULL CUSTOMIZATION
// ============================================

class Example6_FullCustomization extends StatelessWidget {
const Example6_FullCustomization({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Full Customization')),
body: const NetworkedParticleSystem(
particleCount: 120,              // Number of particles
particleSize: 3.0,                // Size of each particle
particleColor: Colors.purple,     // Particle color
lineColor: Colors.pink,           // Line color (optional)
lineWidth: 1.5,                   // Line thickness
connectionDistance: 100,          // Max distance for connections
speedMultiplier: 0.01,            // Movement speed
),
);
}
}

// ============================================
// EXAMPLE 7: INTERACTIVE - USER CONTROLS
// ============================================

class Example7_Interactive extends StatefulWidget {
const Example7_Interactive({Key? key}) : super(key: key);

@override
State<Example7_Interactive> createState() => _Example7_InteractiveState();
}

class _Example7_InteractiveState extends State<Example7_Interactive> {
// User controllable values with defaults
int particleCount = 100;
double particleSize = 2.0;
double lineWidth = 1.2;
double connectionDistance = 80.0;
double speed = 0.008;
Color particleColor = Colors.white;
Color lineColor = Colors.white;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(
title: const Text('Interactive Controls'),
),
body: Stack(
children: [
// Particle system with user values
NetworkedParticleSystem(
key: ValueKey('$particleCount-$particleSize-$lineWidth-$connectionDistance-$speed-$particleColor-$lineColor'),
particleCount: particleCount,
particleSize: particleSize,
particleColor: particleColor,
lineColor: lineColor,
lineWidth: lineWidth,
connectionDistance: connectionDistance,
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
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Particle Count
                    Text('Particle Count: $particleCount', style: const TextStyle(color: Colors.white)),
                    Slider(
                      value: particleCount.toDouble(),
                      min: 20,
                      max: 200,
                      divisions: 18,
                      label: particleCount.toString(),
                      onChanged: (value) => setState(() => particleCount = value.toInt()),
                    ),
                    const SizedBox(height: 8),
                    
                    // Particle Size
                    Text('Particle Size: ${particleSize.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white)),
                    Slider(
                      value: particleSize,
                      min: 1.0,
                      max: 8.0,
                      divisions: 14,
                      label: particleSize.toStringAsFixed(1),
                      onChanged: (value) => setState(() => particleSize = value),
                    ),
                    const SizedBox(height: 8),
                    
                    // Line Width
                    Text('Line Width: ${lineWidth.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white)),
                    Slider(
                      value: lineWidth,
                      min: 0.5,
                      max: 4.0,
                      divisions: 14,
                      label: lineWidth.toStringAsFixed(1),
                      onChanged: (value) => setState(() => lineWidth = value),
                    ),
                    const SizedBox(height: 8),
                    
                    // Connection Distance
                    Text('Connection Distance: ${connectionDistance.toInt()}', style: const TextStyle(color: Colors.white)),
                    Slider(
                      value: connectionDistance,
                      min: 40,
                      max: 150,
                      divisions: 11,
                      label: connectionDistance.toInt().toString(),
                      onChanged: (value) => setState(() => connectionDistance = value),
                    ),
                    const SizedBox(height: 8),
                    
                    // Speed
                    Text('Speed: ${(speed * 1000).toStringAsFixed(1)}', style: const TextStyle(color: Colors.white)),
                    Slider(
                      value: speed * 1000,
                      min: 3,
                      max: 20,
                      divisions: 17,
                      label: (speed * 1000).toStringAsFixed(1),
                      onChanged: (value) => setState(() => speed = value / 1000),
                    ),
                    const SizedBox(height: 16),
                    
                    // Color Presets
                    const Text('Colors:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ColorButton(
                          color: Colors.white,
                          onTap: () => setState(() {
                            particleColor = Colors.white;
                            lineColor = Colors.white;
                          }),
                        ),
                        _ColorButton(
                          color: Colors.cyan,
                          onTap: () => setState(() {
                            particleColor = Colors.cyan;
                            lineColor = Colors.blue;
                          }),
                        ),
                        _ColorButton(
                          color: Colors.purple,
                          onTap: () => setState(() {
                            particleColor = Colors.purple;
                            lineColor = Colors.pink;
                          }),
                        ),
                        _ColorButton(
                          color: Colors.green,
                          onTap: () => setState(() {
                            particleColor = Colors.green;
                            lineColor = Colors.lightGreen;
                          }),
                        ),
                        _ColorButton(
                          color: Colors.red,
                          onTap: () => setState(() {
                            particleColor: Colors.red;
                            lineColor = Colors.orange;
                          }),
                        ),
                        _ColorButton(
                          color: Colors.yellow,
                          onTap: () => setState(() {
                            particleColor = Colors.yellow;
                            lineColor = Colors.amber;
                          }),
                        ),
                      ],
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
}

class _ColorButton extends StatelessWidget {
final Color color;
final VoidCallback onTap;

const _ColorButton({required this.color, required this.onTap});

@override
Widget build(BuildContext context) {
return GestureDetector(
onTap: onTap,
child: Container(
width: 40,
height: 40,
decoration: BoxDecoration(
color: color,
shape: BoxShape.circle,
border: Border.all(color: Colors.white, width: 2),
),
),
);
}
}

// ============================================
// EXAMPLE 8: PRESET CONFIGURATIONS
// ============================================

class Example8_Presets extends StatefulWidget {
const Example8_Presets({Key? key}) : super(key: key);

@override
State<Example8_Presets> createState() => _Example8_PresetsState();
}

class _Example8_PresetsState extends State<Example8_Presets> {
int selectedPreset = 0;

final List<Map<String, dynamic>> presets = [
{
'name': 'Default',
'widget': const NetworkedParticleSystem(),
},
{
'name': 'Subtle',
'widget': const NetworkedParticleSystem(
particleCount: 60,
particleSize: 1.5,
speedMultiplier: 0.005,
),
},
{
'name': 'Dense',
'widget': const NetworkedParticleSystem(
particleCount: 150,
particleSize: 1.5,
connectionDistance: 70,
),
},
{
'name': 'Big & Bold',
'widget': const NetworkedParticleSystem(
particleCount: 80,
particleSize: 4.0,
lineWidth: 2.0,
),
},
{
'name': 'Fast',
'widget': const NetworkedParticleSystem(
speedMultiplier: 0.015,
),
},
{
'name': 'Slow',
'widget': const NetworkedParticleSystem(
speedMultiplier: 0.004,
),
},
{
'name': 'Cyan',
'widget': const NetworkedParticleSystem(
particleColor: Colors.cyan,
lineColor: Colors.blue,
),
},
{
'name': 'Purple',
'widget': const NetworkedParticleSystem(
particleColor: Colors.purple,
lineColor: Colors.pink,
),
},
];

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black,
appBar: AppBar(title: const Text('Preset Configurations')),
body: Stack(
children: [
presets[selectedPreset]['widget'] as Widget,
Positioned(
bottom: 20,
left: 0,
right: 0,
child: Center(
child: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.black87,
borderRadius: BorderRadius.circular(20),
),
child: Wrap(
spacing: 8,
children: List.generate(
presets.length,
(index) => ElevatedButton(
onPressed: () => setState(() => selectedPreset = index),
style: ElevatedButton.styleFrom(
backgroundColor: selectedPreset == index ? Colors.blue : Colors.grey[800],
),
child: Text(presets[index]['name'] as String),
),
),
),
),
),
),
],
),
);
}
}

// ============================================
// MAIN DEMO SCREEN - ALL EXAMPLES
// ============================================

class EasyExamplesScreen extends StatelessWidget {
const EasyExamplesScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Easy Particle Effects Examples'),
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
_ExampleCard(
title: '1. Default (No Setup)',
description: 'Just add the widget - it works!',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example1_Default()),
),
),
_ExampleCard(
title: '2. Custom Particle Count',
description: 'Control how many particles',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example2_ParticleCount()),
),
),
_ExampleCard(
title: '3. Custom Particle Size',
description: 'Make particles bigger or smaller',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example3_ParticleSize()),
),
),
_ExampleCard(
title: '4. Custom Colors',
description: 'Choose particle and line colors',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example4_Colors()),
),
),
_ExampleCard(
title: '5. Custom Line Width',
description: 'Make connection lines thicker',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example5_LineWidth()),
),
),
_ExampleCard(
title: '6. Full Customization',
description: 'All options at once',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example6_FullCustomization()),
),
),
_ExampleCard(
title: '7. Interactive Controls',
description: 'Let users customize everything!',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example7_Interactive()),
),
),
_ExampleCard(
title: '8. Preset Configurations',
description: 'Ready-made beautiful effects',
onTap: () => Navigator.push(
context,
MaterialPageRoute(builder: (_) => const Example8_Presets()),
),
),
],
),
);
}
}

class _ExampleCard extends StatelessWidget {
final String title;
final String description;
final VoidCallback onTap;

const _ExampleCard({
required this.title,
required this.description,
required this.onTap,
});

@override
Widget build(BuildContext context) {
return Card(
margin: const EdgeInsets.only(bottom: 12),
child: ListTile(
title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text(description),
trailing: const Icon(Icons.arrow_forward_ios),
onTap: onTap,
),
);
}
}

// ============================================
// QUICK REFERENCE
// ============================================

/*

ALL AVAILABLE OPTIONS:
=====================

NetworkedParticleSystem(
// Number of particles (default: 100)
particleCount: 100,

// Size of each particle (default: 2.0)
particleSize: 2.0,

// Color of particles (default: Colors.white)
particleColor: Colors.cyan,

// Color of lines (default: same as particleColor)
lineColor: Colors.blue,

// Width of connection lines (default: 1.2)
lineWidth: 1.5,

// Max distance for connections (default: 80)
connectionDistance: 100,

// Speed control (default: 0.008)
speedMultiplier: 0.01,

// Show connection lines (default: true)
showConnections: true,

// Bounce off edges (default: true)
bounce: true,
)

EXAMPLES:
=========

// 1. Default
NetworkedParticleSystem()

// 2. More particles
NetworkedParticleSystem(particleCount: 150)

// 3. Big particles
NetworkedParticleSystem(particleSize: 5.0)

// 4. Custom colors
NetworkedParticleSystem(
particleColor: Colors.purple,
lineColor: Colors.pink,
)

// 5. Thick lines
NetworkedParticleSystem(lineWidth: 2.5)

// 6. Fast movement
NetworkedParticleSystem(speedMultiplier: 0.015)

// 7. Everything custom
NetworkedParticleSystem(
particleCount: 120,
particleSize: 3.0,
particleColor: Colors.green,
lineColor: Colors.lightGreen,
lineWidth: 1.8,
connectionDistance: 90,
speedMultiplier: 0.01,
)

*/