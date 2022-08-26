// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:proyectoadmfpl/Vista/Themes/config.dart';

class BackgroundPainter extends CustomPainter {
  final bluePaint;
  final greeyPaint;
  final orangePaint;

  Animation<double> liquiAnim;
  Animation<double> blueAnim;
  Animation<double> greyAnim;
  Animation<double> orangeAnim;

  BackgroundPainter({required Animation<double> animation})
      : bluePaint = Paint()
          ..color = Palette().celesteLigth
          ..style = PaintingStyle.fill,
        greeyPaint = Paint()
          ..color = Palette().celesteClaro
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = Palette().orangeLigth
          ..style = PaintingStyle.fill,
        liquiAnim = CurvedAnimation(
            curve: Curves.elasticInOut,
            reverseCurve: Curves.easeInBack,
            parent: animation),
        orangeAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.7,
              curve: Interval(0, 0.8, curve: SpringCurve())),
        ),
        greyAnim = CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 0.7,
                curve: Interval(0, 0.8, curve: SpringCurve()))),
        blueAnim = CurvedAnimation(
            parent: animation,
            curve: const SpringCurve(),
            reverseCurve: Curves.easeInCirc),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(canvas, size);
    paintGrey(canvas, size);
    paintOrange(canvas, size);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, lerpDouble(0, size.height, blueAnim.value)!.toDouble());
    _addPointsToPath(path, [
      Point(lerpDouble(0, size.width / 3, blueAnim.value)!.toDouble(),
          lerpDouble(0, size.height, blueAnim.value)!.toDouble()),
      Point(lerpDouble(size.width / 2, size.width / 4 * 3, liquiAnim.value)!.toDouble(),
          lerpDouble(size.height / 2, size.height / 4 * 3, liquiAnim.value)!.toDouble()),
      Point(size.width,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquiAnim.value)!.toDouble()),
    ]);
    canvas.drawPath(path, bluePaint);
  }

  void paintGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
        0, lerpDouble(size.height / 4, size.height / 2, greyAnim.value)!.toDouble());
    _addPointsToPath(path, [
      Point(size.width / 4,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquiAnim.value)!.toDouble()),
      Point(size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquiAnim.value)!.toDouble()),
      Point(size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, greyAnim.value)!.toDouble()),
      Point(size.width,
          lerpDouble(size.height / 5, size.height / 4, greyAnim.value)!.toDouble()),
    ]);
    canvas.drawPath(path, greeyPaint);
  }

  void paintOrange(Canvas canvas, Size size) {
    if (orangeAnim.value > 0) {
      final path = Path();
      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(0, lerpDouble(0, size.height / 12, orangeAnim.value)!.toDouble());
      _addPointsToPath(path, [
        Point(size.width / 7, lerpDouble(0, size.height / 6, liquiAnim.value)!.toDouble()),
        Point(size.width / 3, lerpDouble(0, size.height / 10, liquiAnim.value)!.toDouble()),
        Point(size.width / 3 * 2,
            lerpDouble(0, size.height / 10, greyAnim.value)!.toDouble()),
        Point(
          size.width * 3 / 4,
          0,
        )
      ]);
      canvas.drawPath(path, orangePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      return;
      // throw UnssuportedError('Necesita 3 o mas puntos para crear el path');
    }
    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  final a;
  final w;

  const SpringCurve({this.a = 0.15, this.w = 19.4});

  @override
  double transformInternal(double t) {
    // TODO: implement transformInternal
    // return super.transformInternal(t);
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
