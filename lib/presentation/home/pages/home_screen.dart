import 'dart:io';

import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/qr_generater/pages/qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  bool isUser1 = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats", style: themeStyle.titleLarge),
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.location_on_outlined)),
          IconButton(onPressed: null, icon: Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  padding: AppSpacing.screenPadding,
                  width: width,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: "Search",
                        controller: searchController,
                      ),
                      AppSpacing.gap16,
                      GestureDetector(
                        onTap: () async {
                          if (Platform.isIOS) {
                            isUser1 = false;
                          } else {
                            isUser1 = true;
                          }
                          final prefs = await SharedPreferences.getInstance();
                          final userId = prefs.getString('userId') ?? "";
                          final myUid = isUser1 ? "user1" : "user2";
                          final receiverUid = isUser1 ? "user2" : "user1";
                          final chatRoomId = [myUid, receiverUid]..sort();
                          final finalChatRoomId = chatRoomId.join("_");

                          context.push(
                            '/chat',
                            extra: {
                              'myUid': userId,
                              'receiverUid': receiverUid,
                              'chatRoomId': finalChatRoomId,
                            },
                          );
                        },
                        child: _userCardWidget(themeColor, themeStyle),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final userId = prefs.getString('userId') ?? "";
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => QrScannerScreen(myUid: userId)),
          );
        },
        child: const Text("Scan QR Code to Start Chat"),
      ),
    );
  }

  Row _userCardWidget(ThemeData themeColor, TextTheme themeStyle) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: themeColor.highlightColor, maxRadius: 25),
        AppSpacing.widthSpace12,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sarang",
              style: themeStyle.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "message",
              style: themeStyle.bodySmall!.copyWith(
                color: themeColor.disabledColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
