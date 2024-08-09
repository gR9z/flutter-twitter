import 'package:flutter/material.dart';
import 'package:twitterlike/app-theme.dart';
import 'package:twitterlike/app-validator.dart';
import 'package:twitterlike/auth-context.dart';
import 'package:twitterlike/main.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Widget wrapperWithPadding(Widget widget, {double paddingValue = 16}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: paddingValue),
    child: widget,
  );
}

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${AuthContext.token}'
  };

  // "email": "chocolatine@gmail.com", "password": "password"

  TextEditingController emailController =
      TextEditingController(text: "chocolatine@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "password");

  Future<void> onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final body = convert.jsonEncode(
          {"email": emailController.text, "password": passwordController.text});

      try {
        var response = await http.post(
            Uri.parse(
              "http://localhost:3000/auth",
            ),
            headers: headers,
            body: body);
        var json = convert.jsonDecode(response.body);

        if (json['code'] == '203') {
          AuthContext.token = json['data'];
          Navigator.pushNamed(context, "/twitterList");
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erreur de connexion"),
                content: Text(json['message']),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch(e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryBGColor,
        title: Text("Login Page", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          "images/gradient.jpg",
          fit: BoxFit.cover,
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 96),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 7.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 84.0,
                    ),
                  ),
                ),
                wrapperWithPadding(
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    paddingValue: 16),
                wrapperWithPadding(
                    TextFormField(
                        validator: AppValidator.emailValidator,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppTheme.formDecoration("Email")),
                    paddingValue: 8),
                wrapperWithPadding(
                    TextFormField(
                        validator: AppValidator.passwordValidator,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: AppTheme.formDecoration("Password")),
                    paddingValue: 8),
                wrapperWithPadding(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
                          activeColor: primaryBGColor,
                          activeTrackColor: Color(0x77FFFFFF),
                          inactiveThumbColor: Colors.black26,
                          inactiveTrackColor: Colors.black12,
                          value: false,
                          onChanged: (value) {},
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Save my credentials',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    paddingValue: 4),
                wrapperWithPadding(
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            onSubmit(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBGColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(24.0),
                          ),
                          child: Text(
                            "Login".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    paddingValue: 8)
              ],
            ),
          ),
        )
      ]),
    );
  }
}
