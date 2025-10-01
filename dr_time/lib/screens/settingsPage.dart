import 'package:dr_time/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:dr_time/Theme/switch.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void _showChangePasswordDialog() {
    final _formKey = GlobalKey<FormState>();
    final _oldPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Password"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Old Password"),
                  validator: (value) => value!.isEmpty ? "Please enter your old password" : null,
                ),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "New Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter a new password';
                    if (value.length < 8) return 'Password must be at least 8 characters long';
                    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$').hasMatch(value)) {
                      return 'Must contain uppercase, lowercase, number, and special character';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Confirm New Password"),
                  validator: (value) {
                    if (value != _newPasswordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) return;

                  final cred = EmailAuthProvider.credential(
                    email: user.email!,
                    password: _oldPasswordController.text,
                  );

                  try {
                    await user.reauthenticateWithCredential(cred);
                    await user.updatePassword(_newPasswordController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password changed successfully!"), backgroundColor: Colors.green),
                    );
                  } on FirebaseAuthException catch (e) {
                    String message = "An error occurred.";
                    if (e.code == 'wrong-password') {
                      message = "Incorrect old password.";
                    } else if (e.code == 'weak-password') {
                      message = "The new password is too weak.";
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message), backgroundColor: Colors.red),
                    );
                  }
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    final _passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Account"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("This action is permanent and cannot be undone. Please enter your password to confirm."),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user == null || _passwordController.text.isEmpty) {
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password is required."), backgroundColor: Colors.red),
                    );
                  return;
                }

                final cred = EmailAuthProvider.credential(
                  email: user.email!,
                  password: _passwordController.text,
                );

                try {
                  await user.reauthenticateWithCredential(cred);
                  await user.delete();
                  
                  // Clear navigation stack and go to sign-in screen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LogInPage(
                      isDark: widget.isDark,
                      onThemeChanged: widget.onThemeChanged,
                    )),
                    (Route<dynamic> route) => false,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Account deleted successfully."), backgroundColor: Colors.green),
                  );

                } on FirebaseAuthException catch (e) {
                  String message = "An error occurred.";
                  if (e.code == 'wrong-password') {
                    message = "Incorrect password.";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message), backgroundColor: Colors.red),
                  );
                }
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Change password", style: Theme.of(context).textTheme.bodyMedium),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.lock),
                  onPressed: _showChangePasswordDialog,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Delete account", style: Theme.of(context).textTheme.bodyMedium),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: _showDeleteAccountDialog),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
