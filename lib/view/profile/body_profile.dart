import 'package:flutter/material.dart';
import 'package:urbanfootprint/view/checkout/mpesa.dart';
import 'package:urbanfootprint/theme/custom_app_theme.dart';
import 'package:urbanfootprint/view/intropages/login.dart';
import 'package:urbanfootprint/view/profile/help_page.dart';
import 'package:urbanfootprint/view/profile/notification.dart';
import 'package:urbanfootprint/view/profile/privacy_Policy.dart';
import '../../../../animation/fadeanimation.dart';


class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  _BodyProfileState createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      width: width,
      height: height,
      child: Column(
        children: [
          topProfilePicAndName(width, height),
          SizedBox(
            height: 40,
          ),
          middleDashboard(width, height),
          bottomSection(width, height),
        ],
      ),
    );
  }

  // Top Profile Photo And Name Components
  topProfilePicAndName(width, height) {
    return FadeAnimation(
      delay: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profilepic.jpg'),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hellen Nzisa",
                style: AppThemes.profileDevName,
              ),
              SizedBox(
                height:
                    5, // Adjust the spacing between the name and the additional text
              ),
              Text(
                "Full-stack Software Developer",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey, // Set the text color to grey
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  // Middle Dashboard ListTile Components
  middleDashboard(width, height) {
    return FadeAnimation(
      delay: 2,
      child: Container(
        width: width,
        height: height / 3,
        child: SingleChildScrollView( // Add SingleChildScrollView here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              dashboardOption(
                icon: Icons.security,
                label: "Privacy Policy",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => PrivacyPolicy(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              dashboardOption(
                icon: Icons.account_balance_wallet,
                label: "Wallet",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => Wallet(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              dashboardOption(
                icon: Icons.notifications,
                label: "Notifications",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => Notifications(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              dashboardOption(
                icon: Icons.question_answer,
                label: "Queries",
               onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HelpPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // My Account Section Components
  bottomSection(width, height) {
    return FadeAnimation(
      delay: 2.5,
      child: Container(
        width: width,
        height: height / 6.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(), // Spacer to push Log Out button to the bottom
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () {
                  showLogoutConfirmationDialog(context);
                },
                icon: Icon(Icons.logout),
                label: Text("Log Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Logout Confirmation Dialog
  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
