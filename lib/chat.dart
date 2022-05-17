import 'dart:async';
import 'dart:io';

import 'package:chatstudio/component/chat_bubble_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';

import 'component/chat_bubble.dart';
import 'component/chat_detail_page_appbar.dart';
import 'models/chat_message.dart';
import 'models/send_menu_items.dart';

enum MessageType{
  Sender,
  Receiver,
}


class ChatPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatPage> {
  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Hi Omar", type: MessageType.Receiver),
    ChatMessage(message: "Hope you are doin good", type: MessageType.Receiver),
    ChatMessage(message: "Hello Jane, I'm good what about you", type: MessageType.Sender),
    ChatMessage(message: "I'm fine, Working from home", type: MessageType.Receiver),
    ChatMessage(message: "Oh! Nice. Same here man", type: MessageType.Sender),
  ];

  List<SendMenuItems> menuItems = [
    SendMenuItems(text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
    SendMenuItems(text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
    SendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
  ];

  TextEditingController message = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
    setState(() {
      Navigator.of(context).pop();
      chatMessage.add(ChatMessage(type: MessageType.Sender,image: File(pickedFile.path)));

    });
    FocusManager.instance.primaryFocus?.unfocus();

    Future.delayed(Duration(milliseconds: 500)).then((value){
      scrollDown();
    });

    }
  }

  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 100),
    );
  }

  void showModal(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height/3,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16,),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ListView.builder(
                    itemCount: menuItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: ListTile(
                          onTap: _getFromGallery,
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: menuItems[index].color.shade50,
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(menuItems[index].icons,size: 20,color: menuItems[index].color.shade400,),
                          ),
                          title: Text(menuItems[index].text),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

   

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ChatDetailPageAppBar(),
      body: KeyboardVisibilityBuilder(
       builder: (context,visibil){
         if(visibil){
           print("hi");
           Future.delayed(Duration(milliseconds: 100)).then((value){
             scrollDown();
           });
         }
         return GestureDetector(
           onTap: (){
             FocusManager.instance.primaryFocus?.unfocus();

           },
           child: Stack(
             children: <Widget>[
               ListView.builder(
                 controller: _scrollController,
                 itemCount: chatMessage.length,
                 padding: EdgeInsets.only(top: 10,bottom: 120),
                 physics: ScrollPhysics(),
                 itemBuilder: (context, index){
                   return chatMessage[index].image != null ? ChatBubbleImage(chatMessage:  chatMessage[index]) : ChatBubble(
                     chatMessage: chatMessage[index],
                   );
                 },
               ),
               Align(
                 alignment: Alignment.bottomLeft,
                 child: Container(
                   padding: EdgeInsets.only(left: 16,bottom: 10),
                   height: 80,
                   width: double.infinity,
                   color: Colors.white,
                   child: Row(
                     children: <Widget>[
                       GestureDetector(
                         onTap: (){
                           showModal();
                         },
                         child: Container(
                           height: 40,
                           width: 40,
                           decoration: BoxDecoration(
                             color: Colors.blueGrey,
                             borderRadius: BorderRadius.circular(30),
                           ),
                           child: Icon(Icons.add,color: Colors.white,size: 21,),
                         ),
                       ),
                       SizedBox(width: 16,),
                       Expanded(
                         child: TextField(
                           controller: message,
                           decoration: InputDecoration(
                               hintText: "Type message...",
                               hintStyle: TextStyle(color: Colors.grey.shade500),
                               border: InputBorder.none
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               Align(
                 alignment: Alignment.bottomRight,
                 child: Container(
                   padding: EdgeInsets.only(right: 30,bottom: 50),
                   child: FloatingActionButton(
                     onPressed: (){
                       setState(() {
                         chatMessage.add(ChatMessage(message: message.text, type: MessageType.Sender));
                         message.clear();
                         scrollDown();
                       });
                     },
                     child: Icon(Icons.send,color: Colors.white,),
                     backgroundColor: Colors.pink,
                     elevation: 0,
                   ),
                 ),
               )
             ],
           ),
         );
       },
      ),
    );
  }
}