import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';

class EarthDetailsPage extends StatelessWidget {
  const EarthDetailsPage({super.key});

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
                      AppImages.earthSvg,
                      fit: BoxFit.cover,
                    ),
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
                            "Earth",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Our Home Planet",
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
                    '''Features:

    Habitable?: Yes, Earth is the only known planet to support life. It has a stable atmosphere, liquid water, and a suitable temperature range that allows various forms of life to thrive.
    Water?: Earth is known as the "Blue Planet" because approximately 71% of its surface is covered by water in the form of oceans, rivers, and lakes. It has abundant liquid water, which is one of the key elements that makes life possible.
    Atmosphere: The atmosphere of Earth is composed primarily of nitrogen (78%) and oxygen (21%), with trace amounts of carbon dioxide, argon, and other gases. This atmosphere provides essential support for life by regulating temperature and providing breathable air.
    Surface Gravity: 9.81 m/s², which is what allows humans, plants, and animals to move comfortably.
    Orbital Characteristics: Earth orbits the Sun at a distance of about 149.6 million kilometers, which falls within the Sun’s habitable zone—a distance range where conditions are just right for liquid water to exist.
    Magnetic Field: Earth’s magnetic field is crucial for deflecting harmful solar and cosmic radiation, making it a more habitable environment for organisms.

Description:

Earth is the third planet from the Sun and the only astronomical body known to harbor life. Its diverse environment supports a wide variety of ecosystems, ranging from lush rainforests and vast oceans to arid deserts and icy polar regions. Earth’s atmosphere acts as a shield, protecting life from harmful solar radiation and moderating temperatures, ensuring the planet does not get too hot or cold.

Earth is unique because it contains all the essential components required for life—liquid water, an atmosphere rich in oxygen, moderate temperatures, and a magnetic field that protects the planet from harmful space radiation. The presence of plate tectonics also contributes to Earth’s dynamic surface, recycling carbon and creating diverse landscapes.

The complex biosphere of Earth includes millions of species that have adapted to live in different conditions across the planet. Earth’s water cycle plays a significant role in distributing heat and nutrients throughout the planet, and its atmosphere contains just the right mix of gases to maintain conditions favorable for life. These characteristics, combined with Earth’s optimal position in the Solar System, make it the ideal environment for sustaining a vast diversity of life.
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
