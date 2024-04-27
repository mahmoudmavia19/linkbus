import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionPlus extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final double? imageWidth;
  final double? imageHeight;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final bool? isLotte ;

  IntroductionPlus({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.titleTextStyle = const TextStyle(fontSize: 30),
    this.subTitleTextStyle = const TextStyle(fontSize: 20),
    this.imageWidth = 360,
    this.imageHeight = 360,
    this.isLotte = true,
  });

  @override
  State<StatefulWidget> createState() {
    return new IntroductionState();
  }
}

class IntroductionState extends State<IntroductionPlus> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:widget.isLotte == true ? Lottie.asset(
                widget.imageUrl,
                height: widget.imageHeight,
                width: widget.imageWidth,
              ):Image.asset(
                widget.imageUrl,
                height: widget.imageHeight,
                width: widget.imageWidth,
              )
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: widget.titleTextStyle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.subTitle,
              style: widget.subTitleTextStyle,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
