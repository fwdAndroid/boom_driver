import 'package:boom_driver/screens/chats/chat_detail.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
    myController = TextEditingController();
    _stream = FirebaseFirestore.instance
        .collection("chats")
        .where("driverUid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.search,
            color: mainBtnColor,
          )
        ],
        automaticallyImplyLeading: false,
        title: Text(
          "Recent Chats",
          style: TextStyle(color: mainBtnColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 68,
                width: 343,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: myController,
                    onChanged: (value) {
                      setState(() {
                        if (value.trim().isEmpty) {
                          _stream = FirebaseFirestore.instance
                              .collection("chats")
                              .where("driverUid",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots();
                        } else {
                          _stream = FirebaseFirestore.instance
                              .collection("chats")
                              .where("driverUid",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .where("driverName",
                                  isGreaterThanOrEqualTo: value.trim())
                              .where("driverName",
                                  isLessThanOrEqualTo: value.trim() + '\uf8ff')
                              .snapshots();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.nunitoSans(
                        color: Color(0xffADB3BC),
                        fontSize: 14,
                      ),
                      hintText: "Search messages or salon",
                      prefixIcon: Icon(Icons.search, color: mainBtnColor),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffF0F3F6),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0xffF0F3F6)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0xffF0F3F6)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0xffF0F3F6)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: StreamBuilder(
                stream: _stream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Chat Started Yet",
                        style: TextStyle(color: colorBlack),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      final Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;
                      DateTime date = (data['chatTime'] as Timestamp).toDate();
                      String formattedTime = DateFormat.jm().format(date);

                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => ChatDetailPage(
                                    chatCustomerId: data['driverUid'],
                                    customerId: data['driverUid'],
                                    customerName: data['driverName'],
                                    customerPhoto: data['driverPhoto'],
                                    providerId: data['uid'],
                                    providerName: data['name'],
                                    providerPhoto: data['photo'],
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['photo']),
                              radius: 20,
                            ),
                            title: Text(
                              data['name'],
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("messages")
                                    .doc(groupChatId(data!['driverUid']))
                                    .collection(groupChatId(data['driverUid']))
                                    .orderBy("timestamp", descending: true)
                                    .limit(1)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    final latestMessage =
                                        snapshot.data!.docs.first.data()
                                            as Map<String, dynamic>;
                                    return Text(
                                      latestMessage['content'],
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.green),
                                    );
                                  } else {
                                    return Text(
                                      "No messages yet",
                                      style: GoogleFonts.abhayaLibre(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }
                                }),
                            trailing: Column(
                              children: [
                                Text(
                                  formattedTime,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange),
                                  child: Text(
                                    "2",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Divider(
                              color: Colors.black.withOpacity(.4),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String groupChatId(String customerId) {
    if (FirebaseAuth.instance.currentUser!.uid.hashCode <=
        customerId.hashCode) {
      return "${FirebaseAuth.instance.currentUser!.uid}-$customerId";
    } else {
      return "$customerId-${FirebaseAuth.instance.currentUser!.uid}";
    }
  }
}
