import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/text_field/common_text_field.dart';
import 'package:tasaned_project/features/another_screens/create_new_exhibition/presentation/controllers/nasim/create_exibition_controller.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';

class CreateExhibitionScreen extends StatelessWidget {
  const CreateExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller using Get.put for proper initialization
    final controller = Get.put(CreateExhibitionController());
    
    return GetBuilder<CreateExhibitionController>(
      builder: (c) => _buildScaffold(c),
    );
  }

  Widget _buildScaffold(CreateExhibitionController c) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 22.sp, color: AppColors.titleColor),
        ),
        title: CommonText(
          text: AppString.createExhibition,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
      ),
      body: Column(
        children: [
          // Step indicator
          _buildStepIndicator(c),

          // Content area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: _buildStepContent(c),
            ),
          ),

          // Bottom buttons
          _buildBottomButtons(c),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(CreateExhibitionController c) {
    final steps = ['Basic Info', 'Gallery', 'Artists', 'Ticket'];
    return Container(
      padding: EdgeInsets.all(16.w),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: steps[c.currentStep],
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.titleColor,
          ),
          12.height,
          Row(
            children: List.generate(4, (i) {
              return Expanded(
                child: Container(
                  height: 6.h,
                  margin: EdgeInsets.only(right: i < 3 ? 6.w : 0),
                  decoration: BoxDecoration(
                    color: i <= c.currentStep
                        ? AppColors.primaryColor
                        : AppColors.normalGray,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(CreateExhibitionController c) {
    switch (c.currentStep) {
      case 0:
        return _buildBasicInfoStep(c);
      case 1:
        return _buildGalleryStep(c);
      case 2:
        return _buildArtistsStep(c);
      case 3:
        return _buildTicketStep(c);
      default:
        return SizedBox();
    }
  }

  // STEP 1: Basic Information
  Widget _buildBasicInfoStep(CreateExhibitionController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(AppString.exhibitionTitle),
        8.height,
        CommonTextField(
          hintText: AppString.enterExhibitionTitle,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
          controller: c.titleCtrl,
        ),
        15.height,
        _label(AppString.description),
        8.height,
        CommonTextField(
          hintText: AppString.writeSomethingAboutTheExhibition,
          maxline: 4,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
          controller: c.descriptionCtrl,
        ),
        12.height,
        _label(AppString.startDate),
        8.height,
        CommonTextField(
          hintText: AppString.mmDdYyyy,
          controller: c.startDateCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
          onTap: c.pickStartDate,
          suffixIcon: Icon(
            Icons.calendar_today_rounded,
            color: AppColors.bodyClr,
            size: 18.sp,
          ),
        ),
        12.height,
        _label(AppString.endDate),
        8.height,
        CommonTextField(
          hintText: AppString.mmDdYyyy,
          controller: c.endDateCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
          onTap: c.pickEndDate,
          suffixIcon: Icon(
            Icons.calendar_today_rounded,
            color: AppColors.bodyClr,
            size: 18.sp,
          ),
        ),
        12.height,
        _label(AppString.visitingHours),
        8.height,
        CommonTextField(
          hintText: AppString.visitingHoursHint,
          controller: c.visitingHoursCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
        ),
        12.height,
        _label(AppString.venue),
        8.height,
        CommonTextField(
          hintText: AppString.egNewYork,
          controller: c.venueCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
        ),
        12.height,
        _label(AppString.gallery),
        8.height,
        CommonTextField(
          hintText: AppString.searchGallery,
          controller: c.galleryCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
          suffixIcon: Icon(Icons.search, color: AppColors.bodyClr),
        ),
        24.height,
      ],
    );
  }

  // STEP 2: Gallery
  Widget _buildGalleryStep(CreateExhibitionController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Exhibition Images *',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        8.height,
        _buildImageUploadArea(c),
        16.height,
        CommonText(
          text: 'Virtual Tour Video *',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        8.height,
        _buildVideoUploadArea(c),
        24.height,
      ],
    );
  }

  Widget _buildImageUploadArea(CreateExhibitionController c) {
    if (c.imagePaths.isEmpty) {
      return InkWell(
        onTap: c.pickImages,
        child: DottedBorder(
          options: RectDottedBorderOptions(
            color: AppColors.stroke,
            strokeWidth: 1,
            dashPattern: const [4, 3],
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image, size: 28.sp, color: AppColors.titleColor),
                8.height,
                CommonText(
                  text: AppString.tapToUploadImage,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                4.height,
                CommonText(
                  text: 'Photos: ${c.photosCount}/10',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final tiles = <Widget>[];
    for (int i = 0; i < c.imagePaths.length; i++) {
      tiles.add(
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.file(
                File(c.imagePaths[i]),
                height: 90.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: () => c.removeImageAt(i),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (c.photosCount < CreateExhibitionController.maxPhotos) {
      tiles.add(
        InkWell(
          onTap: c.pickImages,
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: AppColors.searchBg,
              border: Border.all(color: AppColors.stroke),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.bodyClr),
                  4.height,
                  CommonText(
                    text: AppString.upload,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyClr,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      itemCount: tiles.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 90.h,
      ),
      itemBuilder: (_, i) => tiles[i],
    );
  }

  Widget _buildVideoUploadArea(CreateExhibitionController c) {
    return InkWell(
      onTap: c.pickVideo,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          color: AppColors.stroke,
          strokeWidth: 1,
          dashPattern: const [4, 3],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 25.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.videocam_outlined, color: AppColors.titleColor),
              8.height,
              CommonText(
                text: 'Upload Virtual Tour Video',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              if (c.videoPath != null) ...[
                6.height,
                CommonText(
                  text: 'Selected: ${c.videoPath!.split('/').last}',
                  fontSize: 12,
                  color: AppColors.bodyClr,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // STEP 3: Feature Artists
  Widget _buildArtistsStep(CreateExhibitionController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Add Artists',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        8.height,
        CommonTextField(
          hintText: AppString.searchArtist,
          fillColor: AppColors.white,
          borderColor: AppColors.stroke,
          prefixIcon: Icon(Icons.search, color: AppColors.normalGray2),
          onSubmitted: (v) => c.searchArtists(v),
        ),
        12.height,
        if (c.isLoadingArtists)
          Center(child: CircularProgressIndicator())
        else if (c.visibleArtists.isNotEmpty)
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: c.visibleArtists.length,
            separatorBuilder: (_, __) => 10.height,
            itemBuilder: (_, i) {
              final artist = c.visibleArtists[i];
              final selected = c.isArtistSelected(artist);
              return _buildArtistItem(c, artist, selected);
            },
          ),
        if (c.selectedArtists.isNotEmpty) ...[20.height, _buildSelectedArtists(c)],
        24.height,
      ],
    );
  }

  Widget _buildArtistItem(CreateExhibitionController c, artist, bool selected) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          CommonImage(
            imageSrc: artist.profileImage ?? 'assets/images/artist_profile.png',
            height: 40.w,
            width: 40.w,
            borderRadius: 8.r,
            fill: BoxFit.cover,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: artist.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                  textAlign: TextAlign.left,
                ),
                4.height,
                CommonText(
                  text: '${artist.role} | ${artist.followersText}',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => c.toggleArtistSelection(artist),
            child: Container(
              height: 18.w,
              width: 18.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: Icon(
                selected ? Icons.check : Icons.add,
                color: AppColors.white,
                size: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedArtists(CreateExhibitionController c) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Selected Artists',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.titleColor,
            textAlign: TextAlign.left,
          ),
          12.height,
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: c.selectedArtists.length,
            separatorBuilder: (_, __) => 10.height,
            itemBuilder: (_, i) {
              final artist = c.selectedArtists[i];
              return _buildSelectedArtistItem(c, artist);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedArtistItem(CreateExhibitionController c, artist) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          CommonImage(
            imageSrc: artist.profileImage ?? 'assets/images/artist_profile.png',
            height: 44.w,
            width: 44.w,
            borderRadius: 8.r,
            fill: BoxFit.cover,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: artist.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                  textAlign: TextAlign.left,
                ),
                4.height,
                CommonText(
                  text: '${artist.role} | ${artist.followersText}',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyClr,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => c.removeArtistSelection(artist),
            child: Container(
              height: 18.w,
              width: 18.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE74C3C),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(Icons.close, color: AppColors.white, size: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // STEP 4: Ticket & Booking
  Widget _buildTicketStep(CreateExhibitionController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Ticket Price *',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          textAlign: TextAlign.left,
        ),
        8.height,
        CommonTextField(
          hintText: 'Enter Amount',
          prefixIcon: Icon(Icons.attach_money, color: AppColors.normalGray2),
          keyboardType: TextInputType.number,
          controller: c.priceCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
        ),
        16.height,
        CommonText(
          text: 'Booking URL *',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          textAlign: TextAlign.left,
        ),
        8.height,
        CommonTextField(
          hintText: 'Enter booking URL',
          controller: c.bookingUrlCtrl,
          borderColor: AppColors.stroke,
          fillColor: AppColors.white,
          keyboardType: TextInputType.url,
        ),
        24.height,
      ],
    );
  }

  Widget _buildBottomButtons(CreateExhibitionController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.stroke)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (c.currentStep > 0)
            CommonButton(
              buttonRadius: 60,
              titleColor: AppColors.bodyClr,
              borderColor: AppColors.stroke,
              buttonColor: AppColors.white,
              titleText: 'Previous',
              onTap: c.goToPreviousStep,
            ),
          if (c.currentStep > 0) 12.height,
          CommonButton(
            buttonRadius: 60,
            titleColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            buttonColor: AppColors.white,
            titleText: AppString.saveAsDraft,
            onTap: c.saveAsDraft,
          ),
          12.height,
          CommonButton(
            titleText: c.currentStep < 3 ? 'Next' : 'Publish',
            buttonRadius: 60,
            onTap: c.isSubmitting
                ? null
                : () {
                    if (c.currentStep < 3) {
                      c.goToNextStep();
                    } else {
                      c.createExhibition();
                    }
                  },
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return CommonText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.titleColor,
    );
  }
}
