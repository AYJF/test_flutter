import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_apk/models/client_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ClientModel?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign In as ${contact?.email ?? ''}"),
          SizedBox(
            height: 8,
          ),
          Text(contact?.email ?? ''),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: Icon(Icons.arrow_back),
              label: Text("Sign Out")),
        ],
      ),
    );
  }
}
