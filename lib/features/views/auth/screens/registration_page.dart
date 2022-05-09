
import 'package:fake_call_mobile/features/views/auth/screens/login_page.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  static const route = "/registration";


  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/background/background_1.jpg",
                )
            )
        ),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 180),

            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            /// Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                        hintText: "E-Mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: obscurePassword ? const Icon(
                                Icons.visibility_outlined
                            ) : const Icon(
                                Icons.visibility_off_outlined
                            )
                        ),
                        hintText: "Password"
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.send,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Registration
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Have an account?",
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.route);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.normal
                      ),
                    )
                )
              ],
            )

          ],
        ),
      ),
    );
  }


}
