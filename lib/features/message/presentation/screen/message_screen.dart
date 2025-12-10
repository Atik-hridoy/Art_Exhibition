import 'package:flutter/material.dart';
import 'dart:io';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/model/chat_message_model.dart';
import '../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/message_controller.dart';
import '../../../../utils/constants/app_string.dart';
import '../widgets/chat_bubble_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";

  @override
  void initState() {
    MessageController.instance.name = name;
    MessageController.instance.chatId = chatId;
    MessageController.instance.getMessageRepo();
    MessageController.instance.listenMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.messageBg,
          /// App Bar Section starts here
          appBar: AppBar(
            title:   CommonText(
              text: name,
              color: AppColors.titleColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            centerTitle: true,
            backgroundColor: AppColors.white,
            leading: InkWell(
              onTap: () {
                Get.back();
              },

              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.textFiledColor,
              ),
            ),

          ),

          /// Body Section starts here
          body: controller.isLoading
              /// Loading bar here
              ? const Center(child: CircularProgressIndicator())
              /// Show data  here
              : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
                  reverse: true,
                  controller: controller.scrollController,
                  itemCount: controller.isMoreLoading
                      ? controller.messages.length + 1
                      : controller.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    /// Message item here
                    if (index < controller.messages.length) {
                      ChatMessageModel message = controller.messages[index];
                      return ChatBubbleMessage(
                        index: index,
                        image: message.image,
                        time: message.time,
                        text: message.text,
                        isMe: message.isMe,
                        mediaPath: message.mediaPath,
                        mediaType: message.mediaType,
                        onTap: () {},
                      );
                    } else {
                      /// More data loading bar
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),

          /// bottom Navigation Bar Section starts here
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppColors.white
            ),
            child: AnimatedPadding(

              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,

              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 20.w, bottom: 24.h),

                /// Send message text filed here
                child: Row(
                  children: [
                    // Media preview section
                    if (controller.image != null || controller.video != null)
                      Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 60.w,
                              height: 60.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey[300],
                              ),
                              child: controller.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(
                                        File(controller.image!),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.videocam,
                                      size: 30.sp,
                                      color: Colors.grey[600],
                                    ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: controller.clearMedia,
                                child: Container(
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Attachment button
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor
                      ),
                      child: GestureDetector(
                        onTap: () => controller.showMediaPickerBottomSheet(context),
                        child: Icon(
                          color: AppColors.white,
                          size: 27.sp,
                          Icons.add),
                      ),
                    ),

                    8.width,
                    Expanded(
                      child: CommonTextField(
                        hintText: AppString.messageHere,
                        suffixIcon: GestureDetector(
                          onTap: (controller.image != null || controller.video != null)
                              ? controller.sendMediaMessage
                              : controller.addNewMessage,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r)),
                              color: AppColors.primaryColor
                            ),
                            padding: EdgeInsets.all(10.sp),
                            child: Icon(
                              size: 25.sp,
                              (controller.image != null || controller.video != null)
                                  ? Icons.send
                                  : Icons.send_outlined,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        borderColor: AppColors.stroke,
                        borderRadius: 60,
                        controller: controller.messageController,
                        onSubmitted: (p0) => (controller.image != null || controller.video != null)
                            ? controller.sendMediaMessage()
                            : controller.addNewMessage(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}