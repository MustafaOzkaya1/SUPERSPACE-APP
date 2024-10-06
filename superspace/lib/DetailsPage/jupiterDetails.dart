import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';

class JupiterDetailsPage extends StatelessWidget {
  const JupiterDetailsPage({super.key});

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
                      AppImages.jupiterSvg, 
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
                            "Uranus",
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

    Habitable?: Uranus is not habitable for human life. It is an ice giant, meaning it does not have a solid surface, and its atmosphere is composed of hydrogen, helium, and methane, which are not conducive to supporting life as we know it.
    Water?: Uranus does not have liquid water on its surface, but it is believed that water exists deep within its atmosphere, where high pressures could create supercritical conditions.
    Atmosphere: Uranus' atmosphere is primarily composed of hydrogen (82.5%), helium (15%), and methane (2.5%). Methane gives Uranus its pale blue color, as it absorbs red light and reflects blue light.
    Surface Gravity: 8.69 m/s², slightly weaker than Earth’s gravity, which would make movement easier if there were a surface to stand on.
    Axial Tilt: Uranus has an axial tilt of 98 degrees, meaning it essentially rolls on its side as it orbits the Sun. This unique tilt results in extreme seasonal variations, with each pole experiencing 42 years of continuous sunlight or darkness.
    Moons and Rings: Uranus has 27 known moons, with Titania and Oberon being the largest. It also has faint rings, which are much darker and less distinct compared to Saturn’s famous rings.

Description:

Uranus, the seventh planet from the Sun, is often overlooked in comparison to its more prominent neighbors, but it holds many fascinating features that make it unique in our Solar System. Uranus is classified as an ice giant due to the composition of its interior, which contains water, ammonia, and methane ices. Unlike the larger gas giants, Jupiter and Saturn, Uranus lacks a metallic hydrogen layer, giving it a distinct internal structure.

One of the most striking features of Uranus is its extreme axial tilt of 98 degrees, which means the planet essentially rotates on its side. This unusual orientation is believed to have been caused by a massive collision with an Earth-sized object early in its history. As a result, Uranus experiences extreme seasonal changes, with each hemisphere being exposed to either continuous sunlight or darkness for nearly half of its 84-year orbit around the Sun. This axial tilt also gives rise to the unique appearance of its rings and magnetic field, which are significantly misaligned with its rotation.

Uranus is composed primarily of hydrogen and helium, with a notable proportion of methane, which gives the planet its pale blue color. Unlike Neptune’s vivid blue, Uranus has a more muted tone, which is thought to be due to the presence of haze in its upper atmosphere. Winds on Uranus can reach speeds of up to 900 kilometers per hour, and although its atmosphere appears calm, there is significant activity below the cloud tops.

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
