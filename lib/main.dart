import 'package:flutter/material.dart';
import 'react_flutter/react_flutter.dart';
import 'samples/web_dev_sample.dart';
import 'samples/flutter_dev_sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'react_gen_flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

/// Home screen — lets you pick between React-style or Flutter-style demo.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SingleChildScrollView(
        child: Div(
          style: Style(
            minHeight: MediaQuery.of(context).size.height,
            padding: 32,
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
          ),
          children: [
            // Header
            Div(
              style: Style(
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                marginBottom: 48,
              ),
              children: [
                // Logo
                Div(
                  style: Style(
                    backgroundColor: '#6c63ff',
                    borderRadius: 20,
                    width: 80,
                    height: 80,
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    justifyContent: 'center',
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0x4D6C63FF),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.compare_arrows_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                H1('react_gen_flutter', style: Style(color: '#1a1a2e')),
                const SizedBox(height: 10),
                P(
                  'Một codebase, hai cách viết code',
                  style: Style(
                    color: '#6c63ff',
                    fontSize: 16,
                    fontWeight: '500',
                  ),
                ),
                const SizedBox(height: 8),
                P(
                  'React/Web devs dùng HTML-style API • Flutter devs code bình thường',
                  style: Style(color: '#888', fontSize: 13),
                ),
              ],
            ),

            // Cards
            Div(
              style: Style(
                display: 'flex',
                flexDirection: MediaQuery.of(context).size.width > 700
                    ? 'row'
                    : 'column',
                gap: 20,
                alignItems: 'center',
              ),
              children: [
                _DemoCard(
                  emoji: '🟦',
                  title: 'React / Web Dev',
                  subtitle: 'Viết Flutter bằng HTML-style API',
                  description:
                      'Dùng Div, H1, Button, Input...\nvới Style() như CSS.',
                  codeSnippet:
                      'Div(\n  style: Style(padding: 16),\n  children: [\n    H1("Hello"),\n    Button(label: "Click"),\n  ],\n)',
                  accentColor: '#6c63ff',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WebDevSampleScreen(),
                    ),
                  ),
                ),
                _DemoCard(
                  emoji: '🟠',
                  title: 'Flutter Dev',
                  subtitle: 'Viết Flutter bình thường',
                  description:
                      'Dùng Container, Column, Text...\ncú pháp Dart thuần.',
                  codeSnippet:
                      'Container(\n  padding: EdgeInsets.all(16),\n  child: Column(\n    children: [Text("Hello")],\n  ),\n)',
                  accentColor: '#FF6B35',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FlutterDevSampleScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Feature list
            Div(
              style: Style(
                backgroundColor: '#ffffff',
                borderRadius: 16,
                padding: 24,
                width: 560,
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              children: [
                H4('Những gì được hỗ trợ', style: Style(color: '#1a1a2e')),
                const SizedBox(height: 16),
                Ul(
                  gap: 12,
                  children: [
                    Li(
                        text:
                            'Div, Section, Header, Footer, Nav — layout elements'),
                    Li(text: 'H1–H6, P, Span, Label, Strong, Em, Small, Code'),
                    Li(text: 'Button — elevated, text, outlined, icon variants'),
                    Li(
                        text:
                            'Input — text, email, password, number, textarea, Select'),
                    Li(text: 'Img, Avatar — network và asset images'),
                    Li(text: 'Ul, Ol, Li, ReactList — list rendering'),
                    Li(text: 'A — link / anchor với onTap'),
                    Li(
                        text:
                            'Style() — CSS-like: padding, margin, color (#hex, rgba), flexDirection, gap...'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            Small(
              'Import 1 dòng: react_flutter/react_flutter.dart',
              style: Style(color: '#aaa'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String description;
  final String codeSnippet;
  final String accentColor;
  final VoidCallback onTap;

  const _DemoCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.codeSnippet,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = Style.parseColor(accentColor)!;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: accent,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                description,
                style:
                    const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),

            // Code snippet preview
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                codeSnippet,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFCDD6F4),
                  height: 1.6,
                ),
              ),
            ),

            // CTA
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Xem demo →'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
