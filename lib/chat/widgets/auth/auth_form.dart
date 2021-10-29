import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String? _userEmail;
  String? _userName;
  String? _userPassword;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      // Sending auth request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be 7 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text('Login'),
                  ),
                  TextButton(
                    child: Text('Create new account'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
