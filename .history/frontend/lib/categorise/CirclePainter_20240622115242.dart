import 'package:flutter/material.dart';

class MyCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color.fromARGB(255, 27, 17, 122)
      ..style = PaintingStyle.fill;

    // Draw the second circle
    final secondCenter = Offset(size.width / 3.4, size.height / 1.7);
    final secondRadius = size.width / 4;
    canvas.drawCircle(secondCenter, secondRadius, paint);

    // Draw the third circle
    final thirdCenter = Offset(size.width * 0.75, size.height * 0.75);
    final thirdRadius = size.width / 9;
    canvas.drawCircle(thirdCenter, thirdRadius, paint);

    // Draw the fifth circle
    final fifthCenter = Offset(size.width * 0.73, size.height * 0.33);
    final fifthRadius = size.width / 6;
    canvas.drawCircle(fifthCenter, fifthRadius, paint);

    // Draw the sixth circle
    final sithCenter = Offset(size.width * 0.5, size.height * 0.1);
    final sixthRadius = size.width / 12;
    canvas.drawCircle(sithCenter, sixthRadius, paint);

    // Draw the fourth circle as an outline (not filled)
    final fourthCenter = Offset(size.width / 3.4, size.height / 1.7);
    final fourthRadius = size.width / 3.75;
    paint.color = Color.fromARGB(255, 229, 228, 236);
    paint.style = PaintingStyle.stroke; // Set the style to stroke
    paint.strokeWidth = 2.0; // Adjust the outline thickness as needed
    canvas.drawCircle(fourthCenter, fourthRadius, paint);

    // Draw the first circle
    final Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 27, 17, 122)
      ..style = PaintingStyle.fill;
    final firstCenter = Offset(size.width / 7, size.height / 1.15);
    final firstRadius = size.width / 11.5;
    paint1.color = const Color.fromARGB(255, 27, 17, 122);
    canvas.drawCircle(firstCenter, firstRadius, paint1);

    // Add more circles as needed with different center points
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyCircleWidget extends StatelessWidget {
  const MyCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: MyCirclePainter(), // Adjust the size as needed
      child: const Stack(
        children: [
          Positioned(
            left: 300 * 0.94, // Adjust the position as needed
            top: 300 * 0.66, // Adjust the position as needed
            child: Icon(
              Icons.add, // Replace with your desired icon
              size: 55, // Adjust the icon size as needed
              color: Colors.white, // Customize the icon color
            ),
          ),
          Positioned(
            left: 300 * 0.07,
            top: 300 * 0.25,
            child: Image(
                image: AssetImage('assets/pages/page1_remove.png'),
                height: 200,
                width: 200),
          ),
          Positioned(
            left: 300 * 0.115,
            top: 300 * 0.8,
            child: Icon(
              Icons.lightbulb, // Replace with your desired icon
              size: 46, // Adjust the icon size as needed
              color: Colors.white, // Customize the icon color
            ),
          ),
        ],
      ),
    );
  }
}
