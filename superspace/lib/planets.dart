// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:superspace/DetailsPage/earthDetails.dart';
import 'package:superspace/DetailsPage/jupiterDetails.dart';
import 'package:superspace/DetailsPage/marsDetails.dart';
import 'package:superspace/DetailsPage/neptuneDetails.dart';
import 'package:superspace/DetailsPage/saturnDetails.dart';
import 'package:superspace/DetailsPage/uranusDetails.dart';
import 'package:superspace/DetailsPage/venusDetails.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';

final List categories = [
  'All',
  'Planets',
  'Stars',
  'Galaxies',
  'Nebulas',
];

class PlanetsPage extends StatefulWidget {
  const PlanetsPage({super.key});

  @override
  State<PlanetsPage> createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int selectedIndex = 0;
    return Scaffold(
      backgroundColor: AppColors.appBackGroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 130),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: -80,
                    left: 10,
                    child: SvgPicture.asset(
                      AppImages.starsSvg,
                    )),
                Positioned(
                  top: -70,
                  left: 200,
                  child: SvgPicture.asset(
                    AppImages.starsSvg,
                  ),
                ),
                Positioned(
                  bottom: -20,
                  child: SvgPicture.asset(
                    AppImages.starsSvg,
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: 100,
                  child: SvgPicture.asset(
                    AppImages.starsSvg,
                  ),
                ),
                Positioned(
                  top: 50,
                  child: SvgPicture.asset(
                    AppImages.starsSvg,
                  ),
                ),
                const SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Planets(
                        planet: AppImages.earthSvg,
                        title: 'Earth',
                        description:
                            'Earth is the third planet from\n the sun and the only known \nplanet to support life. it has a\n diameter of 12,742 km.',
                        color: AppColors.motherEarthColor,
                        height: 170,
                        top: -100,
                        left: -10,
                        Color2: Colors.blue,
                      ),
                      SizedBox(width: 40),
                      Planets(
                        planet: AppImages.venusSvg,
                        title: "Venus",
                        description:
                            'Venus is the Second Planet\n from the sun and is often\n referred to as the Earths\'s \n sister planet.',
                        color: AppColors.marsColor,
                        height: 250,
                        top: -130,
                        left: -45,
                        Color2: Colors.orange,
                      ),
                      SizedBox(width: 40),
                      Planets(
                          planet: AppImages.saturnSvg,
                          title: "Saturn",
                          description:
                              'Saturn is the sixth planet\n from the sun and is known\n for its prominent ring system,\n composed of ice and rock.',
                          color: Color.fromRGBO(183, 221, 131, 1),
                          height: 250,
                          top: -130,
                          left: -45,
                          Color2: Color.fromRGBO(106, 132, 70, 1)),
                      SizedBox(width: 40),
                      Planets(
                          planet: AppImages.uranusSvg,
                          title: "Uranus",
                          description:
                              'Uranus is the seventh planet\n from the sun and is known for\n its unique tilt, rotating almost\n completely on its side.',
                          color: Color.fromRGBO(175, 146, 250, 1),
                          height: 200,
                          top: -130,
                          left: 5,
                          Color2: Color.fromRGBO(116, 84, 196, 1)),
                      SizedBox(width: 40),
                      Planets(
                        planet: AppImages.marsSvg,
                        title: "Mars",
                        description:
                            'Mars is the fourth planet\n from the sun and is often\n called the "Red Planet"\n due to its reddish appearance.',
                        color: Color.fromRGBO(255, 132, 95, 1),
                        height: 150,
                        top: -100,
                        left: 5,
                        Color2: Color.fromRGBO(255, 107, 61, 1),
                      ),
                      SizedBox(width: 40),
                      Planets(
                        planet: AppImages.jupiterSvg,
                        title: "Jupiter",
                        description:
                            'Jupiter is the fifth planet\n from the sun and is the largest\n in the Solar System, known for\n its Great Red Spot, a massive storm.',
                        color: Color.fromRGBO(222, 200, 175, 1),
                        height: 150,
                        top: -100,
                        left: 5,
                        Color2: Color.fromRGBO(189, 169, 145, 1),
                      ),
                      SizedBox(width: 40),
                      Planets(
                        planet: AppImages.neptuneSvg,
                        title: "Neptune",
                        description:
                            'Neptune is the eighth planet\n from the sun and is known for\n its deep blue color and intense\n winds, the strongest in the Solar System.',
                        color: Color.fromRGBO(133, 184, 251, 1),
                        height: 150,
                        top: -100,
                        left: 5,
                        Color2: Color.fromRGBO(79, 150, 243, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Articles",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: size.height * 0.23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade900,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 400,
                      width: 125,
                      decoration: const BoxDecoration(
                          color: AppColors.uranusColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 25),
                            SvgPicture.asset(
                              AppImages.uranusSvg,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Positioned(
                          top: -40,
                          child: Text("Ice giant -Uranus",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Positioned(
                          child: Text(
                              "Uranus is a fascinating planet that is \n often overlooked due to its distance \n from Earth and lack of visible features.",
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 12,
                              )),
                        ),
                        Positioned(
                          bottom: -90,
                          right: 10,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                              color: Colors.deepPurple,
                            ),
                            child: const Icon(Icons.arrow_forward,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Planets extends StatelessWidget {
  const Planets({
    super.key,
    required this.planet,
    required this.title,
    required this.description,
    required this.color,
    required this.height,
    required this.top,
    required this.left,
    required this.Color2,
  });

  final String planet;
  final String title;
  final String description;
  final Color color;
  final double height;
  final double top;
  final double left;
  final Color Color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          gradient: LinearGradient(colors: [
            color,
            color.withOpacity(0.8),
          ])),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: top,
            left: left,
            child: SvgPicture.asset(
              planet,
              height: height,
            ).animate().rotate(
                  duration: const Duration(minutes: 1),
                ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                    height: 10), // Başlık ve açıklama arasına boşluk ekliyoruz
                Text(
                  description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -20,
            left: 70,
            child: GestureDetector(
              onTap: () {
                // Gezegene göre yönlendirme yapıyoruz
                if (title == "Earth") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EarthDetailsPage()),
                  );
                } else if (title == "Venus") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VenusDetailsPage()),
                  );
                } else if (title == "Saturn") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SaturnDetailsPage()),
                  );
                } else if (title == "Uranus") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UranusDetailsPage()),
                  );
                } else if (title == "Mars") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MarsDetailsPage()),
                  );
                } else if (title == "Jupiter") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JupiterDetailsPage()),
                  );
                }
                else if (title == "Neptune") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NeptuneDetailsPage()),
                  );
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color2,
                        offset: const Offset(0, 7),
                        blurRadius: 10,
                        spreadRadius: 0.1,
                        blurStyle: BlurStyle.normal),
                  ],
                  shape: BoxShape.circle,
                  color: Color2,
                  border: Border.all(color: Colors.white),
                ),
                child: const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
