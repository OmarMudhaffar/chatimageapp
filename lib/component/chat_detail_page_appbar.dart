import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDetailPageAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[

              SizedBox(width: 16,),
              CircleAvatar(
                backgroundImage: NetworkImage("https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                maxRadius: 20,
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Omar Mudhaffar",style: TextStyle(fontWeight: FontWeight.w600),),
                    SizedBox(height: 6,),
                    Text("Online",style: TextStyle(color: Colors.green,fontSize: 12),),
                  ],
                ),
              ),
              Icon(Icons.more_vert,color: Colors.grey.shade700,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}