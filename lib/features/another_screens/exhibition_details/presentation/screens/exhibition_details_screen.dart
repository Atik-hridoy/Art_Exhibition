import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/config/route/app_routes.dart';
import 'package:tasaned_project/features/another_screens/exhibition_details/controller/exhibition_details_controller.dart';
import 'package:tasaned_project/features/another_screens/exhibition_details/presentation/widget/artist_item.dart';
import 'package:tasaned_project/features/data_model/exibition_model.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_images.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class ExhibitionDetailsScreen extends StatelessWidget {
  ExhibitionDetailsScreen({super.key});

  final String title = Get.arguments?["title"] ?? "Exhibition Details";

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(ExhibitionDetailsController());
    
    return GetBuilder<ExhibitionDetailsController>(
      builder: (ctrl) {
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

        DateTime? startDate = ctrl.exibition?.startDate;
        DateTime? endDate = ctrl.exibition?.endDate;
        String image =
            (ctrl.exibition?.images != null &&
                ctrl.exibition!.images!.isNotEmpty)
            ? ctrl.exibition!.images![0]
            : 'N/A';
        String exibitionTitle = ctrl.exibition?.title ?? 'N/A';
        String creatorName = ctrl.exibition?.creatorId?.name ?? 'N/A';
        String about = ctrl.exibition?.description ?? 'N/A';
        String formatterdStartDate = formattedDate(startDate) ?? 'N/A';
        String formatterdEndDate = formattedDate(endDate) ?? 'N/A';
        String deysRemaining = calculateRemainingDays(DateTime.now(), startDate) ?? 'N/A';
        String visitingHour = ctrl.exibition?.visitingHour ?? 'N/A';
        String venue = ctrl.exibition?.venue ?? 'N/A';
        String ticketPrice = ctrl.exibition?.ticketPrice.toString() ?? 'N/A';
        List<Artist> artist = ctrl.exibition?.artists ?? [];
        String buyTicketURL = ctrl.exibition?.bookingUrl ?? 'N/A';

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, size: 18.sp, color: AppColors.titleColor),
            ),
            title: CommonText(
              text: AppString.exhibitionDetails,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleColor,
            ),
            actions: [
              title == "My Exhibition"
                  ? _moreActions(
                      onEdit: () {
                        Get.toNamed(
                          AppRoutes.createNewExhibitionScreen,
                          arguments: {"title": "Edit Exhibition"},
                        );
                      },
                      onDelete: () => _confirmDelete(context),
                    )
                  : GestureDetector(
                      onTap: () => ctrl.saveToggle(),
                      child: ctrl.isSaved
                          ? Icon(Icons.favorite, size: 18.sp, color: AppColors.titleColor)
                          : Icon(
                              Icons.favorite_border,
                              size: 18.sp,
                              color: AppColors.titleColor,
                            ),
                    ),
              14.width,
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner with virtual tour tag
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Stack(
                        children: [
                          CommonImage(
                            height: 200.h,
                            width: double.infinity,
                            fill: BoxFit.cover,
                            imageSrc: image, //AppImages.exhibitionScreen,
                          ),

                          // Positioned(
                          //   top: 12,
                          //   right: 12,
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          //     decoration: BoxDecoration(
                          //       color: AppColors.primaryColor,
                          //       borderRadius: BorderRadius.circular(20.r),
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           Icons.play_circle_outline,
                          //           size: 16.sp,
                          //           color: AppColors.white,
                          //         ),
                          //         6.width,
                          //         CommonText(
                          //           text: AppString.virtualTour,
                          //           fontSize: 12,
                          //           fontWeight: FontWeight.w500,
                          //           color: AppColors.white,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    14.height,

                    // Title + Curated by
                    CommonText(
                      text: exibitionTitle, // 'Modern Abstractions',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                    6.height,
                    Row(
                      children: [
                        CommonText(
                          text: 'Curated by ',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyClr,
                        ),
                        CommonText(
                          text: creatorName, //'Mark Cena',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),

                    16.height,

                    // About the Exhibition
                    _box(
                      title: AppString.aboutTheExhibition,
                      child: CommonText(
                        text: about,
                        // 'Immerse yourself in a captivating collection of contemporary abstract artworks that challenge perception and ignite imagination. Features 30+ pieces from renowned international artists.',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyClr,
                        textAlign: TextAlign.start,
                        maxLines: 10,
                      ),
                    ),

                    // Exhibition Details
                    _box(
                      title: AppString.exhibitionDetails,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detail(
                            icon: Icons.calendar_month_outlined,
                            label: AppString.duration,
                            value:
                                '$formatterdStartDate - $formatterdEndDate', // '15 July 25 - 30 July 25',
                            subValue:
                                '$deysRemaining days remaining', // '4 Days Remaining',
                            subColor: Colors.green,
                          ),
                          12.height,
                          _detail(
                            icon: Icons.access_time,
                            label: AppString.visitingHour,
                            value: visitingHour, //  '10:00 am - 6:00 pm (Monday Closed)',
                          ),
                          12.height,
                          _detail(
                            icon: Icons.location_on_outlined,
                            label: AppString.venue,
                            value: venue, // 'The Art Collective Gallery, New York',
                          ),
                          12.height,
                          _detail(
                            icon: Icons.confirmation_number_outlined,
                            label: AppString.tickerPrice,
                            value: ticketPrice, // 'General : 18\$',
                          ),
                        ],
                      ),
                    ),

                    // Gallery / Museum
                    Container(
                      padding: EdgeInsets.all(16.r),

                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.stroke),
                      ),

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.stroke,
                            child: ClipOval(
                              child: CommonImage(
                                height: 40.h,
                                width: 40.h,
                                imageSrc: AppImages.ellips,
                                fill: BoxFit.cover,
                              ),
                            ),
                          ),
                          10.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyClr,
                                text: "Gallery / Museum",
                              ),
                              CommonText(
                                text: 'The Art Gallery',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.titleColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    20.height,

                    // Featured Artists
                    CommonText(
                      text: 'Featured Artists',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                    10.height,
                    SizedBox(
                      height: 120.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: artist.length,
                        separatorBuilder: (_, __) => 14.width,
                        itemBuilder: (context, index) {
                          return ArtistItem(
                            name: artist[index].name ?? 'N/A',
                            follower: artist[index].followers ?? 0,
                            profileImage: artist[index].profileImage ?? '',
                          );
                        },
                      ),
                    ),

                    50.height,
                  ],
                ),
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
                ctrl.openInBrowser(buyTicketURL);
              },
              titleText: AppString.getTickets,
            ),
          ),
        );
      },
    );
  }

  Widget _box({required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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

  Widget _detail({
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
