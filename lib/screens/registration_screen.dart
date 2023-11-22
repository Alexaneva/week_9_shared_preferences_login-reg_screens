import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_9_shared_preferences_zndh/screens/user_profile.dart';
import 'package:week_9_shared_preferences_zndh/user.dart';
import 'package:week_9_shared_preferences_zndh/widgets/input_decoration_form.dart';
import 'package:week_9_shared_preferences_zndh/widgets/text_button_reg_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKeyKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String eMail = '';
  String pHone = '';

  //записываем данные в память при регистрации
  Future<void> register(
      String name, String pass, String email, String phone) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString(User().nameKey, name);
    storage.setString(User().passwordKey, pass);
    storage.setString(User().emailKey, email);
    storage.setString(User().phoneKey, phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/zndh.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            _buildSpacer(20),
            _buildSpacer(10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _buildTextFiledName(),
                  _buildSpacer(10),
                  _buildPhone(),
                  _buildSpacer(10),
                  _buildTextFiledEmail(),
                  _buildSpacer(10),
                  _buildTextFiledPassword(),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: _buildTextButton()),
            _buildSpacer(20),
          ]),
        ),
      ),
    );
  }

  Widget _buildTextFiledName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white54,
      style: const TextStyle(color: Colors.white54),
      decoration: inputDecorationForm(
        const Text(
          'Name and Surname',
          style: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.w400,
            fontFamily: 'din-pro-bold',
          ),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Entry the data';
        const TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
          fontFamily: 'din-pro-bold',
        );
        return null;
      },
      onChanged: (value) {
        username = value;
      },
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      cursorColor: Colors.white54,
      style: const TextStyle(color: Colors.white54),
      decoration: inputDecorationForm(
        const Text(
          'Phone number',
          style: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.w400,
            fontFamily: 'din-pro-bold',
          ),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Entry your phone number';
        const TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
          fontFamily: 'din-pro-bold',
        );
        return null;
      },
      onChanged: (value) {
        pHone = value;
      },
    );
  }

  Widget _buildTextFiledEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white54,
      style: const TextStyle(color: Colors.white54),
      decoration: inputDecorationForm(
        const Text(
          'E-mail',
          style: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.w400,
            fontFamily: 'din-pro-bold',
          ),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Entry your email';
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: 'din-pro-bold',
        );
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) return 'Entry your email';
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: 'din-pro-bold',
        );
        return null;
      },
      onChanged: (value) {
        eMail = value;
      },
    );
  }

  Widget _buildTextFiledPassword() {
    final passwordFieldKey = GlobalKey<FormFieldState<String>>();
    return Column(
      children: [
        TextFormField(
          obscureText: true,
          key: passwordFieldKey,
          cursorColor: Colors.white54,
          style: const TextStyle(color: Colors.white54),
          decoration: inputDecorationForm(
            const Text('Password',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'din-pro-bold',
                )),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Entry password';
            const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w400,
              fontFamily: 'din-pro-bold',
            );
            if (value.length < 2) return 'Password is too short';
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: 'din-pro-bold',
            );
            return null;
          },
          onChanged: (value) {
            password = value;
          },
        ),
        _buildSpacer(10),
        TextFormField(
          obscureText: true,
          cursorColor: Colors.white54,
          style: const TextStyle(color: Colors.white54),
          decoration: inputDecorationForm(
            const Text('Repeat your password',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'din-pro-bold',
                )),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value != passwordFieldKey.currentState!.value) {
              return 'Password mismatch';
            }
            return null;
          },
        ),
        _buildSpacer(20),
      ],
    );
  }

  Widget _buildTextButton() {
    return TextButtonClass1(
        title: 'Register',
        function: () {
          if (_formKeyKey.currentState!.validate()) {
            setState(() {
              register(username, password, eMail, pHone);
              Get.offAll(
                () => const UserProfile(),
              );
            });
          }
        });
  }
}

Widget _buildSpacer(double space) {
  return SizedBox(
    height: space,
  );
}
