import 'package:deu_pet/data/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import '../theme/colors.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({ Key? key }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
      bottomSheet: getFooter(),
    );
  }

  getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          maxWidth: size.width,
          maxHeight: size.height * 0.75,
          minWidth: size.width * 0.75,
          minHeight: size.height * 0.6,
          cardBuilder: (context, index) => 
            Container(), 
          totalNum: null),
      ),
    );
  }

  getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index){
          return Container(
            width: item_icons[index]['size'],
            height: item_icons[index]['size'],
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white,
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10
                )  
              ]),
              child: Center(
                child: SvgPicture.asset(item_icons[index]['icon'], 
                  width: item_icons[index]['icon_size'],
                ),
              ),
          );
        })),
      ),
    );
  }
}