import 'package:flutter/material.dart';

import '../../../constant.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile({
    super.key,
    required this.title,
    required this.pagePosition,
    required this.indexPage,
    required this.pageController,
  });

  final String title;
  final int pagePosition;
  final int indexPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationCircular(
          pagePosition == indexPage
              ? Theme.of(context).primaryColor
              : Colors.white,
          10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => pageController.jumpToPage(pagePosition),
        child: Text(
          title,
          style: TextStyle(
            color: pagePosition == indexPage ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
