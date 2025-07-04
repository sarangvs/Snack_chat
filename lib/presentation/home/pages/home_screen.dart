import 'dart:io';

import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/home/widgets/logout_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!;
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.chats, style: themeStyle.titleLarge),
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push("/map"),
            icon: Icon(
              Icons.location_on_outlined,
              color: themeColor.dividerColor,
            ),
          ),
          IconButton(
            onPressed: () => showLogoutConfirmationDialog(context),
            icon: Icon(Icons.logout, color: themeColor.dividerColor),
          ),
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
                        hintText: loc.search,
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
                        child: _userCardWidget(themeColor, themeStyle, loc),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor.dividerColor,
        onPressed: () {
          context.push("/languageSwitch");
        },
        child: Icon(Icons.language),
      ),
    );
  }

  Widget _userCardWidget(
    ThemeData themeColor,
    TextTheme themeStyle,
    AppLocalizations loc,
  ) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: themeColor.dividerColor,
            maxRadius: 25,
            child: Icon(Icons.person),
          ),
          AppSpacing.widthSpace12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.user,
                style: themeStyle.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                loc.message,
                style: themeStyle.bodySmall!.copyWith(
                  color: themeColor.disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
