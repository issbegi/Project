import 'package:flutter/material.dart';
import 'package:urbanfootprint/theme/custom_app_theme.dart';
import '../../../../models/shoe_model.dart';
import '../../../../view/detail/detail_screen.dart';
import '../../../data/shoedata.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          GridView.count(
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            shrinkWrap: true, // Adjusts to the content size
            crossAxisCount: 1, // Display two items in each row
            childAspectRatio: 0.7, // Aspect ratio for item width to height
            mainAxisSpacing: 10, // Spacing between rows
            crossAxisSpacing: 10, // Spacing between columns
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: List.generate(
              availableShoes.length,
              (index) => ShoeItem(model: availableShoes[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoeItem extends StatelessWidget {
  final ShoeModel model;

  const ShoeItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailScreen(
              model: model,
              isComeFromMoreSection: true,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: height / 3, // Adjusted height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(model.imgAddress),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.name,
                style: AppThemes.homeProductName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                model.model,
                style: AppThemes.homeProductModel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\Ksh${model.price.toStringAsFixed(2)}",
                style: AppThemes.homeProductPrice,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
