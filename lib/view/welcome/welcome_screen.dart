import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icg_navy/utility/app_images.dart';
import 'package:icg_navy/utility/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      "title": "Welcome",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
      "image": AppImages.welcome1,
    },
    {
      "title": "Welcome",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
      "image": AppImages.welcome2,
    },
    {
      "title": "Welcome",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
      "image": AppImages.welcome3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Carousel Slider for slides
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _slides.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.15,
                  vertical: screenHeight * 0.2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _slides[index]["title"]!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      _slides[index]["description"]!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: screenHeight,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          // Background Image at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              _slides[_currentPage]["image"]!,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Bottom row with Skip, Indicators, and Next/Done buttons
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    child: Text(
                      "Skip",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Slide indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slides.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _carouselController.animateToPage(index);
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 20, // Wider for oval shape
                        height: 8, // Shorter for oval shape
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(
                              4,
                            ), // Makes it oval
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                            // border: Border.all(
                            //   color: _currentPage == index
                            //       ? Colors.white
                            //       : Colors.grey,
                            //   width: 1,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Next/Done button
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {
                      if (_currentPage < _slides.length - 1) {
                        _carouselController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Get.toNamed(AppRoutes.login);
                      }
                    },
                    child: Text(
                      _currentPage == _slides.length - 1 ? "Done" : "Next",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
