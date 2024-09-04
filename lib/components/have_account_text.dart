import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/sign_in/sign_in_screen.dart';


class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Sudah Punya Akun?",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
          child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
