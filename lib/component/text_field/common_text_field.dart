import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.mexLength,
    this.maxline = 1,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 16,
    this.paddingVertical = 14,
    this.borderRadius = 10,
    this.inputFormatters,
    this.fillColor = AppColors.white,
    this.hintTextColor = AppColors.textFiledColor,
    this.labelTextColor = AppColors.textFiledColor,
    this.textColor = AppColors.black,
    this.borderColor = AppColors.transparent,
    this.onSubmitted,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color borderColor;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final int? mexLength;
  final int? maxline;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true; // Initially set to true for password visibility toggle

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      maxLines: widget.maxline,
      obscureText: widget.isPassword ? _obscureText : false,
      textInputAction: widget.textInputAction,
      maxLength: widget.mexLength,
      cursorColor: AppColors.white,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(fontSize: 14, color: widget.textColor),
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        prefixIcon: widget.prefixIcon,
        fillColor: widget.fillColor,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.paddingHorizontal.w,
          vertical: widget.paddingVertical.h,
        ),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        errorBorder: _buildBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: GoogleFonts.roboto(fontSize: 14, color: widget.hintTextColor),
        labelStyle: GoogleFonts.roboto(fontSize: 14, color: widget.labelTextColor),
        prefix: CommonText(text: widget.prefixText ?? "", fontWeight: FontWeight.w400),
        suffixIcon: widget.isPassword ? _buildPasswordSuffixIcon() : widget.suffixIcon,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(color: widget.borderColor),
    );
  }

  Widget _buildPasswordSuffixIcon() {
    return GestureDetector(
      onTap: _togglePasswordVisibility, // Use _togglePasswordVisibility method
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        child: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 20.sp,
          color: AppColors.normalGray2,
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
