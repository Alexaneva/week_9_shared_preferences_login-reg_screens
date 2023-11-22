import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_9_shared_preferences_zndh/screens/registration_screen.dart';
import 'package:week_9_shared_preferences_zndh/widgets/text_button_class.dart';
import 'package:week_9_shared_preferences_zndh/user.dart';
import 'package:week_9_shared_preferences_zndh/screens/user_profile.dart';
import '../widgets/input_decoration_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late bool _obscureText = true;
  bool _isChecked = false;

  String username = '';
  String password = '';

  Future<void> remember(bool isChecked) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool(User().isCheckedKey, isChecked);
  }

  Future getValidation(String name, String pass) async {
    bool getVal = false;
    final SharedPreferences storage = await SharedPreferences.getInstance();
    if ((storage.getString(User().nameKey) == name &&
        storage.getString(User().passwordKey) == pass)) {
      getVal = true;
      Get.offAll(
        () => const UserProfile(),
      );
      Fluttertoast.showToast(
          fontSize: 22,
          msg: 'Registration is succeed',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white);
    } else {
      getVal = false;
      Fluttertoast.showToast(
          fontSize: 22,
          msg: 'Login is not correct',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white);
    }
    return getVal;
  }

  Future<void> rememberFields() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    bool getValidation = storage.getBool(User().isCheckedKey) ?? false;
    if (getValidation == true) {
      setState(() {});
      passwordController =
          TextEditingController(text: storage.getString(User().passwordKey));
      _isChecked = true;
    }
  }

  @override
  void initState() {
    super.initState();
    rememberFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/forest.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 110, 5, 5),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Caveat Variable',
                    fontSize: 50,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'din-pro-bold',
                  ),
                  obscureText: _obscureText,
                  decoration: inputDecorationForm(
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'din-pro-bold',
                      ),
                    ),
                    prefixIcon: const Icon(Icons.alternate_email_outlined,
                        color: Colors.white54),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    username = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Entry your login';
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'din-pro-bold',
                  ),
                  obscureText: _obscureText,
                  decoration: inputDecorationForm(
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'din-pro-bold',
                      ),
                    ),
                    prefixIcon: const Icon(Icons.key, color: Colors.white54),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility_off_outlined,
                          color: Colors.white54),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Enter your password';
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'din-pro-bold',
                        fontSize: 15,
                      ),
                    ),
                    Checkbox(
                        side: const BorderSide(color: Colors.white54),
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        }),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                TextButtonClass(
                  title: 'Sign in',
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        getValidation(
                                nameController.text, passwordController.text)
                            .then((value) {
                          if (value == true) {
                            remember(_isChecked);
                            Get.offAll(() => const UserProfile());
                          } else {
                            Get.offAll(() => const RegistrationScreen());
                          }
                        });
                      });
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 100)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()));
                  },
                  child: const Text(
                    "Don't have account yet?\n               "
                    "Sign up  ",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
