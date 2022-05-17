import 'package:flutter/cupertino.dart';

import '../chat.dart';

class ChatMessage{
  String? message;
  MessageType type;
  dynamic image;
  ChatMessage({ this.message,required this.type,this.image = null});
}