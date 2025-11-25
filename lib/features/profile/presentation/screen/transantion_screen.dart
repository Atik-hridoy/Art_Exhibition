import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_string.dart';
import '../widgets/transaction_history_item.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 20.sp),
        ),
        centerTitle: true,
        title: CommonText(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          text: AppString.transaction,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            16.height,

            

            CommonText(
                top: 25.h,
                fontSize: 16.sp,
                left: 20.w,
                bottom: 16.h,
                fontWeight: FontWeight.w500,

                text: AppString.transactionHistory).start,


            SizedBox(

              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return TransationHistoryItem();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
