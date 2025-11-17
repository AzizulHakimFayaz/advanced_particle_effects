🎇 Advanced Particle Effects

Beautiful, customizable, animated particle network effects for Flutter.

A lightweight and powerful Flutter widget to create mesmerizing particle networks with smooth animations and full customization options.

🌟 Features

🚀 Plug & Play — works with just a single widget

🎨 Fully customizable (colors, size, speed, number of particles, distance, etc.)

⚡ Ultra-smooth animations

🧩 Preset themes included

🖐 Interactive demo with live controls

💻 Supports Android, iOS, Web, Windows, macOS, Linux

🧪 Example app included

🎯 Ideal for landing pages, app intros, hero backgrounds, login screens & more

📦 Installation

Add the package to your pubspec.yaml:

dependencies:
advanced_particle_effects: ^1.0.0


Install:

flutter pub get


Import:

import 'package:advanced_particle_effects/advanced_particle_effects.dart';
## 🚀 Quick Start

Add the widget anywhere in your Flutter layout:

```dart
import 'package:flutter/material.dart';
import 'package:advanced_particle_effects/advanced_particle_effects.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Particle Effects Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const QuickStartDemo(),
    );
  }
}

class QuickStartDemo extends StatelessWidget {
  const QuickStartDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: NetworkedParticleSystem(
        particleCount: 100,
        particleSize: 2.0,
        lineWidth: 1.2,
        particleColor: Colors.white,
        lineColor: Colors.white,
        speedMultiplier: 0.008,
      ),
    );
  }
}
```




NetworkedParticleSystem();


That’s it! ✨

🎛 Customization

Here’s a fully customized example:
```
NetworkedParticleSystem(
particleCount: 120,
particleSize: 3.0,
particleColor: Colors.purple,
lineColor: Colors.pink,
lineWidth: 1.5,
connectionDistance: 100,
speedMultiplier: 0.01,
);
```
📚 Examples (Included in Example App)
1. Default – No Setup Needed
   const NetworkedParticleSystem();

2. Custom Particle Count
   NetworkedParticleSystem(
   particleCount: 150,
   );

3. Custom Particle Size
   NetworkedParticleSystem(
   particleSize: 5.0,
   );

4. Custom Colors
   NetworkedParticleSystem(
   particleColor: Colors.cyan,
   lineColor: Colors.blue,
   );

5. Thick Lines
   NetworkedParticleSystem(
   lineWidth: 2.5,
   );

6. Fully Customized
   NetworkedParticleSystem(
   particleCount: 120,
   particleSize: 3.0,
   particleColor: Colors.green,
   lineColor: Colors.lightGreen,
   lineWidth: 1.8,
   connectionDistance: 90,
   speedMultiplier: 0.01,
   );

7. Interactive Controls Demo

A complete UI allowing live adjustments:

Particle count

Particle size

Line width

Speed

Connection distance

Color presets

Example7_Interactive();

8. Preset Themes

Ready-made beautiful effects:

Default

Subtle

Dense

Big & Bold

Fast

Slow

Cyan

Purple

Example8_Presets();

🎨 Preset Theme List
```
Name	Description
Default	Standard white particles
Subtle	Slow and light
Dense	High particle count with tight links
Big & Bold	Large particles and thick lines
Fast	Increased speed
Slow	Very slow animation
Cyan	Cool neon cyan theme
Purple	Neon purple/pink theme
⚙️ API Reference
Property	Type	Default	Description
particleCount	int	100	Number of particles
particleSize	double	2.0	Size of particles
particleColor	Color	Colors.white	Particle color
lineColor	Color?	same as particleColor	Color of connecting lines
lineWidth	double	1.2	Thickness of lines
connectionDistance	double	80	Max distance for connecting lines
speedMultiplier	double	0.008	Movement speed
showConnections	bool	true	Whether lines are drawn
bounce	bool	true	Particles bounce inside boundaries
```
🧪 Example App

The package includes a full example project showing:
 demo screens

Interactive settings panel

All customization options

Preset themes

Run the example:

flutter run example/lib/main.dart

📸 Screenshots / Preview
![Screenshot](example/screen1.png)

🤝 Contributing

Contributions are welcome!
Feel free to open a PR or file an issue.

⭐ Support

If you like this package, please give it a ⭐ on pub.dev or GitHub — it helps a lot!