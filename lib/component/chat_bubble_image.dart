import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../chat.dart';
import '../models/chat_message.dart';

class ChatBubbleImage extends StatefulWidget{
  ChatMessage chatMessage;
  ChatBubbleImage({required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubbleImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
        child: Container(
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.all(16),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.file(widget.chatMessage.image!,)),
        ),
      ),
    );
  }
}