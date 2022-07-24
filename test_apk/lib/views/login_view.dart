import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_apk/core/auth/auth_provider.dart';
import 'package:vrouter/vrouter.dart';

// class LoginWidget extends StatelessWidget {
//   const LoginWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: FloatingActionButton(onPressed: () {
//         context.vRouter.to('/login');
//         // Navigator.of(context).pushNamed('/login');
//       })),
//     );
//   }
// }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(context), child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: "Enter the email"),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: passController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: "Enter the email"),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () => authProvider.login(
                      emailController.text.trim(), passController.text.trim()),
                  // onPressed: sigIn,
                  icon: Icon(
                    Icons.lock_open,
                    size: 32,
                  ),
                  label: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sigIn() async {
    final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim());

    print(cred.user?.email ?? "Sin email ");
  }
}
