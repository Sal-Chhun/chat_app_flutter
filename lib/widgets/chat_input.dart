import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/utils/picker_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;
  const ChatInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatMessageController = TextEditingController();
  String _selectedImageUrl = '';

  void onSendButtonPressed() {
    String? userNameFromCache = context.read<AuthService>().getUsername();

    final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: "244",
        author: Author(userName: userNameFromCache!),
    );

    if(_selectedImageUrl.isNotEmpty){
      newChatMessage.imageUrl = _selectedImageUrl;
    }
    widget.onSubmit(newChatMessage);

    chatMessageController.clear();
    _selectedImageUrl = '';
    setState(() {});
  }

  void onImagePicked(String newImageUrl){
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return NetworkImagePickerBody(onImageSelected: onImagePicked);
                  }
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: chatMessageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  style: const TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: "Type your message",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    border: InputBorder.none,
                  ),
                ),
                if(_selectedImageUrl.isNotEmpty)
                  Image.network(_selectedImageUrl, height: 50),
              ],
            ),
          ),
          IconButton(
            onPressed: onSendButtonPressed,
            icon: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
