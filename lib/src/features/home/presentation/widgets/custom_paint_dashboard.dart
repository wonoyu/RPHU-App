import 'package:flutter/material.dart';
import 'package:rphu_app/src/core/constants/colors.dart';

class DashboardCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.mainGreen
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.0045732);
    path0.lineTo(0, size.height * 0.9232622);
    path0.quadraticBezierTo(size.width * 0.3142389, size.height * 1.0579207,
        size.width * 0.5106383, size.height * 1.0579207);
    path0.quadraticBezierTo(size.width * 0.7070376, size.height * 1.0579207,
        size.width * 1.0000360, size.height * 0.912439);
    path0.lineTo(size.width * 1.0016464, 0);
    path0.lineTo(0, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
