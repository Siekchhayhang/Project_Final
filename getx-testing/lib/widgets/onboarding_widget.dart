import 'package:flutter/material.dart';

class OnboardWidgets extends StatelessWidget {
  final String? title;
  final String image;
  final String subtitle;
  final Color? color;

  const OnboardWidgets(
      {super.key,
      this.title,
      required this.image,
      required this.subtitle,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: color ?? Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.headline5,
              ),
              Image.asset(image),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
