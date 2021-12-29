import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import 'package:test_flutter/views/sign_up_provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(context.read),
      builder: (_, child) => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    context.vRouter.to('/login');
                  },
                  icon: const Icon(Icons.person))
            ],
          ),
          body: const SignUpViewBody._()),
    );
  }
}

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((RegisterModel viewModel) => viewModel.isLoading);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Sign Up",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
            child: isLoading ? _loadingIndicator() : _signInButtons(context),
          ),
        ],
      ),
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column _signInButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        _UserForm(),
        const Spacer(),
      ],
    );
  }
}

class _UserForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserFormState();
}

class _UserFormState extends State<_UserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool? _success;
  String? _userEmail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 350,
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: const Text('Test sign in with email and password'),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    } else if (!EmailValidator.validate(value)) {
                      return 'bad email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<RegisterModel>().registerUser(
                              _emailController.value.text,
                              _passwordController.value.text,
                              _nameController.value.text,
                            );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _success == null
                        ? ''
                        : (_success!
                            ? 'Successfully signed in ' + _userEmail!
                            : 'Sign in failed'),
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
