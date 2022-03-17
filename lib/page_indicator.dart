import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final PageController pageController;

  const PageIndicator({
    required this.pageController,
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // pageController.addListener(() {
    //   print('pixels' + (pageController.position.pixels).toString());
    // });
    return AnimatedBuilder(
      builder: (context, child) {
        return CustomPaint(
            painter: PageIndicatorPainter(
              pageCount: 3,
              dotRadius: 10,
              dotOutlineThickness: 3,
              spacing: 25,
              scrollPosition: pageController.hasClients ? pageController.page ?? 0.0 : 0.0,
              // scrollPosition: 0.5,
              dotFillPaint: const Color(0x0F000000),
              dotOutlinePaint: const Color(0x20000000),
              indicatorColor: const Color(0xFF444444),
            )
        );
      },
      animation: pageController,
    );
  }

}

class PageIndicatorPainter extends CustomPainter {
  PageIndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.spacing,
    required this.dotOutlineThickness,
    required this.scrollPosition,
    required Color dotFillPaint,
    required Color dotOutlinePaint,
    required Color indicatorColor
  })  : dotFillPaint = Paint()..color = dotFillPaint,
        dotOutlinePaint = Paint()..color = dotOutlinePaint,
        indicatorPaint = Paint()..color = indicatorColor;

  final int pageCount;
  final double dotRadius;
  final double dotOutlineThickness;
  final double spacing;
  final double scrollPosition;
  final Paint dotFillPaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;


  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final totalWidth = (pageCount * (2 * dotRadius)) + ((pageCount - 1) * spacing);

    _drawDots(canvas, center, totalWidth);
    _drawPageIndicator(canvas, center, totalWidth);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWidth) {
    final double pageIndexToLeft = scrollPosition.floorToDouble();
    final double leftDotX = (center.dx - (totalWidth / 2)) + (pageIndexToLeft * ((2 * dotRadius) + spacing));
    final double transitionPercent = scrollPosition - pageIndexToLeft;

    final double laggingLeftPositionPercent = (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;

    final double indicatorLeftX = leftDotX + (laggingLeftPositionPercent * ((2 * dotRadius) + spacing));
    final double acceleratedRightPositionPercent = (transitionPercent / 0.5).clamp(0.0, 1.0);
    final double indicatorRightX = leftDotX + (acceleratedRightPositionPercent * ((2 * dotRadius) + spacing)) + (2 * dotRadius);

    canvas.drawRRect(
        RRect.fromLTRBR(
            indicatorLeftX,
            -dotRadius,
            indicatorRightX,
            dotRadius,
            Radius.circular(dotRadius),
        ),
        indicatorPaint,
    );
  }

  void _drawDots(Canvas canvas, Offset center, double totalWidth) {
    Offset dotCenter = center.translate((-totalWidth / 2) + dotRadius, 0);

    for (int i = 0; i < pageCount; i++) {
      _drawDot(canvas, dotCenter);
      dotCenter = dotCenter.translate((2 * dotRadius) + spacing, 0);
    }
  }

  void _drawDot(Canvas canvas, Offset dotCenter) {
    canvas.drawCircle(dotCenter, dotRadius - dotOutlineThickness, dotFillPaint);

    final outlinePath = Path()
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadius))
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadius - dotOutlineThickness))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
