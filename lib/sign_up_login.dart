import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpLogIn extends ConsumerWidget {
  const SignUpLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final pwdController = TextEditingController();

    return Center(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // sign in announymsly with firebase
                const Text("Sign in/Sign Up"),
                ElevatedButton(
                  child: const Text("Sign up"),
                  onPressed: () async {
                    // pop up asking for name
                    await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Sign Up"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: "Name",
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: pwdController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("OK"),
                            onPressed: () async {
                              if (nameController.text != "") {
                                try {
                                  ref
                                      .read(nameProvider)
                                      .setName(nameController.text);
                                  await ref
                                      .read(firebaseAuthProvider)
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: pwdController.text);
                                } catch (e) {}

                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Log In"),
                  onPressed: () async {
                    // pop up asking for name
                    await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Log In"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: pwdController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("OK"),
                            onPressed: () async {
                              try {
                                await ref
                                    .read(firebaseAuthProvider)
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: pwdController.text);
                              } catch (e) {
                                print(e);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
