import 'dart:ui';

import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage>
    with TickerProviderStateMixin {
  bool _scrollUp = true;
  bool _visblityTitile = false;
  final horizontalImage = const ["image1", "image2", "image3", "image4"];
  late AnimationController _scaleController;
  late AnimationController _horizontalController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _screenScrollAnimation;
  late Animation<Offset> _screenScrollAnimation2;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _horizontalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _screenScrollAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.6)).animate(
          CurvedAnimation(
            parent: _horizontalController,
            curve: Curves.easeInOut,
          ),
        );
    _screenScrollAnimation2 =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -2.3)).animate(
          CurvedAnimation(
            parent: _horizontalController,
            curve: Curves.easeInOut,
          ),
        );

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _scrollUp = !_scrollUp;
        });
        _scaleController.reverse();
      }
    });
    _horizontalController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          _visblityTitile = !_visblityTitile;
        });
      } else if (status == AnimationStatus.dismissed) {
        // print("reverse");
        setState(() {
          _visblityTitile = !_visblityTitile;
        });
      }
    });
    _horizontalController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            height: height * 0.81,
            width: width,
            child: SlideTransition(
              position: _screenScrollAnimation,

              child: TweenAnimationBuilder(
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: _visblityTitile ? 4 : 0,
                  end: _visblityTitile ? 4 : 0,
                ),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                    child: Image.asset(
                      "assets/assign/topImage.jpeg",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 50,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_downward, size: 30),
                  ),
                  SizedBox(
                    height: 65,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _visblityTitile ? 1.0 : 0,
                      child: Column(
                        children: [
                          const Text(
                            "Eiffel Tower",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 18),
                              Text(
                                "Paris France",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_outlined, size: 30),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.65,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: !_visblityTitile ? 1.0 : 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 100,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "ON SALE",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const Text(
                      "Eiffel Tower",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 18),
                        Text("Paris France", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.76,
            child: SlideTransition(
              position: _screenScrollAnimation2,
              child: Container(
                height: 200,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(55),
                ),
                child: Column(
                  children: [
                    const Text(
                      "____________",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      AnimatedBuilder(
                                        animation: _horizontalController,
                                        builder: (context, child) {
                                          final offsetY =
                                              Tween<double>(
                                                    begin: -30.0,
                                                    end: 0.0,
                                                  ) // slide up by 30 pixels
                                                  .animate(
                                                    CurvedAnimation(
                                                      parent:
                                                          _horizontalController,
                                                      curve: Interval(
                                                        0.1 * i,
                                                        0.5 + 0.1 * i,
                                                        curve: Curves.easeOut,
                                                      ),
                                                    ),
                                                  )
                                                  .value;

                                          final scale =
                                              Tween<double>(
                                                    begin: 0.9,
                                                    end: 1.0,
                                                  )
                                                  .animate(
                                                    CurvedAnimation(
                                                      parent:
                                                          _horizontalController,
                                                      curve: Interval(
                                                        0.1 * i,
                                                        0.6 + 0.1 * i,
                                                        curve:
                                                            Curves.easeOutBack,
                                                      ),
                                                    ),
                                                  )
                                                  .value;

                                          return Transform.translate(
                                            offset: Offset(0, offsetY),
                                            child: Transform.scale(
                                              scale: scale,
                                              child: Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: SizedBox(
                                                  height: 110,
                                                  width: 110,
                                                  child: Image.asset(
                                                    "assets/assign/${horizontalImage[i]}.jpeg",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 90,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: !_visblityTitile ? 1.0 : 0,
                                child: Container(
                                  width: width,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withAlpha(100),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 190,
                              left: 10,
                              right: 10,
                              child: Column(
                                spacing: 10,
                                children: [
                                  const Text(
                                    """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.""",
                                    style: TextStyle(color: Colors.grey),
                                    softWrap: true,
                                    maxLines: null,
                                  ),
                                  const Text(
                                    "READ MORE",
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SizedBox(
                                      height: 200,
                                      width: width,
                                      child: Image.asset(
                                        "assets/assign/${horizontalImage[2]}.jpeg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: GestureDetector(
            onTap: () {
              if (_scaleController.isAnimating) return;
              _scaleController.forward();
              if (!_scrollUp) {
                _horizontalController.forward();
              } else {
                _horizontalController.reverse();
              }
            },
            child: !_scrollUp
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff343a5c),

                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset("assets/assign/flight.png", scale: 3),
                  )
                : Container(
                    height: 50,

                    decoration: BoxDecoration(
                      color: Color(0xff343a5c),

                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Image.asset("assets/assign/flight.png", scale: 3),
                          const SizedBox(width: 10),
                          const Text(
                            "SEARCH FLIGHTS",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 100,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "ON SALE",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
