import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';

class MarsDetailsPage extends StatelessWidget {
  const MarsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackGroundColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar ile üstteki resmi ekliyoruz
          SliverAppBar(
            backgroundColor: AppColors.appBackGroundColor,
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Arka plan resmi
                  Positioned.fill(
                    child: SvgPicture.asset(
                      AppImages.marsSvg,
                    ),
                    left: 20,
                  ),
                  // Üstteki ikonlar ve yıldızlar
                  Positioned(
                    top: 10,
                    left: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black45,
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                  // Diğer yıldızlar
                  Positioned(
                    top: 100,
                    left: 20,
                    child: SvgPicture.asset(AppImages.fadedStarSvg),
                  ),
                  Positioned(
                    top: 100,
                    right: 20,
                    child: SvgPicture.asset(AppImages.fadedStarSvg),
                  ),
                  Positioned(
                    top: 120,
                    right: 60,
                    child: SvgPicture.asset(AppImages.fadedStarSvg),
                  ),
                  Positioned(
                    top: 200,
                    left: 10,
                    child: SvgPicture.asset(AppImages.fadedStarSvg),
                  ),
                ],
              ),
            ),
          ),
          // İçerik kısmını SliverList veya SliverToBoxAdapter ile ekliyoruz
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık ve favori ikonu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Başlık
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Mars",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Planet",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      // Favori ikonu
                    ],
                  ),
                  const SizedBox(height: 20),
                  // İçerik metni
                  Text(
                    '''
Features:

    Habitable?: Currently, Mars is not habitable for human life due to its thin atmosphere and lack of oxygen. However, there is potential for future colonization. Scientists are actively exploring ways to create a habitable environment on Mars.
    Water?: Mars contains water in the form of ice, particularly at its polar ice caps. Traces of liquid water have been found in the form of seasonal streaks, and there is evidence suggesting that Mars once had flowing rivers and lakes.
    Atmosphere: Mars’ atmosphere is composed mainly of carbon dioxide (95%), with small amounts of nitrogen (3%) and argon (1.6%). The thin atmosphere is unable to provide much warmth, resulting in low temperatures and little protection against cosmic radiation.
    Surface Gravity: 3.71 m/s², which is about 38% of Earth's gravity. This reduced gravity would have significant effects on human physiology if a permanent colony were to be established.
    Geological Features: Mars is home to Olympus Mons, the largest volcano in the Solar System, and Valles Marineris, a canyon system that dwarfs the Grand Canyon.
    Moons: Mars has two small moons, Phobos and Deimos, which are thought to be captured asteroids.

Description:

Mars, often referred to as the "Red Planet" due to its reddish appearance, is the fourth planet from the Sun and has long fascinated humanity. Its iron oxide-rich surface gives Mars its characteristic color, which makes it stand out in the night sky. Mars has a landscape marked by enormous volcanoes, deep canyons, and dry riverbeds, all hinting at a more dynamic past that may have supported liquid water and potentially life.

Mars has long been a target for exploration, and multiple rovers have explored its surface, including NASA's Curiosity and Perseverance rovers. These missions have found evidence that Mars may once have had conditions suitable for microbial life, including signs of ancient river deltas and the presence of clay minerals. These discoveries have raised exciting possibilities about whether life could have existed on Mars billions of years ago.

The thin atmosphere of Mars, composed mainly of carbon dioxide, provides little insulation, making surface temperatures swing dramatically from day to night. The atmospheric pressure is less than 1% of Earth's, which, combined with its low gravity, means Mars lacks significant protection from cosmic and solar radiation. However, the discovery of underground water ice and the planet’s similar day length to Earth (about 24.6 hours) make it a promising candidate for future colonization. Human missions to Mars aim to establish a permanent base on its surface, which could serve as a stepping stone for deeper space exploration.


''',
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        wordSpacing: 1,
                        letterSpacing: 0.2,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  // Yazar bilgisi
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
