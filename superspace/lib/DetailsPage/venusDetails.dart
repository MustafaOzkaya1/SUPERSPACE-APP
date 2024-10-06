import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';

class VenusDetailsPage extends StatelessWidget {
  const VenusDetailsPage({super.key});

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
                      AppImages.venusSvg,
                      fit: BoxFit.cover,
                      
                    ),
                    right: 70,
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
                            "Venus",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Planet",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
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
Habitable?:
Venus is not habitable for human life due to its extreme temperatures, high atmospheric pressure, and clouds of sulfuric acid. However, scientists have speculated that microbial life could potentially exist in the upper atmosphere, where conditions are less hostile compared to the planet's surface.

Water?:
Currently, Venus does not have liquid water. Its extreme surface temperatures, which can reach up to 465°C (869°F), make it impossible for water to exist in liquid form. However, there is some evidence suggesting that Venus may have had oceans in its distant past.

Atmosphere:
Venus has a dense atmosphere composed primarily of carbon dioxide (96.5%) and nitrogen (3.5%), with thick clouds of sulfuric acid. This atmosphere creates an intense greenhouse effect, trapping heat and leading to Venus being the hottest planet in the Solar System. The atmospheric pressure on Venus is about 92 times that of Earth, making the surface conditions incredibly harsh.

Surface Gravity:
The surface gravity on Venus is 8.87 m/s², which is about 90% of Earth's gravity, meaning objects on Venus would weigh slightly less than they do on Earth.

Geological Features:
Venus has a rocky surface with vast plains, volcanic features, and highland regions. One of the most significant volcanic features is Maxwell Montes, the highest mountain on Venus. The planet also has thousands of large volcanoes, though whether any of them are still active is a subject of ongoing research.

Orbital Characteristics:
Venus orbits the Sun at an average distance of about 108.2 million kilometers. It has a very slow rotation, taking about 243 Earth days to complete one rotation, and rotates in the opposite direction to most planets, meaning the Sun rises in the west and sets in the east on Venus.

Magnetic Field:
Venus lacks a significant magnetic field, which leaves its atmosphere vulnerable to the solar wind, contributing to the loss of lighter molecules like water vapor over billions of years.

Description:
Venus, often called Earth's "sister planet" due to its similar size and composition, is the second planet from the Sun. However, despite these similarities, the conditions on Venus are vastly different from Earth’s. With surface temperatures hot enough to melt lead, Venus is the hottest planet in the Solar System, thanks to its runaway greenhouse effect. Its thick atmosphere, primarily composed of carbon dioxide, traps heat and leads to a pressure at the surface that is over 90 times that of Earth's.

The planet’s surface is largely obscured by dense clouds of sulfuric acid, making it difficult to observe directly. Radar imaging, primarily from NASA’s Magellan mission, has revealed a landscape marked by vast volcanic plains, large mountains, and features that suggest past volcanic activity.

Despite its harsh surface, the upper atmosphere of Venus presents conditions that are milder, leading scientists to speculate about the possibility of life existing in the form of microorganisms that could potentially survive in the clouds. These speculations were fueled by the detection of phosphine, a gas that on Earth is typically associated with biological processes, although the existence of this gas on Venus remains controversial.

Venus’s slow retrograde rotation is another unique feature—it takes longer for Venus to rotate on its axis than to complete an orbit around the Sun, meaning a day on Venus is longer than a year. Additionally, due to its retrograde rotation, the Sun rises in the west and sets in the east.

Exploration of Venus has been limited due to the extreme surface conditions, but future missions, both from NASA and other space agencies, are planned to study Venus’s atmosphere, geology, and history, to better understand why it evolved so differently from Earth.
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
