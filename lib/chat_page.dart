import 'dart:convert';
import 'package:chat_app/models/image_model.dart';
import 'package:chat_app/repo/image_repository.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:chat_app/models/chat_message_entity.dart';
import 'package:provider/provider.dart';
import 'widgets/chat_bubble.dart';


class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<ChatMessageEntity> _messages =[];

  _loadInitialMessages() async{
    final response = await rootBundle.loadString('assets/mock_message.json');

    final List<dynamic>decodeList = jsonDecode(response) as List;

    final List<ChatMessageEntity> _chatMessage = decodeList.map((listItem){
      return ChatMessageEntity.fromJson(listItem);
    }).toList();

    // final List<ChatMessageEntity> = ChatMessageEntity.fromJson(json);
    print(_chatMessage.length);

    setState(() {
      _messages = _chatMessage;
    });
  }

  onMessageSent(ChatMessageEntity entity){
    _messages.add(entity);
    setState(() {});
  }

  final ImageRepository _imageRepo = ImageRepository();

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthService>().getUsername();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Hi $username!"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthService>().updateUserName("New Name!");
            },
            icon: const Icon(Icons.change_circle),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthService>().logoutUser();
              Navigator.popAndPushNamed(context, '/');
              print('Icon pressed!');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<PixelfordImage>>(
              future: _imageRepo.getNetworkImages(),
              builder: (context, AsyncSnapshot<List<PixelfordImage>> snapshot) {
                if(snapshot.hasData) {
                  return Image.network(snapshot.data![0].url, height: 100,);
                }else {
                  return const CircularProgressIndicator();
                }
              },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                    alignment: _messages[index].author.userName == context.read<AuthService>().getUsername()
                        ?  Alignment.centerRight
                        : Alignment.centerLeft,
                    entity: _messages[index]);
              },
            ),
          ),
          ChatInput(onSubmit: onMessageSent),
        ],
      ),
    );
  }
}
