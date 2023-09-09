import 'package:flutter/material.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  static const namedRoute = '/login-page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var hCtrl = LoginController.to;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Login to Oldtimer Log',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'lib/images/bmw_oldtimer.jpg',
                    width: size.width - 70,
                  ),
                  const SizedBox(height: 20),
                  _myContainerTextFormField(size, context, hCtrl),
                  const SizedBox(height: 20),
                  _myElevatedIconButton(hCtrl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _myContainerTextFormField(
      Size size, BuildContext context, LoginController hCtrl) {
    return Container(
      width: size.width - 70,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.labelMedium,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: 'Enter your Name',
          border: InputBorder.none,
        ),
        onChanged: (String? value) {
          value != null
              ? hCtrl.szInputUserName.value = value
              : hCtrl.szInputUserName.value = 'NoName';
          //print(value);
        },
      ),
    );
  }

  ElevatedButton _myElevatedIconButton(LoginController hCtrl) {
    return ElevatedButton.icon(
      onPressed: () => hCtrl.saveUserLocal(),
      icon: Icon(Icons.person_add, color: Colors.grey.shade500),
      label: const Text(
        'Add..',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        elevation: 2,
        shadowColor: Colors.grey.shade400,
      ),
    );
  }
}
