import 'package:flutter/material.dart';
import '../react_flutter/react_flutter.dart';

/// Sample: Flutter developer writing in normal Dart style.
/// This screen uses standard Flutter widgets alongside react_flutter.
class FlutterDevSampleScreen extends StatefulWidget {
  const FlutterDevSampleScreen({super.key});

  @override
  State<FlutterDevSampleScreen> createState() => _FlutterDevSampleScreenState();
}

class _FlutterDevSampleScreenState extends State<FlutterDevSampleScreen> {
  int _counter = 0;
  final List<String> _items = ['Flutter', 'React', 'Dart', 'JavaScript'];

  @override
  Widget build(BuildContext context) {
    // ── Flutter dev viết bình thường nhưng vẫn có thể dùng react_flutter ──
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dev Style'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfo(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flutter dev dùng widget thuần
            const Text(
              'Counter (Flutter native)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Count: $_counter',
                    style: const TextStyle(fontSize: 22),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => setState(() => _counter--),
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () => setState(() => _counter++),
                        icon: const Icon(Icons.add_circle_outline),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Flutter dev có thể mix với react_flutter elements
            H3('Tech Stack', style: Style(color: '#333')),
            const SizedBox(height: 12),
            Ul(
              gap: 10,
              children: _items
                  .map(
                    (item) => Li(
                      text: item,
                      style: Style(fontSize: 15, color: '#444'),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 28),

            // Flutter dev dùng native widgets xen kẽ react_flutter
            const Text(
              'Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._buildFeatureCards(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatureCards() {
    final features = [
      ('🟦', 'React-style API', 'Div, H1-H6, Button, Input...'),
      ('🟠', 'Flutter normal', 'Container, Column, Text...'),
      ('⚡', 'Mix freely', 'Dùng cả hai trong cùng một file'),
    ];

    return features.map((f) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        // Flutter dev dùng react_flutter Div ở đây
        child: Div(
          style: Style(
            display: 'flex',
            flexDirection: 'row',
            alignItems: 'center',
            backgroundColor: '#ffffff',
            borderRadius: 10,
            padding: 14,
            gap: 12,
            boxShadow: [
              const BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          children: [
            Text(f.$1, style: const TextStyle(fontSize: 28)),
            Expanded(
              child: Div(
                children: [
                  Strong(f.$2),
                  const SizedBox(height: 2),
                  Small(f.$3),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('react_gen_flutter'),
        content: const Text(
          'Một Flutter project nơi:\n\n'
          '• React/web devs dùng HTML-style API\n'
          '• Flutter devs code bình thường\n'
          '• Cả hai cùng compile trong một app',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
