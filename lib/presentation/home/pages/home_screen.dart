import 'dart:developer';

import 'package:chat_app/DI/dependency_injection.dart';
import 'package:chat_app/core/constants/app_spacing.dart';
import 'package:chat_app/domain/usecases/get_device_token_usecase.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/home/widgets/qr_code_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

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
          FutureBuilder<String?>(
            future: getIt<GetDeviceTokenUseCase>().call(),
            builder: (context, snapshot) {
              final token = snapshot.data;
              return IconButton(
                onPressed: () {
                  log("token. $token");
                  context.pushNamed('qrcode', extra: token);
                  QRCodeDisplayScreen(token: token!);
                },
                icon: Icon(Icons.qr_code_2, color: themeColor.dividerColor),
              );
            },
          ),
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder:
                            (context, index) => Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: themeColor.highlightColor,
                                  maxRadius: 25,
                                ),
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
                            ),
                        separatorBuilder: (context, index) => AppSpacing.gap12,
                        itemCount: 6,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
