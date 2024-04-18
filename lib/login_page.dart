import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/utils/spaces.dart';
import 'package:chat_app/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  LoginPage({Key? key}) : super(key: key);
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final Uri _url = Uri.parse('https://aifarm.dev/');
  String urlImage =
      'https://www.zdnet.com/a/img/resize/d36e142bd1aa124b869cfb89a70d89d823f44565/2023/12/19/33404002-f49d-4e20-8789-9af8ddcd4da3/photobot.jpg?auto=webp&width=1280';

  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);

      await context.read<AuthService>().loginUser(userNameController.text);
      Navigator.pushReplacementNamed(
        context,
        '/chat',
        arguments: userNameController.text,
      );
      print('login successful!');
    } else {
      print('login not successful!');
    }
  }

  Widget _buildHeader(context) {
    return Column(
      children: [
        const Text(
          'Let\'s sign you in!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 0.5,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Welcome back! \n You\'ve been missed!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpacing(24),
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(urlImage),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        verticalSpacing(24),
      ],
    );
  }

  Widget _buildForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              LoginTextField(
                hasAsterisks: false,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 5) {
                    return "Your username should be more than 5 characters";
                  } else if (value != null && value.isEmpty) {
                    return "Please type your username";
                  }
                  return null;
                },
                controller: userNameController,
                hintText: "Enter your username",
              ),
              verticalSpacing(24),
              LoginTextField(
                hasAsterisks: true,
                controller: passwordController,
                hintText: "Enter your password",
              ),
            ],
          ),
        ),
        verticalSpacing(24),
        ElevatedButton(
          onPressed: () async {
            await loginUser(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            if (!await launchUrl(_url)) {
              throw Exception('Could not launch $_url');
            }
            print('Link clicked!');
          },
          child: const Column(
            children: [
              Text('Find us on'),
              Text('https://aifarm.dev/'),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton.twitter(
              size: 20,
              color: Colors.blue,
            ),
            SocialMediaButton.linkedin(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              if (constraints.maxWidth > 1000) {
                // web layout
                return Row(
                  children: [
                    const Spacer(flex: 1),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeader(context),
                          _buildFooter(),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(child: _buildForm(context)),
                    const Spacer(flex: 1),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  _buildForm(context),
                  _buildFooter(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
