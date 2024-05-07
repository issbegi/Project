import 'package:flutter/material.dart';
import 'package:urbanfootprint/view/checkout/mpesa.dart';
import 'package:urbanfootprint/theme/custom_app_theme.dart';
import '../../../../utils/app_methods.dart';
import '../../../animation/fadeanimation.dart';
import '../../../view/bag/widget/empty_list.dart';
import '../../../data/shoedata.dart';
import '../../../models/models.dart';

class BodyBagView extends StatefulWidget {
  const BodyBagView({Key? key}) : super(key: key);

  @override
  _BodyBagViewState createState() => _BodyBagViewState();
}

class _BodyBagViewState extends State<BodyBagView>
    with SingleTickerProviderStateMixin {
  int lengthsOfItemsOnBag = itemsOnBag.length;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: width,
      height: height,
      child: Column(
        children: [
          topText(width, height),
          Divider(
            color: Colors.grey,
          ),
          itemsOnBag.isEmpty
              ? EmptyList()
              : Column(children: [
                  mainListView(width, height),
                  SizedBox(
                    height: 12,
                  ),
                  bottomInfo(width, height),
                ])
        ],
      ),
    );
  }

  // Top Texts Components
  topText(width, height) {
    return Container(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Bag", style: AppThemes.bagTitle),
            Text(
              "Total ${lengthsOfItemsOnBag} Items",
              style: AppThemes.bagTotalPrice,
            ),
          ],
        ),
      ),
    );
  }

  // Main ListView Components
  mainListView(width, height) {
    return Container(
      width: width,
      height: height / 1.6,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: itemsOnBag.length,
          itemBuilder: (ctx, index) {
            ShoeModel currentBagItem = itemsOnBag[index];

            return FadeAnimation(
              delay: 1.5 * index / 4,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 1),
                width: width,
                height: height / 5.2,
                child: Row(
                  children: [
                    Container(
                      width: width / 2.8,
                      height: height / 5.7,
                      child: Stack(children: [
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Container(
                            width: width / 3.6,
                            height: height / 7.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[350],
                            ),
                          ),
                        ),
                        Positioned(
                            right: 2,
                            bottom: 15,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(-40 / 360),
                              child: Container(
                                width: 140,
                                height: 140,
                                child: Image(
                                  image: AssetImage(
                                    currentBagItem.imgAddress,
                                  ),
                                ),
                              ),
                            ))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentBagItem.model,
                              style: AppThemes.bagProductModel),
                          SizedBox(
                            height: 4,
                          ),
                          Text("\Ksh${currentBagItem.price}",
                              style: AppThemes.bagProductPrice),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    itemsOnBag.remove(currentBagItem);
                                    lengthsOfItemsOnBag = itemsOnBag.length;
                                  });
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.cancel_rounded,
                                    size: 15,
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${currentBagItem.quantity}",
                                style: AppThemes.bagProductNumOfShoe,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (currentBagItem.quantity > 1) {
                                      currentBagItem.quantity--; // Decrease quantity
                                    }
                                  });
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.remove,
                                    size: 15,
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentBagItem.quantity++; // Increase quantity
                                  });
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    size: 15,
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  bottomInfo(width, height) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: height / 7,
      child: Column(
        children: [
          FadeAnimation(
            delay: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TOTAL", style: AppThemes.bagTotalPrice),
                Text("\Ksh${AppMethods.calculateTotalPrice()}",
                    style: AppThemes.bagSumOfItemOnBag),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
 ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Wallet(),
      ),
    );
  },
            child: Text('Pay with Mpesa'),
          ),
        ],
      ),
    );
  }
}
