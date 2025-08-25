import 'package:flutter/material.dart';
import 'package:dr_time/Theme/switch.dart';

class SettingsPage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  const SettingsPage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool dark;
  bool vibration = false;

  @override
  void initState() {
    super.initState();
    dark = widget.isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Settings", style: Theme.of(context).textTheme.headlineLarge),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Dark mode", style: Theme.of(context).textTheme.bodyMedium),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SwitchExample(
                  value: dark,
                  onChanged: (bool value) {
                    setState(() {
                      dark = value;
                    });
                    widget.onThemeChanged(value); // يغير الثيم ويحفظ
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
