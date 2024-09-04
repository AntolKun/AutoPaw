import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/sign_up/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Belum Punya Akun?",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
