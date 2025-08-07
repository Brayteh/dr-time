import 'package:dr_time/Theme/switch.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool dark = true;
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
              SwitchExample(
                value: dark,
                onChanged: (bool value) {
                  setState(() {
                    dark = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}