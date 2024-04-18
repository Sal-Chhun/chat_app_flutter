import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/chat_page.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App!!!',
      theme: ThemeData(
        canvasColor: Colors.transparent,
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.black,
          ),
      ),
      home: FutureBuilder<bool> (
        future: context.read<AuthService>().isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData && snapshot.data!) {
          return ChatPage();
            } else {
              return LoginPage();
            }
          }
          return const CircularProgressIndicator();
        },
      ),
      routes: {'/chat' : (context) => ChatPage()},
    );
  }
}

