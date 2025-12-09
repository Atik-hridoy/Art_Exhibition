import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/component/button/common_button.dart';
import 'package:tasaned_project/features/another_screens/another_screens_repository/another_screen_repository.dart';
import 'package:tasaned_project/component/image/common_image.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/order_info_table.dart';
import 'package:tasaned_project/features/another_screens/drawer_screens/presentation/widgets/my_information_card.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';
import 'package:tasaned_project/utils/constants/app_string.dart';
import 'package:tasaned_project/utils/extensions/extension.dart';
import 'package:tasaned_project/utils/app_utils.dart';
import '../../../../../config/route/app_routes.dart';

class OfferDetailsScreen extends StatefulWidget {
  final String offerId;
  
  const OfferDetailsScreen({super.key, required this.offerId});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  final OrderHistoryRepository _repository = OrderHistoryRepository();
  bool isLoading = true;
  bool isCreatingOrder = false;
  Map<String, dynamic>? offerData;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchOfferDetails();
  }

  Future<void> _fetchOfferDetails() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final response = await _repository.getOfferDetails(widget.offerId);
      
      if (response != null) {
        setState(() {
          offerData = response;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatOfferId(String? offerId) {
    if (offerId == null || offerId.isEmpty) return '--';
    if (offerId.length <= 8) return offerId;
    return offerId.substring(offerId.length - 8);
  }

  String _formatOfferDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '--';
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('MMM d, yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.amber;
      case 'confirmed':
        return Colors.green;
      case 'rejected':
      case 'canceled':
      case 'expired':
        return Colors.red;
      default:
        return AppColors.titleColor;
    }
  }

  bool _isOfferAccepted() {
    final status = offerData?['status']?.toString().toLowerCase() ?? '';
    return status == 'confirmed' || status == 'accepted';
  }

  bool _isOfferPending() {
    final status = offerData?['status']?.toString().toLowerCase() ?? '';
    return status == 'pending';
  }

  /// Create order from accepted offer
  Future<void> _createOrderFromOffer() async {
    if (offerData == null) return;

    try {
      setState(() {
        isCreatingOrder = true;
      });

      final offer = offerData!;
      final art = offer['art'] as Map<String, dynamic>? ?? {};
      final shippingAddress = offer['shippingAddress'] as Map<String, dynamic>? ?? {};

      // Extract required data
      final artId = (art['_id'] ?? offer['artId'] ?? '').toString();
      final price = double.tryParse(offer['priceOffer']?.toString() ?? '0') ?? 0.0;
      final offerId = offer['_id']?.toString() ?? '';
      final additionalNote = offer['additionalNote']?.toString() ?? '';

      if (artId.isEmpty || offerId.isEmpty) {
        Utils.errorSnackBar('Error', 'Missing required information');
        return;
      }

      // Create order using repository
      log('Creating order with data: artId=$artId, price=$price, offerId=$offerId');
      final response = await _repository.createOrderFromOffer(
        artId: artId,
        price: price,
        offerId: offerId,
        shippingAddress: shippingAddress,
        additionalNote: additionalNote,
      );

      setState(() {
        isCreatingOrder = false;
      });

      log('Order creation response: ${response?.statusCode}, data: ${response?.data}');

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        Utils.successSnackBar('Success', 'Order created successfully!');
        
        // Check if there's a payment link in the response
        final paymentLink = response.data['data']?.toString() ??  // Direct data field
                           response.data['paymentLink']?.toString() ?? 
                           response.data['data']?['paymentLink']?.toString() ??
                           response.data['payment_url']?.toString() ??
                           response.data['data']?['payment_url']?.toString();
        
        log('Payment link found: $paymentLink');
        
        if (paymentLink != null && paymentLink.isNotEmpty) {
          Utils.successSnackBar('Success', 'Redirecting to payment...');
          // Navigate to payment webview with the payment link
          Get.toNamed(
            AppRoutes.paymentCheckoutWebView,
            arguments: {
              'url': paymentLink,
              'successUrl': '', 
            },
          );
        } else {
          Utils.errorSnackBar('Error', 'No payment link received');
        }
      } else {
        // Show detailed error message
        final errorMessage = response?.message ?? 'Failed to create order. Please try again.';
        final statusCode = response?.statusCode ?? 'Unknown';
        log('Order creation failed: Status $statusCode, Error: $errorMessage');
        Utils.errorSnackBar('Error', 'Failed to create order (Status: $statusCode): $errorMessage');
      }
    } catch (e) {
      setState(() {
        isCreatingOrder = false;
      });
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        title: CommonText(
          text: 'Offer Details',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.titleColor),
        ),
        actions: [
          IconButton(
            onPressed: _fetchOfferDetails,
            icon: Icon(Icons.refresh, color: AppColors.titleColor, size: 22.sp),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonText(
                        text: 'Error loading offer details',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                      12.height,
                      CommonText(
                        text: error!,
                        fontSize: 14,
                        color: AppColors.titleColor.withOpacity(0.7),
                      ),
                      16.height,
                      ElevatedButton(
                        onPressed: _fetchOfferDetails,
                        child: const CommonText(
                          text: 'Retry',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : offerData == null
                  ? Center(child: CommonText(text: 'No offer data found'))
                  : _buildOfferDetails(),
    );
  }

  Widget _buildOfferDetails() {
    final offer = offerData!;
    final art = offer['art'] as Map<String, dynamic>? ?? {};
    final shippingAddress = offer['shippingAddress'] as Map<String, dynamic>? ?? {};
    
    final title = (art['title'] ?? offer['title'] ?? '').toString();
    final price = (offer['priceOffer'] ?? offer['price'] ?? art['price'] ?? 0).toString();
    final images = <String>[
      if ((art['images'] as List?)?.isNotEmpty == true) 
        (art['images'] as List).first.toString(),
      if ((art['image'] ?? '').toString().isNotEmpty) art['image'].toString(),
      if ((offer['artImage'] ?? '').toString().isNotEmpty) offer['artImage'].toString(),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Padding(
              padding: EdgeInsets.all(16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.yelloFade,
                  ),
                  child: images.isNotEmpty
                      ? PageView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return CommonImage(
                              height: 300.h,
                              width: double.infinity,
                              fill: BoxFit.cover,
                              imageSrc: images[index],
                            );
                          },
                        )
                      : Center(
                          child: CommonText(
                            text: 'No Image Available',
                            fontSize: 14,
                            color: AppColors.titleColor.withOpacity(0.5),
                          ),
                        ),
                ),
              ),
            ),
            
            // Art Title and Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title.isNotEmpty ? title : 'Untitled Art',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleColor,
                  ),
                  5.height,
                  CommonText(
                    text: AppString.abstractLabel,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.titleColorSecondary,
                  ),
                  8.height,
                  Row(
                    children: [
                      CommonText(
                        text: '\$${offer['priceOffer'] ?? offer['price'] ?? '0'}',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                      8.width,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: _getStatusColor(offer['status'] ?? 'Pending').withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CommonText(
                          text: offer['status'] ?? 'Pending',
                          color: _getStatusColor(offer['status'] ?? 'Pending'),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            20.height,
            
            // Offer Details Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CommonText(
                text: 'Offer Details',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
            8.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: InfoTable(rows: [
                RowItem('Offer ID', _formatOfferId(offer['_id']?.toString())),
                RowItem('Offer Date', _formatOfferDate(offer['createdAt']?.toString())),
                RowItem('Offer Status', offer['status'] ?? 'Pending'),
                RowItem('Offer Price', '\$$price'),
                if (offer['additionalNote'] != null)
                  RowItem('Additional Note', offer['additionalNote'].toString()),
              ]),
            ),
            
            24.height,
            
            // My Information Section
            if (shippingAddress.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CommonText(
                  text: AppString.myInformation,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleColor,
                ),
              ),
              8.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MyInformationCard(
                  name: shippingAddress['name']?.toString(),
                  phone: shippingAddress['phone']?.toString(),
                  address: shippingAddress['address']?.toString(),
                ),
              ),
              24.height,
            ],
            
            // Additional Information Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CommonText(
                text: AppString.additionalInformation,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
            8.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: AppColors.primaryColor, width: 3)),
                  color: AppColors.yelloFade,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CommonText(
                  text: (offer['additionalNote']?.toString().isNotEmpty == true)
                      ? offer['additionalNote'].toString()
                      : AppString.callMeBeforeSending,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
              ),
            ),
            
            20.height,
            
            // Conditional buttons based on offer status
            if (_isOfferAccepted()) ...[
              // Place Order Button - Only show when offer is accepted
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CommonButton(
                  titleText: isCreatingOrder ? 'Creating Order...' : 'Place Order',
                  buttonRadius: 60,
                  onTap: isCreatingOrder ? null : _createOrderFromOffer,
                ),
              ),
              16.height,
            ],
            
            // View Product Details Button - Only show when offer is NOT pending
            if (!_isOfferPending()) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CommonButton(
                  buttonColor: AppColors.transparent,
                  titleText: AppString.viewProductDetails,
                  buttonRadius: 60,
                  titleColor: AppColors.primaryColor,
                  onTap: () {
                    final artId = (art['_id'] ?? offer['artId'] ?? '').toString();
                    if (artId.isNotEmpty) {
                      Get.toNamed(
                        AppRoutes.artDetailsScreen,
                        arguments: {
                          "screenType": "offerDetails",
                          "artId": artId,
                        },
                      );
                    }
                  },
                ),
              ),
              20.height,
            ],
            
            20.height,
          ],
        ),
      ),
    );
  }
}