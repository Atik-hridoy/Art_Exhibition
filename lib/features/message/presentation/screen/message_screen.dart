import 'package:flutter/material.dart';
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

                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor
                      ),
                      child: Icon(
                        color: AppColors.white,
                          size: 27.sp,
                          Icons.add),
                    ),

                    8.width,
                    Expanded(
                      child: CommonTextField(
                      
                        hintText: AppString.messageHere,
                        suffixIcon: GestureDetector(
                          onTap: controller.addNewMessage,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r)),
                              color: AppColors.primaryColor
                            ),
                            padding: EdgeInsets.all(10.sp),
                            child:  Icon(
                              size: 25.sp,
                              Icons.send_outlined, color: AppColors.white,),
                          ),
                        ),
                        borderColor: AppColors.stroke,
                        borderRadius: 60,
                        controller: controller.messageController,
                        onSubmitted: (p0) => controller.addNewMessage(),
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
