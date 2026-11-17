import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/membership_badge.dart';
import 'package:mms/features/members/data/response/member_response.dart';
import 'package:mms/generated/l10n.dart';

/// Committee members drawer content (order as received).
class MembersListWidget extends StatelessWidget {
  const MembersListWidget({super.key, required this.members});

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 64.0.h,
            padding: EdgeInsetsDirectional.only(start: 16.0.w, end: 8.0.w),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColorManager.neutral50)),
            ),
            child: Row(
              children: [
                DrawableText(
                  text: S.of(context).members,
                  size: 18.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                ),
                8.0.horizontalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  decoration: BoxDecoration(
                    color: AppColorManager.neutral50,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: DrawableText(
                    text: '${members.length}',
                    size: 13.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: S.of(context).close,
                  constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
                  onPressed: () => Navigator.pop(context),
                  icon: ImageMultiType(
                    url: Icons.close_rounded,
                    width: 22.0.r,
                    height: 22.0.r,
                    color: AppColorManager.neutral700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              itemCount: members.length,
              itemBuilder: (context, i) => _MemberRow(member: members[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 64.0.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        children: [
          AppAvatar(url: member.party.personalPhoto, name: member.party.name, size: 44),
          12.0.horizontalSpace,
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: DrawableText(
                    text: member.party.name,
                    size: 15.0.sp,
                    fontWeight: .w600,
                    color: AppColorManager.neutral900,
                    maxLines: 1,
                  ),
                ),
                if (member.isMe) ...[
                  8.0.horizontalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    decoration: BoxDecoration(
                      color: AppColorManager.neutral50,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: DrawableText(
                      text: S.of(context).you,
                      size: 12.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          8.0.horizontalSpace,
          MembershipBadge(type: member.membershipType),
        ],
      ),
    );
  }
}
