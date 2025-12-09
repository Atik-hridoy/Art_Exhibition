import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasaned_project/component/text/common_text.dart';
import 'package:tasaned_project/utils/constants/app_colors.dart';

class RowItem {
  final String label;
  final String value;
  const RowItem(this.label, this.value);
}

class InfoTable extends StatelessWidget {
  const InfoTable({super.key, required this.rows});
  final List<RowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: rows
            .asMap()
            .entries
            .map((entry) => _InfoRow(
                  label: entry.value.label,
                  value: entry.value.value,
                  showDivider: entry.key != rows.length - 1,
                ))
            .toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.showDivider = true});
  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: CommonText(
                  text: label,
                  fontSize: 12,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bodyClr,
                ),
              ),
              Expanded(
                child: CommonText(
                  text: value,
                  fontSize: 12,
                  textAlign: TextAlign.end,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Divider(height: 1, thickness: 1, color: AppColors.stroke),
          ),
      ],
    );
  }
}
