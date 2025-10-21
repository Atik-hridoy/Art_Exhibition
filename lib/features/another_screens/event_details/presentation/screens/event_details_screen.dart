import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/api/api_end_point.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/event_details/presentation/controller/event_details_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});
  final String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EventDetailsController(),
      builder: (controller) {
        String? formattedDate(DateTime? date) {
          if (date == null) {
            return null;
          }
          String formattedDate = DateFormat('d MMM yy').format(date);
          return formattedDate;
        }

        String? calculateRemainingDays(DateTime? startDate, DateTime? endDate) {
          if (startDate == null || endDate == null) {
            return null;
          }
          // Remove the time part to make calculation purely date-based
          DateTime start = DateTime(startDate.year, startDate.month, startDate.day);
          DateTime end = DateTime(endDate.year, endDate.month, endDate.day);
          int remainingDays = end.difference(start).inDays;
          remainingDays = remainingDays.isNegative ? 0 : remainingDays;
          return remainingDays.toString();
        }

        DateTime? startDate = controller.event?.startDate;
        DateTime? endDate = controller.event?.endDate;
        String image =
            (controller.event?.images != null && controller.event!.images!.isNotEmpty)
            ? controller.event!.images![0]
            : 'N/A';
        String eventTitle = controller.event?.title ?? 'N/A';
        String creatorName = controller.event?.creatorName ?? 'N/A';
        String about = controller.event?.description ?? 'N/A';
        String overview = controller.event?.overview ?? 'N/A';
        String formatterdStartDate = formattedDate(startDate) ?? 'N/A';
        String formatterdEndDate = formattedDate(endDate) ?? 'N/A';
        String deysRemaining = calculateRemainingDays(DateTime.now(), startDate) ?? 'N/A';
        String visitingHour = controller.event?.visitingHour ?? 'N/A';
        String venue = controller.event?.venue ?? 'N/A';
        String ticketPrice = controller.event?.ticketPrice.toString() ?? 'N/A';
        String buyTicketURL = controller.event?.bookingUrl ?? 'N/A';

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 18.sp, color: AppColors.titleColor),
            ),
            title: CommonText(
              text: AppString.eventDetails,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
              textAlign: TextAlign.center,
            ),
            actions: [
              title == "My Events"
                  ? _moreActions(
                      onEdit: () {
                        Get.toNamed(
                          AppRoutes.createNewEventScreen,
                          arguments: {"title": "Edit Event"},
                        );
                      },
                      onDelete: () => _confirmDelete(context),
                    )
                  : GestureDetector(
                      onTap: controller.saveToggle,
                      child: controller.isSaved
                          ? Icon(Icons.favorite, size: 18.sp, color: AppColors.titleColor)
                          : Icon(
                              Icons.favorite_border,
                              size: 18.sp,
                              color: AppColors.titleColor,
                            ),
                    ),

              14.width,
            ],
            surfaceTintColor: AppColors.transparent,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner image
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CommonImage(
                        height: 200.h,
                        width: double.infinity,
                        fill: BoxFit.cover,
                        imageSrc: ApiEndPoint.imageUrl + image,
                        // AppImages.eventImage,
                      ),
                    ),
                  ),

                  // Title and organizer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: eventTitle, // 'Abstract Realities',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.titleColor,
                        ),
                        6.height,
                        Row(
                          children: [
                            CommonText(
                              text: 'Organized by ',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyClr,
                            ),
                            CommonText(
                              text: creatorName, // 'Mark Cena',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // About the Event card
                  _boxedSection(
                    title: AppString.aboutTheEvent,
                    child: CommonText(
                      text:
                          about, //    'Discover the future of contemporary art with works from 25 emerging artists pushing creative boundaries. This groundbreaking exhibition showcases innovative techniques. See More.',
                      fontSize: 12,
                      maxLines: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                      textAlign: TextAlign.start,
                    ),
                  ),

                  // Event Overview
                  _boxedSection(
                    title: AppString.eventOverview,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          maxLines: 10,
                          text: overview,
                          // 'The event is organized into four thematic sections:',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyClr,
                          textAlign: TextAlign.start,
                        ),
                        8.height,
                        // CommonText(
                        //   text: "  1.Breaking Boundaries",
                        //   fontSize: 12,
                        //   fontWeight: FontWeight.w400,
                        //   color: AppColors.bodyClr,
                        //   textAlign: TextAlign.start,
                        // ),

                        // CommonText(
                        //   text: "  1.Digital Futures",
                        //   fontSize: 12,
                        //   fontWeight: FontWeight.w400,
                        //   color: AppColors.bodyClr,
                        //   textAlign: TextAlign.start,
                        // ),
                      ],
                    ),
                  ),

                  // Event Details
                  _boxedSection(
                    title: AppString.eventDetails,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _detailRow(
                          icon: Icons.schedule_outlined,
                          label: AppString.duration,
                          value:
                              '$formatterdStartDate - $formatterdEndDate', // '15 July 25 - 30 July 25',
                          subValue: deysRemaining, // '4 Days Remaining',
                          subColor: Colors.green,
                        ),
                        12.height,
                        _detailRow(
                          icon: Icons.access_time,
                          label: AppString.time,
                          value: visitingHour, // '10:00 am - 6:00 pm (Monday Closed)',
                        ),
                        12.height,
                        _detailRow(
                          icon: Icons.location_on_outlined,
                          label: AppString.venue,
                          value: venue, // 'The Art Collective Gallery, New York',
                        ),
                        12.height,
                        _detailRow(
                          icon: Icons.confirmation_number_outlined,
                          label: AppString.tickerPrice,
                          value: '\$$ticketPrice', // 'General: 18\$',
                        ),
                      ],
                    ),
                  ),

                  90.height, // spacer for bottom button
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              border: Border(top: BorderSide(color: AppColors.stroke)),
            ),

            child: CommonButton(
              onTap: () {
                controller.openInBrowser(buyTicketURL);
              },
              titleText: AppString.joinEvent,
            ),
          ),
        );
      },
    );
  }

  Widget _boxedSection({required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
            10.height,
            child,
          ],
        ),
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    String? subValue,
    Color? subColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: AppColors.bodyClr),
        10.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: label,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                  6.width,
                  Expanded(
                    child: CommonText(
                      text: value,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyClr,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              if (subValue != null) ...[
                4.height,
                CommonText(
                  text: subValue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: subColor ?? AppColors.titleColor,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _moreActions({required VoidCallback onEdit, required VoidCallback onDelete}) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 18.sp, color: AppColors.titleColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      onSelected: (value) {
        if (value == 'Edit') onEdit();
        if (value == 'Delete') onDelete();
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 18.sp, color: AppColors.bodyClr),
              8.width,
              CommonText(
                text: AppString.edit,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.bodyClr,
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'Delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 18.sp, color: AppColors.red),
              8.width,
              CommonText(
                text: AppString.delete,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Warning icon in subtle background
              Icon(Icons.warning_amber_rounded, color: AppColors.red, size: 80.sp),
              14.height,
              // Title
              CommonText(
                text: 'Are you sure you want to delete this event?',
                fontSize: 16,
                maxLines: 2,
                fontWeight: FontWeight.w700,
                color: AppColors.red,
                textAlign: TextAlign.center,
              ),
              8.height,
              // Subtitle/description
              CommonText(
                text:
                    ' This action is permanent and cannot be undone. All related data will be lost.',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyClr,
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
              20.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: StadiumBorder(),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Get.back();
                            // Perform delete logic here
                            Get.snackbar('Deleted', 'The event has been deleted.');
                          },
                          child: CommonText(
                            text: AppString.yes,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    12.width,
                    // NO button (outlined)
                    Expanded(
                      child: SizedBox(
                        height: 44.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.title2, width: 1.2),
                            shape: StadiumBorder(),
                          ),
                          onPressed: () => Get.back(),
                          child: CommonText(
                            text: AppString.no,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
