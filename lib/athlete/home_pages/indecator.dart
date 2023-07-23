import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularIndicator extends StatelessWidget {
  int value;
   CircularIndicator({super.key,  required this.value});




  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/R.7dee08d8ea8a2c62c7cd60c2f6ed1b0a?rik=m%2bIAue%2fKOvX9ZA&pid=ImgRaw&r=0'
              ),
            ),
            Container(

              child: CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 15.0,
                percent: value/100,
                animation: true,
                animationDuration: 1500,
                center: new Text(
                  '$value%',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),

                progressColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
          ],

    );
  }
}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height); //start path with this if you are making at bottom
    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(firstStart.dx, firstStart.dy,
        firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 3.24),
        size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(secondStart.dx, secondStart.dy,
        secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}