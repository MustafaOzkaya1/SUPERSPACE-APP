import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';

class NeptuneDetailsPage extends StatelessWidget {
  const NeptuneDetailsPage({super.key});

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
                      AppImages.neptuneSvg, 
                    ),
                    left: 50,

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
                            "Neptune",
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

    Habitable?: Neptune is not habitable for human life. It is a gas giant with no solid surface, and its extreme temperatures and strong winds make it unsuitable for life as we know it.
    Water?: There is no evidence of liquid water on Neptune's surface. However, it is thought that deep within its atmosphere, there may be supercritical water due to extreme pressure conditions.
    Atmosphere: Neptune's atmosphere is composed mostly of hydrogen (80%), helium (19%), and traces of methane, which gives the planet its deep blue color. The presence of methane absorbs red light and scatters blue light, making Neptune one of the most visually stunning planets.
    Surface Gravity: 11.15 m/s², slightly stronger than Earth's gravity, but because Neptune is a gas giant, there is no solid surface to walk on.
    Winds: Neptune is home to the strongest winds in the Solar System, with speeds reaching up to 2,100 kilometers per hour (1,300 mph). These winds generate colossal storm systems, including the Great Dark Spot, similar to Jupiter's Great Red Spot.
    Moons: Neptune has 14 known moons, with Triton being the largest and most notable. Triton is unique in that it has a retrograde orbit, meaning it orbits Neptune in the opposite direction to the planet's rotation, which suggests it may have been a captured object.

Description:

Neptune, the eighth and most distant planet from the Sun in our Solar System, is known for its striking deep blue color and dynamic atmosphere. Named after the Roman god of the sea, Neptune is a gas giant characterized by extreme winds and intense storm systems. Its blue hue is the result of methane in its atmosphere, which scatters sunlight and absorbs the red wavelengths, creating a vivid blue appearance that has fascinated astronomers for generations.

Neptune's atmosphere is composed primarily of hydrogen and helium, with traces of methane. This combination of gases results in the most turbulent weather conditions in the Solar System. Wind speeds on Neptune are the fastest recorded in the Solar System, reaching over 2,000 kilometers per hour. The Great Dark Spot, first observed by Voyager 2 in 1989, was an enormous storm system similar to Jupiter's Great Red Spot, highlighting Neptune's incredibly active atmosphere.

One of the most intriguing features of Neptune is its moon Triton, which is the only large moon in the Solar System with a retrograde orbit. Triton is thought to be a captured Kuiper Belt object, and it is geologically active, with cryovolcanoes that erupt with water ice and other materials. The presence of geysers on Triton suggests that this moon could have subsurface reservoirs of liquid, making it an object of interest for studying the possibility of life beyond Earth.

Voyager 2 remains the only spacecraft to have visited Neptune, providing invaluable data about the planet's rings, moons, and overall atmospheric conditions. Neptune's rings are faint and composed mainly of dust particles, but they add a significant visual feature to this distant giant. The exploration of Neptune and its unique features continues to be a priority for scientists, as the icy giant holds many secrets about the formation of our Solar System and the conditions of the outer planetary region.


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
