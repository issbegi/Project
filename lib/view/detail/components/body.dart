// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../animation/fadeanimation.dart';
import '../../../../../utils/app_methods.dart';
import '../../../../../utils/constants.dart';
import '../../../../../models/shoe_model.dart';
import '../../../data/shoedata.dart';
import '../../../models/models.dart';
import '../../../theme/custom_app_theme.dart';

class DetailsBody extends StatefulWidget {
  ShoeModel model;
  bool isComeFromMoreSection;
  DetailsBody({required this.model, required this.isComeFromMoreSection});

  @override
  details createState() => details();
}

class details extends State<DetailsBody> {
  bool _isSelectedCountry = false;
  int? _isSelectedSize;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 1.1,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            topInformationWidget(width, height),
            
            SizedBox(
              height: 20,
              width: width / 1.1,
              child: Divider(
                thickness: 1.4,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  nameAndPrice(),
                  SizedBox(height: 10),
                  shoeInfo(width, height),
                  SizedBox(
                    height: 5,
                  ),
                  moreDetailsText(width, height),
                  sizeTextAndCountry(width, height),
                  SizedBox(
                    height: 10,
                  ),
                  endSizesAndButton(width, height),
                  SizedBox(
                    height: 20,
                  ),
                  materialButton(width, height),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Top information Widget Components
  topInformationWidget(width, height) {
    return Container(
      width: width,
      height: height / 2.3,
      child: Stack(
        children: [
          Positioned(
            left: 50,
            bottom: 20,
            child: FadeAnimation(
              delay: 0.5,
              child: Container(
                width: 1000,
                height: height / 2.2,
                decoration: BoxDecoration(
                  color: widget.model.modelColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(1500),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 30,
            child: Hero(
              tag: widget.isComeFromMoreSection
                  ? widget.model.model
                  : widget.model.imgAddress,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(-25 / 360),
                child: Container(
                  width: width / 1.3,
                  height: height / 4.3,
                  child: Image(image: AssetImage(widget.model.imgAddress)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

 

  // Middle Image List Widget Components
 

  //MaterialButton Components
  materialButton(width, height) {
    return FadeAnimation(
      delay: 3.5,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minWidth: width / 1.2,
        height: height / 15,
        color: AppConstantsColor.materialButtonColor,
        onPressed: () {
          AppMethods.addToCart(widget.model, context);
        },
        child: Text(
          "ADD TO BAG",
          style: TextStyle(color: AppConstantsColor.lightTextColor),
        ),
      ),
    );
  }

  //end section Sizes And Button Components
  endSizesAndButton(width, height) {
    return Container(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 3,
        child: Row(
          children: [
            Container(
              width: width / 4.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Try it",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    RotatedBox(
                        quarterTurns: -1,
                        child: FaIcon(FontAwesomeIcons.shoePrints))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: width / 1.5,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelectedSize = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        width: width / 4.4,
                        height: height / 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: _isSelectedSize == index
                                  ? Colors.black
                                  : Colors.grey,
                              width: 1.5),
                          color: _isSelectedSize == index
                              ? Colors.black
                              : AppConstantsColor.backgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            sizes[index].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isSelectedSize == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  //Size Text And Country Button Components
  sizeTextAndCountry(width, height) {
    return FadeAnimation(
      delay: 2.5,
      child: Row(
        children: [
          Text(
            "Size",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppConstantsColor.darkTextColor,
              fontSize: 22,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            width: width / 9,
           
          ),
          Container(
            width: width / 5,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isSelectedCountry = true;
                });
              },
              child: Text(
                "USA",
                style: TextStyle(
                  fontWeight:
                      _isSelectedCountry ? FontWeight.bold : FontWeight.w400,
                  color: _isSelectedCountry
                      ? AppConstantsColor.darkTextColor
                      : Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //more details Text Components
  moreDetailsText(width, height) {
    return FadeAnimation(
      delay: 2,
      child: Container(
        padding: EdgeInsets.only(right: 280),
        height: height / 26,
  
      ),
    );
  }

  //About Shoe Text Components
  shoeInfo(width, height) {
    return FadeAnimation(
      delay: 1.5,
      child: Container(
        width: width,
        height: height / 9,
      child: Text(
        "Embrace the power of self-expression with shoes that speak volumes without saying a word. Elevate your style, elevate and your confidence.",
        style: TextStyle(
          fontFamily: 'Alegreya',
          fontSize: 16,
          color: Colors.black, // Changed text color to black
        ),
      ),
    ),
  );
}

  //Name And Price Text Components
  nameAndPrice() {
    return FadeAnimation(
      delay: 1,
      child: Row(
        children: [
          Text(
            widget.model.model,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: AppConstantsColor.darkTextColor,
            ),
          ),
          Expanded(child: Container()),
          Text('\Ksh${widget.model.price.toStringAsFixed(2)}',
              style: AppThemes.detailsProductPrice),
        ],
      ),
    );
  }
}
