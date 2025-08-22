import 'package:flutter/material.dart';
import 'package:icg_navy/utility/app_images.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
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
          // Background Image at bottom
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
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
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              _slides[_currentPage]["image"]!,
              fit: BoxFit.fitWidth,
            ),
          ),
          // PageView for slides

          // Navigation indicators
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          // Skip and Next buttons
          Positioned(
            bottom: 20,
            left: 20,
            child: TextButton(
              onPressed: () {
                // Handle skip
              },
              child: Text("Skip"),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                if (_currentPage < _slides.length - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  // Handle completion
                }
              },
              child: Text(_currentPage == _slides.length - 1 ? "Done" : "Next"),
            ),
          ),
        ],
      ),
    );
  }
}
