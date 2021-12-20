import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsappp/Model/Message.dart';
import 'package:whatsappp/Screens/ChatScreen.dart';
import 'package:whatsappp/Widgets/FriendMessageCard.dart';
import 'package:whatsappp/Widgets/MyMessageCard.dart';
import 'package:whatsappp/providers/ChatsProvider.dart';
import 'package:whatsappp/providers/MessageProvider.dart';
import 'package:whatsappp/views/Home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timeago/timeago.dart';

class SingleChatPage extends StatefulWidget {
  final String? chatId;
  final String? chatName;
   final String? pic;
  const SingleChatPage({Key? key, this.chatId, this.chatName, this.pic})
      : super(key: key);

  @override
  _SingleChatPageState createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  FocusNode focusNode = FocusNode();
  bool show = true;
  bool sendButton = false;
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String? userid;
  IO.Socket? socket;

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("id");
    });
  }

  @override
  void initState() {
    getUserId();
    Provider.of<MessageNotifierProvider>(context, listen: false)
        .getMessages(widget.chatId);
    super.initState();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.1.208:4000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.emit("signin", "1");
    socket.onConnect((data) {
      print("Connected");
      socket!.on("message", (msg) {
        print(msg);
        setMessage();
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket!.connected);
  }

  void setMessage() {}

  @override
  Widget build(BuildContext context) {
    // MessageNotifierProvider messageProvider(bool renderUi) =>
    //     Provider.of<MessageNotifierProvider>(context, listen: renderUi);
    return Scaffold(
        body: Stack(children: [
      Consumer<MessageNotifierProvider>(
          // future: messageProvider(false).getMessages(widget.chatId),
          builder: (context, message, snapshot) {
        //   if(snapshot.connectionState==ConnectionState.waiting){
        //     return Center(child: CircularProgressIndicator());
        //   }
        // else{
        // List<Messages> m = snapshot.data;
        return Scaffold(
            backgroundColor: Color(0xFF100E20),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                backgroundColor: Colors.cyan,
                leadingWidth: 70,
                titleSpacing: 0,
                leading: InkWell(
                  onTap: () {
                    Provider.of<ChatsNotifierProvider>(context, listen: false).getUserChats();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ],
                  ),
                ),  
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.pic ?? "https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg"),
                            backgroundColor: Colors.white,
                            radius: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.chatName!,
                            style: TextStyle(
                              fontSize: 18.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WillPopScope(
                  child: Column(children: [
                    Expanded(
                      // height: MediaQuery.of(context).size.height - 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: message.messages.length,
                        itemBuilder: (context, index) {
                          if (index == message.messages.length) {
                            return Container(height: 70);
                          }
                          if (userid == message.messages[index].sender!.sId) {
                            return MyMessageCard(
                              message: message.messages[index].content,
                            );
                          } else {
                            return FriendMessage(
                              message: message.messages[index].content,
                            );
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: _controller,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        if (value.length > 0) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            show
                                                ? Icons.keyboard
                                                : Icons.emoji_emotions_outlined,
                                          ),
                                          onPressed: () {
                                            if (!show) {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                            }
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        contentPadding: EdgeInsets.all(5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    right: 2,
                                    left: 2,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xFF128C7E),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (sendButton) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                          // sendMessage(
                                          //     _controller.text,
                                          //     widget.sourchat.id,
                                          //     widget.chatModel.id);
                                          message.sendMessage(
                                              widget.chatId!, _controller.text);
                                                     
                                          _controller.clear();
                                          setState(() {
                                            sendButton = false;
                                            // Provider.of<MessageNotifierProvider>(
                                            //       context,
                                            //       listen: false)
                                            //   .getMessages(widget.chatId); 
                                          });

                                  
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  onWillPop: () {
                    return Future.value(false);
                  },
                )));
      })
    ]));
  }
}
