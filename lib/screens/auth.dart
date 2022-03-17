import 'package:flutter/material.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {

    Widget _logo() {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Align(
          child: Text(
            'MAXFIT',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      );
    }

    Widget _input (Icon icon, String hint, TextEditingController controller, bool obscure) {
      return Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white
          ),

        ),
      );
    }

    Widget _form(String label, void Function() func) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 10),
            child: _input(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: input(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Text(label),
            ),
          )
        ],
      );
    }


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          _logo(),
          _form('LOGIN', (){}),
        ],
      ),
    );
  }
}
