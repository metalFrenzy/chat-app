import 'dart:io';

import 'package:flutter/material.dart';

import './image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);
  final bool _isLoading;
  final void Function(
    String username,
    String email,
    String password,
    File? image,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = '';
  var _email = '';
  var _password = '';
  File? _userProfileImage;

  void _pickedImage(File? image) {
    _userProfileImage = image;
  }

  void _submit() {
    final isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userProfileImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please take a photo'),
        ),
      );
      return;
    }

    if (isValid) {
      _form.currentState!.save();
      widget.submitFn(
        _userName.trim(),
        _email.trim(),
        _password.trim(),
        _userProfileImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 220, 91, 134),
            Color.fromARGB(255, 190, 165, 234),
            Color.fromARGB(255, 248, 187, 208),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) ProfilePic(_pickedImage),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value!.length < 4 || value.isEmpty) {
                            return 'Username should be at least 4 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        onSaved: (newValue) {
                          _userName = newValue!;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      onSaved: (newValue) {
                        _email = newValue!;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password should be at least 7 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      obscureText: true,
                      onSaved: (newValue) {
                        _password = newValue!;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget._isLoading) CircularProgressIndicator(),
                    if (!widget._isLoading)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _submit,
                        child: Text(_isLogin ? 'Login' : 'signUp'),
                      ),
                    if (!widget._isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create New Account'
                            : 'Already have an account'),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
