import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';

import '../../../utility/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Notification',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: AppColors.defaultblack,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(
            color: const Color(0xFFDADADA),
            // thickness: 2,
            height: 0,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (BuildContext context, int inde) {
          return Column(
            children: [
              ListTile(
                // horizontalTitleGap: 1,
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.notifications,
                      size: 25,
                      color: AppColors.background,
                    ),
                  ),
                ),
                title: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.defaultblack,
                  ),
                  overflow: TextOverflow.ellipsis, // or TextOverflow.clip
                  maxLines: 2, // Allow up to 2 lines for the text
                ),
                trailing: Text(
                  "2hrs ago",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                  ),
                  overflow: TextOverflow.ellipsis, // or TextOverflow.clip
                  maxLines: 2, // Allow up to 2 lines for the text
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
