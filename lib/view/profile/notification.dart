import 'package:flutter/material.dart';

class ShoeRelease {
  final String shoeName;
  final String releaseDate;
  final String imageUrl;

  ShoeRelease({
    required this.shoeName,
    required this.releaseDate,
    required this.imageUrl,
  });
}

class Notifications extends StatelessWidget {
  final List<ShoeRelease> releases = [
    ShoeRelease(
      shoeName: "Nike Air Max 90",
      releaseDate: "May 15, 2024",
      imageUrl: "assets/images/nike_air_max_90.jpg",
    ),
    ShoeRelease(
      shoeName: "Adidas Ultraboost",
      releaseDate: "June 1, 2024",
      imageUrl: "assets/images/adidas_ultraboost.jpg",
    ),
    ShoeRelease(
      shoeName: "Jordan Retro 4",
      releaseDate: "June 15, 2024",
      imageUrl: "assets/images/jordan_retro_4.jpg",
    ),
    // Add more releases as needed
  ];

  Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoe Release Notifications"),
      ),
      body: ListView.builder(
        itemCount: releases.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(releases[index].imageUrl),
                ),
                title: Text(
                  releases[index].shoeName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Release Date: ${releases[index].releaseDate}",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  // Add navigation to detailed shoe release page
                },
              ),
            ),
          );
        },
      ),
    );
  }
}