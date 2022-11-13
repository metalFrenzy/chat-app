import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isloading = false;
  void _submit(
    String username,
    String email,
    String password,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential res;
    try {
      setState(() {
        _isloading = true;
      });
      if (isLogin) {
        res = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        res = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final storageRef = FirebaseStorage.instance.ref();
        final imageRef =
            storageRef.child('user-images').child(res.user!.uid + '.jpg');
        try {
          await imageRef.putFile(image!);
        } on FirebaseException catch (error) {
          throw error;
        }
        final imageUrl = await imageRef.getDownloadURL();
        //print(imageUrl);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(res.user!.uid)
            .set({
          'username': username,
          'email': email,
          'user-images': imageUrl,
        });
      }
    } on PlatformException catch (error) {
      var message = 'invalid email or password';
      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isloading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submit, _isloading),
    );
  }
}
