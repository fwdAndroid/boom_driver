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
        .where("driverId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                              .where("driverId",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots();
                        } else {
                          _stream = FirebaseFirestore.instance
                              .collection("chats")
                              .where("driverId",
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
                                    chatCustomerId: data['driverId'],
                                    customerId: data['driverId'],
                                    customerName: data['driverName'],
                                    customerPhoto: data['driverPhoto'],
                                    providerId: data['uid'],
                                    providerName: data['name'],
                                    providerPhoto: data['photo'],
                                    customerEmail: data['clientEmail'],
                                    providerEmail: data['driverEmail'],
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
                            subtitle: Text(data['clientEmail']),
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
}
