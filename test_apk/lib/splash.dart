import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test_apk/models/client_model.dart';
import 'package:test_apk/views/home_page.dart';

import '../core/services/services.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Test();
    bool loading = true;
    final contact = Provider.of<ClientModel?>(context);
    if (contact != null) {
      if (contact == ClientModel.empty) {
        loading = false;
      } else {
        // final project = Provider.of<ProjectModel>(context);
        // if (project != null) {
        //TODO:(Alvaro) check the FirebaseMessaging token  with the firestore user token
        // FirebaseMessaging.instance.getToken().then(print);

        // final contactPdfs = Provider.of<List<ContactPdfModel>>(context);
        // final perceels = Provider.of<List<PerceelModel>>(context);
        // final factuurs = Provider.of<List<FactuurModel>>(context);
        // final voorschot = Provider.of<List<VoorschotModel>>(context);
        // final lclProvider =
        //     Provider.of<LocaleProvider>(context, listen: false);
        // final themeProvider = Provider.of<ThemeProvider>(context);
        // final images = Provider.of<ImagesModel>(context);

        return HomePage();
        // }
      }
    }
    return Scaffold(
      body: Center(
        child: loading ? CircularProgressIndicator() : _UserNotFound(),
      ),
    );
  }
}

class _UserNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "User not found",
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: Text("log out"),
          onPressed: () async {
            await authService.signOut();
          },
        ),
      ],
    );
  }
}
