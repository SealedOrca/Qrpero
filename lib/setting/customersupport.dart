import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ContactSupportSettingsPage extends StatefulWidget {
  const ContactSupportSettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactSupportSettingsPageState createState() =>
      _ContactSupportSettingsPageState();
}

class _ContactSupportSettingsPageState
    extends State<ContactSupportSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _feedbackMessage = '';
  bool _isSendingFeedback = false;

  Future<void> _sendFeedback(String name, String email, String message) async {
    setState(() {
      _isSendingFeedback = true;
    });

    final url = Uri.parse('https://apps.softwareflare.com/api/v1/feedback');
    final headers = {'Content-Type': 'application/json'};
    final feedbackData = {
      'name': name,
      'email': email,
      'message': message,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(feedbackData),
      );

      if (response.statusCode == 200) {
        setState(() {
          _feedbackMessage = 'Feedback sent, thank you for your thoughts!';
          // Clear form fields after sending feedback
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          _isSendingFeedback = false;
        });
      } else {
        setState(() {
          _feedbackMessage = 'Sorry, try again later';
          _isSendingFeedback = false;
        });
      }
    } catch (e) {
      setState(() {
        _feedbackMessage = 'Sorry, try again later';
        _isSendingFeedback = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Support',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Wrap the Scaffold with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Have a question or need assistance?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Feel free to provide feedback. We are here to help!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                const ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email Support'),
                  subtitle: Text('info@softwareflare.com'),
                ),
                const Divider(),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: 'Your Message',
                    icon: Icon(Icons.message),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isSendingFeedback
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final name = _nameController.text;
                            final userEmail = _emailController.text;
                            final message = _messageController.text;

                            await _sendFeedback(name, userEmail, message);
                          }
                        },
                  child: _isSendingFeedback
                      ? const SpinKitCircle(
                          color: Colors.white,
                          size: 24.0,
                        )
                      : const Text('Submit'),
                ),
                const SizedBox(height: 16),
                Text(
                  _feedbackMessage,
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true, // Set this to true
    );
  }
}
