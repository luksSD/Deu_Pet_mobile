import 'package:deu_pet/pages/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/colors.dart';

class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    var itens = [
      pageIndex == 0 ? "/images/explore_active_icon.svg"
      : "/images/explore_icon.svg",
      pageIndex == 1 ? "/images/likes_active_icon.svg"
      : "/images/likes_icon.svg",
      pageIndex == 2 ? "/images/chat_active_icon.svg"
      : "/images/chat_icon.svg",
      pageIndex == 3 ? "/images/account_active_icon.svg"
      : "/images/account_icon.svg",

    ];
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itens.length, (index){
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              }, 
              icon: SvgPicture.asset(itens[index]),
            );
          }),
        ),
      ),
    );
  }

  getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        ExplorePage(),
      ],
    );
  }
}