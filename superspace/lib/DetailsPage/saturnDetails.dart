import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superspace/core/constants/app_svgs/app_svgs.dart';
import 'package:superspace/core/constants/app_colors/app_colors.dart';

class SaturnDetailsPage extends StatelessWidget {
  const SaturnDetailsPage({super.key});

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
                      AppImages.saturnSvg,
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
                            "Saturn",
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
Saturn is not habitable for human life as it is a gas giant without a solid surface. Its extreme atmospheric conditions, including high winds and low temperatures, make it inhospitable. However, some of its moons, such as Titan and Enceladus, are considered potential candidates for hosting life due to the presence of water in different forms.

Water?:
Saturn itself does not contain liquid water. However, its moon Enceladus has a subsurface ocean beneath an icy crust, and water geysers have been observed ejecting material into space. Another moon, Titan, has lakes of liquid methane and ethane, although no liquid water has been detected on Titan's surface.

Atmosphere:
Saturn’s atmosphere is composed primarily of hydrogen (96%) and helium (3%), with trace amounts of methane, ammonia, and other gases. The planet is known for its rapid winds, which can reach speeds of up to 1,800 kilometers per hour (1,118 mph), giving Saturn its distinctive banded appearance.

Surface Gravity:
Saturn’s surface gravity is 10.44 m/s², similar to Earth’s gravity. Despite this, the lack of a solid surface and the gaseous nature of the planet make it uninhabitable for any known life forms.

Rings:
Saturn is perhaps best known for its extensive and complex ring system, which is composed of countless ice and rock particles ranging in size from tiny dust grains to large boulders. These rings are a defining feature of Saturn and are visible even with small telescopes.

Moons:
Saturn has at least 83 moons, with Titan being the largest. Titan is unique in the Solar System for having a thick atmosphere and surface lakes of liquid methane. Enceladus, with its water-ice geysers, is another moon of significant interest, particularly for astrobiological research.

Magnetic Field:
Saturn has a strong magnetic field, though not as strong as Jupiter’s. It creates auroras around the poles and interacts with its ring system and moons, contributing to Saturn’s dynamic and complex environment.

Description:
Saturn, the sixth planet from the Sun and the second-largest in the Solar System, is a gas giant famous for its magnificent ring system. Although it shares similarities with Jupiter in terms of composition—both being composed primarily of hydrogen and helium—Saturn is less dense and has a more subdued coloration. The planet's atmosphere, dominated by fast-moving winds, creates a striking pattern of bands that run parallel to its equator.

Saturn’s ring system is the most extensive in the Solar System, stretching hundreds of thousands of kilometers from the planet but only a few meters thick. These rings are made up of countless small particles of ice and rock, each orbiting Saturn independently. The origin and age of the rings remain subjects of scientific inquiry, but they are thought to have formed from the remnants of a shattered moon or comet.

Saturn’s many moons are also of great interest, particularly Titan and Enceladus. Titan, Saturn’s largest moon, has a thick atmosphere and liquid hydrocarbon lakes on its surface, making it one of the most Earth-like bodies in the Solar System, though its surface temperatures are far too cold for liquid water to exist. Enceladus, on the other hand, has become a prime candidate for the search for extraterrestrial life, thanks to its subsurface ocean and the discovery of organic molecules in the water plumes that erupt from its surface.

Despite Saturn's inhospitable environment, the exploration of the planet and its moons has yielded significant insights into the nature of gas giants and the potential habitability of other worlds. NASA's Cassini mission, which orbited Saturn for over 13 years, provided an unprecedented wealth of data on the planet, its rings, and its moons, revolutionizing our understanding of the outer Solar System.

With its stunning rings and diverse collection of moons, Saturn continues to be a focal point for planetary science, offering insights not only into its own complex systems but also into the broader processes that govern the formation and evolution of planets and their satellites.
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
