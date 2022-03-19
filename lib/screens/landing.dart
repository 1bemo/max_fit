import 'package:flutter/material.dart';
import 'package:max_fit/domain/authUser.dart';
import 'package:max_fit/screens/auth.dart';
import 'package:max_fit/screens/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser?>(context);
    bool isLoggedIn = user != null;

    return (isLoggedIn ? const HomePage() : const AuthorizationPage());
  }
}
