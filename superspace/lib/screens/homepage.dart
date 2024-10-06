import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superspace/chat_screen.dart';
import 'package:superspace/classes/colors.dart';
import 'package:superspace/planets.dart';
import 'package:superspace/screens/discussion_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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

void main() => runApp(SpaceApp());

class SpaceApp extends StatefulWidget {
  @override
  _SpaceAppState createState() => _SpaceAppState();
}

class _SpaceAppState extends State<SpaceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpaceHome(),
    );
  }
}

class SpaceHome extends StatefulWidget {
  @override
  _SpaceHomeState createState() => _SpaceHomeState();
}

class _SpaceHomeState extends State<SpaceHome> {
  int _currentIndex = 2; // Başlangıçta anasayfa (ortadaki simge)
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  final List<Widget> _pages = [
    DiscussionPage(),
    VideosPage(),
    HomeWithCarousel(),  // Updated Home Page with Carousel
    NewsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SUPERSPACE',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Image.asset(
            'images/yeni1.png',
            height: 50,
            width: 50,
          ), // Sol logo
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/nasalogo2.png'), // Sağ logo
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Köşeleri yuvarlak yap
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
          },
          child: Image.asset('images/s.gif', fit: BoxFit.cover), // Üzerinde gösterilecek resim
          backgroundColor: Colors.transparent, // Arka plan rengini transparan yap
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: CircleNavBar(
          activeIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          circleColor: Colors.deepPurpleAccent, // Ortadaki butonun rengi
          activeIcons: const [
            Icon(Icons.comment_rounded, color: Colors.white),  // Sol uç simge
            Icon(Icons.video_library, color: Colors.white), // Sol orta simge for Videos
            Icon(Icons.home, color: Colors.white),    // Ortadaki simge (Ana Sayfa)
            Icon(Icons.newspaper, color: Colors.white),  // Sağ orta simge (News simgesi)
            Icon(Icons.settings, color: Colors.white) // Sağ uç simge
          ],
          inactiveIcons: const [
            Text("Discussion", style: TextStyle(color: Colors.white)),
            Text("Videos", style: TextStyle(color: Colors.white)), // "Videos" Text
            Text("Home", style: TextStyle(color: Colors.white)),
            Text("News", style: TextStyle(color: Colors.white)),   // News Text
            Text("Settings", style: TextStyle(color: Colors.white)),
          ],
          color: Colors.black87, // Alt gezinme çubuğunun arka plan rengi
          height: 60,
          circleWidth: 60,  // Ortadaki simgenin büyüklüğü
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          shadowColor: Colors.deepPurpleAccent.withOpacity(0), // Gölge rengi
          elevation: 10, // Gölgeli bir görünüm için
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

class HomeWithCarousel extends StatefulWidget {
  @override
  _HomeWithCarouselState createState() => _HomeWithCarouselState();
}

class _HomeWithCarouselState extends State<HomeWithCarousel> {
  @override
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Jupiter', 'Saturn', 'Earth'],
      'correctAnswer': 'Mars',
    },
    {
      'question': 'How many moons does Mars have?',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': '2',
    },
    {
      'question': 'What is the hottest planet in the solar system?',
      'options': ['Venus', 'Mercury', 'Mars', 'Jupiter'],
      'correctAnswer': 'Venus',
    },
    {
      'question': 'Which planet is closest to the Sun?',
      'options': ['Mercury', 'Venus', 'Earth', 'Mars'],
      'correctAnswer': 'Mercury',
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'options': ['Earth', 'Saturn', 'Jupiter', 'Neptune'],
      'correctAnswer': 'Jupiter',
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _selectedOption;

  void _checkAnswer() {
    if (_selectedOption == _questions[_currentQuestionIndex]['correctAnswer']) {
      _score++;
    }

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOption = null;
      } else {
        _showResult();
      }
    });
  }
  final List categories = [
    'All',
    'Planets',
    'Stars',
    'Galaxies',
    'Nebulas',
  ];

  void _showResult() {
    String resultMessage;
    String imagePath;
    double percentage = (_score / _questions.length) * 100;

    // Determine the result message and image based on the percentage score
    if (percentage >= 80) {
      resultMessage =
      'With this success, space awaits you, Earthling! You scored $percentage%.';
      imagePath = 'images/astro3.png'; // Image for 80% and above
    } else if (percentage >= 60) {
      resultMessage =
      'You have completed today\'s quiz with $percentage% success. You can proceed, space awaits you.';
      imagePath = 'images/astro1.png'; // Image for 60% to 80%
    } else {
      resultMessage =
      'You can improve by watching the training videos in our video section to become better. You scored $percentage%.';
      imagePath = 'images/astro2.png'; // Image for below 60%
    }

    // Show the result dialog with the appropriate message and image
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Quiz Result:',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 100, width: 100), // Display the result image
            SizedBox(height: 20),
            Text(resultMessage,style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                _selectedOption = null;
              });
            },
            child: Text('OK',style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),),
          ),
        ],
      ),
    );
  }


  String _getVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }


  @override
  Widget build(BuildContext context)  {
    final size = MediaQuery.of(context).size;


    void _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);  // Open the YouTube URL
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              'YOUR DAILY TEST:',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),

            // Quiz Section
            Card(
              margin: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('images/yildizli.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _questions[_currentQuestionIndex]['question'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ..._questions[_currentQuestionIndex]['options']
                              .map<Widget>((option) {
                            return ListTile(
                              title: Text(
                                option,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              leading: Radio<String>(
                                value: option,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _selectedOption == null ? null : _checkAnswer,
                            child: const Text(
                              'Submit Answer',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 5.0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'EXPLORE THE PLANETS:',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),

            // Planet Exploration Section (integrated from the second build function)
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
                  ),
                ),
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
                        description: 'Earth is the third planet from the sun and the only known planet to support life. it has a diameter of 12,742 km.',
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
                        description: 'Venus is the Second Planet from the sun and is often referred to as the Earths\'s sister planet.',
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
                        description: 'Saturn is the sixth planet from the sun and is known for its prominent ring system.',
                        color: Color.fromRGBO(183, 221, 131, 1),
                        height: 250,
                        top: -130,
                        left: -45,
                        Color2: Color.fromRGBO(106, 132, 70, 1),
                      ),
                      SizedBox(width: 40),
                      Planets(
                        planet: AppImages.uranusSvg,
                        title: "Uranus",
                        description: 'Uranus is the seventh planet from the sun and is known for its unique tilt, rotating almost completely on its side.',
                        color: Color.fromRGBO(175, 146, 250, 1),
                        height: 200,
                        top: -130,
                        left: 5,
                        Color2: Color.fromRGBO(116, 84, 196, 1),
                      ),
                      SizedBox(width: 40),
                      Planets(
                        planet: AppImages.marsSvg,
                        title: "Mars",
                        description: 'Mars is the fourth planet from the sun and is often called the "Red Planet" due to its reddish appearance.',
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
                        description: 'Jupiter is the fifth planet from the sun and is the largest in the Solar System.',
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
                        description: 'Neptune is the eighth planet from the sun and is known for its deep blue color and intense winds.',
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

            // Rest of your sections like News and Videos
            const Text(
              'RECOMMENDED NEWS:',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Carousel for News
            CarouselSlider.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                          imgUrl: newsList[index]['imgUrl']!,
                          title: newsList[index]['title']!,
                          description: newsList[index]['description']!,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            newsList[index]['imgUrl']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            newsList[index]['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                initialPage: 0,
                viewportFraction: 0.8,
              ),
            ),
            const SizedBox(height: 20),

            // Videos section
            const Text(
              'RECOMMENDED VIDEOS:',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Carousel for Videos
            SingleChildScrollView(
              child: CarouselSlider.builder(
                itemCount: videoData.length,
                itemBuilder: (context, index, realIdx) {
                  String title = videoData.keys.elementAt(index);
                  String videoUrl = videoData.values.elementAt(index);

                  // YouTube URL thumbnail generator
                  String thumbnailUrl =
                      'https://img.youtube.com/vi/${Uri.parse(videoUrl).pathSegments.last}/0.jpg';

                  return GestureDetector(
                    onTap: () {
                      _launchURL(videoUrl); // Open the YouTube URL
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 13,
                          child: Image.network(
                            thumbnailUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  viewportFraction: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  final List<Map<String, String>> newsList = [
    {
      'imgUrl': 'https://cdn.esahubble.org/archives/images/newsfeature/heic1817a.jpg',
      'title': 'ESA Invites European Community to Participate in NASA\'s GOMAP',
      'description': '''A special Announcement of Opportunity (AO) is soliciting the participation of the European community in the role of ESA-appointed representatives to the NASA Great Observatory Maturation Program’s (GOMAP) Science, Technology, Architecture Review Team (START) for the Habitable Worlds Observatory (HWO) mission.

The 2020 National Academy of Sciences Decadal Survey on Astronomy and Astrophysics (Astro2020) recommended a "Great Observatories Mission and Technology Maturation Program" as its highest priority in Enabling Programs for Space. Astro2020 further recommended that the first mission to enter the maturation program be an infrared-optical-ultraviolet (IR/Optical/UV) space telescope. In response to these recommendations, NASA has established the Great Observatory Maturation Program (GOMAP). Consistent with the guidance from Astro2020, the first entrant into GOMAP will be the Habitable Worlds Observatory (HWO), a space-based IR/Optical/UV telescope. As part of GOMAP, NASA will form and coordinate a series of groups whose collective activities will perform and document analyses that advance HWO's concept maturity. These analyses will inform a future pre-phase-A project's decisions on HWO science, technology, and architecture trades. One of the groups being formed is the START. The START will translate the Astro2020 science objectives and goals into quantified observational capabilities for HWO.

ESA will appoint up to three representatives to the START. These positions will be for the duration of the START activities (expected to be between 18-36 months) or for a duration of 36 months, whichever comes first. With the exception of expenses incurred while travelling for activities related to the current call (a maximum of two transatlantic trips per year), ESA will not fund the activities of the scientists and each proposer is responsible for securing their own funding from other sources.

The AO is open to scientists and engineers based in ESA Member States. Early career scientists and historically under-represented groups in astronomy and space sciences are encouraged to apply.

Full details of this AO and the relevant submission forms can be found in the ESA HWO-START call. Proposals in response to this AO must be preceded by a mandatory Letter of Intent. Proposals not preceded by a Letter of Intent will not be considered. The Letters of Intent are due by 12 noon CET, 1 November 2023, and the deadline for receipt of proposals is 12:00 CEST, 30 November 2023.
Research:(https://esahubble.org/announcements/ann2301/)
Contacts
Chris Evans
ESA/HST & ESA/JWST Project Scientist
ESA Office, STScI Baltimore, USA
Email: hubblenewseurope@stsci.edu

Paul McNamara
Astronomy and Astrophysics Coordinator
ESA/ESTEC, 2200 AG Noordwijk, The Netherlands
Email: Paul.McNamara@esa.int'''
    },
    {
      'imgUrl': 'https://cdn.esahubble.org/archives/images/screen/heic2411a.jpg',
      'title': 'Hubble finds that a black hole beam promotes stellar eruptions',
      'description': '''Hubble finds that a black hole beam promotes stellar eruptions:                                                                               In a surprise finding, astronomers using the NASA/ESA Hubble Space Telescope have discovered that the blowtorch-like jet from a supermassive black hole at the core of a huge galaxy seems to cause stars to erupt along its trajectory. The stars, called novae, are not caught inside the jet, but are apparently in a dangerous neighbourhood nearby.

The finding confounds researchers searching for an explanation. "We don't know what's going on, but it's just a very exciting finding," said lead author Alec Lessing of Stanford University. "This means there's something missing from our understanding of how black hole jets interact with their surroundings."

A nova erupts in a double-star system where an ageing, swelled-up, normal star spills hydrogen onto a burned-out white dwarf companion star. When the dwarf has tanked up a mile-deep surface layer of hydrogen that layer explodes like a giant nuclear bomb. The white dwarf isn't destroyed by the nova eruption, which ejects its surface layer and then goes back to syphoning fuel from its companion, and the nova-outburst cycle starts over again.

Hubble found twice as many novae going off near the jet as elsewhere in the giant galaxy during the surveyed time period. The jet is launched by a 6.5-billion-solar-mass central black hole surrounded by a disc of swirling matter. The black hole, engorged with infalling matter, launches a 3000-light-year-long jet of plasma blazing through space at nearly the speed of light. Anything caught in the energetic beam would be sizzled. But being near its blistering outflow is apparently also risky, according to the new Hubble findings.

The finding of twice as many novae near the jet implies that there are twice as many nova-forming double-star systems near the jet or that these systems erupt twice as often as similar systems elsewhere in the galaxy.

"There's something that the jet is doing to the star systems that wander into the surrounding neighbourhood. Maybe the jet somehow snowplows hydrogen fuel onto the white dwarfs, causing them to erupt more frequently," said Lessing. "But it's not clear that it's a physical pushing. It could be the effect of the pressure of the light emanating from the jet. When you deliver hydrogen faster, you get eruptions faster. Something might be doubling the mass transfer rate onto the white dwarfs near the jet." Another idea the researchers considered is that the jet is heating the dwarf's companion star, causing it to overflow further and dump more hydrogen onto the dwarf. However, the researchers calculated that this heating is not nearly large enough to have this effect.

"We're not the first people who've said that it looks like there's more activity going on around the M87 jet," said co-investigator Michael Shara of the American Museum of Natural History in New York City. "But Hubble has shown this enhanced activity with far more examples and statistical significance than we ever had before."

Shortly after Hubble's launch in 1990, astronomers used its first-generation Faint Object Camera (FOC) to peer into the center of M87 where the monster black hole lurks. They noted that unusual things were happening around the black hole. Almost every time Hubble looked, astronomers saw bluish "transient events" that could be evidence for novae popping off like camera flashes from nearby paparazzi. But the FOC's view was so narrow that Hubble astronomers couldn't look away from the jet to compare with the near-jet region. For over two decades, the results remained mysteriously tantalising.

Compelling evidence for the jet's influence on the stars of the host galaxy was collected over a nine-month interval when Hubble observed with newer, wider-view cameras to count the erupting novae. This was a challenge for the telescope's observing schedule because it required revisiting M87 precisely every five days for another snapshot. Adding up all of the M87 images led to the deepest images of M87 that have ever been taken. 

Hubble found 94 novae in the one-third of M87 that its camera can encompass. "The jet was not the only thing that we were looking at — we were looking at the entire inner galaxy. Once you plotted all known novae on top of M87 you didn't need statistics to convince yourself that there is an excess of novae along the jet. This is not rocket science. We made the discovery simply by looking at the images. And while we were really surprised, our statistical analyses of the data confirmed what we clearly saw," said Shara.

“We are witnessing an intriguing but puzzling phenomenon,” commented Chiara Circosta, an ESA Research Fellow, who studies the impact that accreting supermassive blackholes have on the galaxies hosting them in the distant Universe. “I was very surprised by this discovery. Such detailed observations of nearby galaxies are precious to expand our understanding of how jets interact with their host galaxies and potentially affect star formation”

This accomplishment is entirely due to Hubble's unique capabilities. Ground-based telescope images do not have the clarity to see novae deep inside M87. They cannot resolve stars or stellar eruptions close to the galaxy's core because the black hole's surroundings are far too bright. Only Hubble can detect novae against the bright M87 background. 

Novae are remarkably common in the Universe. One nova erupts somewhere in M87 every day. But since there are at least 100 billion galaxies throughout the visible universe, around one million novae erupt every second somewhere out there.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.
                                                                                                                                       Research:(https://esahubble.org/news/heic2411/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org'''
    },
    {
      'imgUrl': 'https://cdn.esahubble.org/archives/images/newsfeature/heic2409a.jpg',
      'title': 'Hubble finds strong evidence for intermediate-mass black hole',
      'description': '''Hubble finds strong evidence for intermediate-mass black hole in Omega Centauri:                                        An international team of astronomers has used more than 500 images from the NASA/ESA Hubble Space Telescope spanning two decades to detect seven fast-moving stars in the innermost region of Omega Centauri, the largest and brightest globular cluster in the sky. These stars provide compelling new evidence for the presence of an intermediate-mass black hole.

Intermediate-mass black holes (IMBHs) are a long-sought ‘missing link’ in black hole evolution. Only a few other IMBH candidates have been found to date. Most known black holes are either extremely massive, like the supermassive black holes that lie at the cores of large galaxies, or relatively lightweight, with a mass less than 100 times that of the Sun. Black holes are one of the most extreme environments humans are aware of, and so they are a testing ground for the laws of physics and our understanding of how the Universe works. If IMBHs exist, how common are they? Does a supermassive black hole grow from an IMBH? How do IMBHs themselves form? Are dense star clusters their favoured home?

Omega Centauri is visible from Earth with the naked eye and is one of the favourite celestial objects for stargazers in the southern hemisphere. Although the cluster is 17 700 light-years away, lying just above the plane of the Milky Way, it appears almost as large as the full Moon when seen from a dark rural area. The exact classification of Omega Centauri has evolved through time, as our ability to study it has improved. It was first listed in Ptolemy's catalogue nearly two thousand years ago as a single star. Edmond Halley reported it as a nebula in 1677, and in the 1830s the English astronomer John Herschel was the first to recognise it as a globular cluster.

Globular clusters typically consist of up to one million old stars tightly bound together by gravity and are found both in the outskirts and central regions of many galaxies, including our own. Omega Centauri has several characteristics that distinguish it from other globular clusters: it rotates faster than a run-of-the-mill globular cluster, and its shape is highly flattened. Moreover, Omega Centauri is about 10 times as massive as other big globular clusters, almost as massive as a small galaxy.

Omega Centauri consists of roughly 10 million stars that are gravitationally bound. An international team has now created an enormous catalogue of the motions of these stars, measuring the velocities for 1.4 million stars by studying over 500 Hubble images of the cluster. Most of these observations were intended to calibrate Hubble’s instruments rather than for scientific use, but they turned out to be an ideal database for the team’s research efforts. The extensive catalogue, which is the largest catalogue of motions for any star cluster to date, will be made openly available (more information is available here).

“We discovered seven stars that should not be there,” explained Maximilian Häberle of the Max Planck Institute for Astronomy in Germany, who led this investigation. “They are moving so fast that they should escape the cluster and never come back. The most likely explanation is that a very massive object is gravitationally pulling on these stars and keeping them close to the centre. The only object that can be so massive is a black hole, with a mass at least 8200 times that of our Sun.”

Several studies have suggested the presence of an IMBH in Omega Centauri [1]. However, other studies proposed that the mass could be contributed by a central cluster of stellar-mass black holes, and had suggested the lack of fast-moving stars above the necessary escape velocity made an IMBH less likely in comparison.

“This discovery is the most direct evidence so far of an IMBH in Omega Centauri,” added team lead Nadine Neumayer, also of the Max Planck Institute for Astronomy, who initiated the study with Anil Seth of the University of Utah in the United States. “This is exciting because there are only very few other black holes known with a similar mass. The black hole in Omega Centauri may be the best example of an IMBH in our cosmic neighbourhood.”

If confirmed, at its distance of 17 700 light-years the candidate black hole resides closer to Earth than the 4.3 million solar mass black hole in the centre of the Milky Way, which is 26 000 light-years away. Besides the Galactic centre, it would also be the only known case of a number of stars closely bound to a massive black hole.

The science team now hopes to characterise the black hole. While it is believed to measure at least 8200 solar masses, its exact mass and its precise position are not fully known. The team also intends to study the orbits of the fast-moving stars, which requires additional measurements of the respective line-of-sight velocities. The team has been granted time with the NASA/ESA/CSA James Webb Space Telescope to do just that, and also has other pending proposals to use other observatories.

Omega Centauri was also a recent feature of a new data release from ESA’s Gaia mission, which contained over 500 000 stars. “Even after 30 years, the Hubble Space Telescope with its imaging instruments is still one of the best tools for high-precision astrometry in crowded stellar fields, regions where Hubble can provide added sensitivity from ESA’s Gaia mission observations,” shared team member Mattia Libralato of the National Institute for Astrophysics in Italy (INAF), and previously of AURA for the European Space Agency during the time of this study. “Our results showcase Hubble’s high resolution and sensitivity that are giving us exciting new scientific insights and will give a new boost to the topic of IMBHs in globular clusters.”

The results have been published online today in the journal Nature.

Notes
[1] In 2008, the Hubble Space Telescope and the Gemini Observatory found that the explanation behind Omega Centauri's peculiarities may be a black hole hidden in its centre.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

The international team of astronomers in this study consists of M. Häberle (Max Planck Institute for Astronomy, Germany [MPIA]), N. Neumayer (MPIA), A. Seth (University of Utah, USA [Utah]), A. Bellin (Space Telescope Science Institute, USA)i, M. Libralato (AURA for ESA, and INAF), H. Baumgardt (University of Queensland, Australia), M. Whitaker (Utah), A. Dumont (MPIA), M. A. Cuello (Universidad Central de Chile, Chile, and Space Telescope Science Institute, USA [STScI]), J. Anderson (STScI), C. Clontz (MPIA and STScI), N. Kacharov (Leibniz Institute for Astrophysics, Germany), S. Kamann (Liverpool John Moores University, United Kingdom [Liverpool]), A. Feldmeier-Krause (MPIA and University of Vienna, Austria [Vienna]), A. Milone (University of Padova, Italy), M. S. Nitschai (MPIA), R. Pechett (Liverpool), and G. van de Ven (Vienna).

This result makes use of several Hubble GO observation programmes: 9442, 10252, 10775, 12193, 13066, 13606, 15594, 15764, 15857, 16380, 16384, 16520, 16968, 11452, 11011, 12094, 12339, 12353, 12580, 12694, 12700, 12714, 12802, 13100, 13570, 14031, 14393, 14550, 14759, 15000, 15593, 15594, 15733, 15857, 16117, 16514, 16441, 16588, 16777, and 17023. They have been collectively compiled here.

Image credit: ESA/Hubble & NASA, M. Häberle (MPIA)
Research:(https://esahubble.org/news/heic2409/)
Contacts
Maximilian Häberle
Max Planck Institute for Astronomy, Germany
Email: haeberle@mpia.de

Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org'''
    },
  ];

  // Video data similar to what's used in the VideosPage
  final Map<String, String> videoData = {
    'Solar System 101 | National Geographic': 'https://youtu.be/libKVRa01L8?si=0fSWiabKHlyswyMf',
    'Stars 101 | National Geographic': 'https://youtu.be/EFO_bsg1sw8?si=D9CAYrSozzhGZiyn',
    'Mars 101 | National Geographic': 'https://youtu.be/E-PuUs25rJA?si=jK4kKMOUldOJgyJd',
    'Pluto 101 | National Geographic': 'https://youtu.be/-iZio70bd-M?si=F4x7dB-5qGNuTaYI',
  };
}
class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Welcome to the Chatbot Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}





class VideosPage extends StatelessWidget {
  final Map<String, String> videoData = {
    'Solar System 101 | National Geographic': 'https://youtu.be/libKVRa01L8',
    'Stars 101 | National Geographic': 'https://youtu.be/EFO_bsg1sw8',
    'Mars 101 | National Geographic': 'https://youtu.be/E-PuUs25rJA',
    'Pluto 101 | National Geographic': 'https://youtu.be/-iZio70bd-M',
  };

  // YouTube URL'yi doğrudan başlatan fonksiyon
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url); // YouTube uygulamasında ya da tarayıcıda aç
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          String title = videoData.keys.elementAt(index);
          String videoUrl = videoData.values.elementAt(index);

          // YouTube URL'sinden Thumbnail URL'sini oluşturma
          String thumbnailUrl = 'https://img.youtube.com/vi/${Uri.parse(videoUrl).pathSegments.last}/0.jpg';

          return GestureDetector(
            onTap: () {
              _launchURL(videoUrl);  // Tıklandığında URL'yi başlat
            },
            child: Card(
              color: Colors.black,
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
  final Map<String, String> videoData = {
    'Solar System 101 | National Geographic': 'https://youtu.be/libKVRa01L8',
    'Stars 101 | National Geographic': 'https://youtu.be/EFO_bsg1sw8',
    'Mars 101 | National Geographic': 'https://youtu.be/E-PuUs25rJA',
    'Pluto 101 | National Geographic': 'https://youtu.be/-iZio70bd-M',
  };
  // YouTube URL'den Video ID'si almayı sağlayan manuel fonksiyon

// YouTube URL'den Video ID'si almayı sağlayan manuel fonksiyon
  String? _getVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    } else if (uri.host.contains('youtube.com') || uri.host.contains('www.youtube.com')) {
      return uri.queryParameters['v'];
    }
    return null;
  }

// YouTube URL'sine yönlendiren fonksiyon
  Future<void> _launchURL(String url) async {
    // YouTube URL'sinden video ID'sini alıyoruz
    String? videoId = _getVideoId(url);

    if (videoId != null) {
      // YouTube uygulaması için URL oluşturuyoruz
      String youtubeAppUrl = 'vnd.youtube://$videoId';  // YouTube uygulaması için
      String webUrl = 'https://youtube.com/watch?v=$videoId';  // Tarayıcı için

      try {
        // Önce YouTube uygulamasını açmayı deniyoruz
        bool launchedApp = await launchUrl(Uri.parse(youtubeAppUrl), mode: LaunchMode.externalApplication);

        // Eğer YouTube uygulaması açılamazsa tarayıcıya yönlendiriyoruz
        if (!launchedApp) {
          await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        print('Could not launch URL: $e');
      }
    } else {
      print('Invalid YouTube URL');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          String title = videoData.keys.elementAt(index);
          String videoUrl = videoData.values.elementAt(index);
          String? videoId = _getVideoId(videoUrl);
          String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg'; // YouTube thumbnail URL

          return GestureDetector(
            onTap: () {
              _launchURL(videoUrl);  // Launch YouTube URL when thumbnail is tapped
            },
            child: Card(
              color: Colors.black,
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('News',style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: acikRenkBeyaz,),),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic1817a.jpg',
              title: '''ESA Invites European Community to Participate in NASA's GOMAP START for Habitable Worlds Observatory.''',
              description:
              '''A special Announcement of Opportunity (AO) is soliciting the participation of the European community in the role of ESA-appointed representatives to the NASA Great Observatory Maturation Program’s (GOMAP) Science, Technology, Architecture Review Team (START) for the Habitable Worlds Observatory (HWO) mission.

The 2020 National Academy of Sciences Decadal Survey on Astronomy and Astrophysics (Astro2020) recommended a "Great Observatories Mission and Technology Maturation Program" as its highest priority in Enabling Programs for Space. Astro2020 further recommended that the first mission to enter the maturation program be an infrared-optical-ultraviolet (IR/Optical/UV) space telescope. In response to these recommendations, NASA has established the Great Observatory Maturation Program (GOMAP). Consistent with the guidance from Astro2020, the first entrant into GOMAP will be the Habitable Worlds Observatory (HWO), a space-based IR/Optical/UV telescope. As part of GOMAP, NASA will form and coordinate a series of groups whose collective activities will perform and document analyses that advance HWO's concept maturity. These analyses will inform a future pre-phase-A project's decisions on HWO science, technology, and architecture trades. One of the groups being formed is the START. The START will translate the Astro2020 science objectives and goals into quantified observational capabilities for HWO.

ESA will appoint up to three representatives to the START. These positions will be for the duration of the START activities (expected to be between 18-36 months) or for a duration of 36 months, whichever comes first. With the exception of expenses incurred while travelling for activities related to the current call (a maximum of two transatlantic trips per year), ESA will not fund the activities of the scientists and each proposer is responsible for securing their own funding from other sources.

The AO is open to scientists and engineers based in ESA Member States. Early career scientists and historically under-represented groups in astronomy and space sciences are encouraged to apply.

Full details of this AO and the relevant submission forms can be found in the ESA HWO-START call. Proposals in response to this AO must be preceded by a mandatory Letter of Intent. Proposals not preceded by a Letter of Intent will not be considered. The Letters of Intent are due by 12 noon CET, 1 November 2023, and the deadline for receipt of proposals is 12:00 CEST, 30 November 2023.
Research:(https://esahubble.org/announcements/ann2301/)
Contacts
Chris Evans
ESA/HST & ESA/JWST Project Scientist
ESA Office, STScI Baltimore, USA
Email: hubblenewseurope@stsci.edu

Paul McNamara
Astronomy and Astrophysics Coordinator
ESA/ESTEC, 2200 AG Noordwijk, The Netherlands
Email: Paul.McNamara@esa.int''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/screen/heic2411a.jpg',
              title: 'Hubble finds that a black hole beam promotes stellar eruptions',
              description:
              '''Hubble finds that a black hole beam promotes stellar eruptions:                                                                               In a surprise finding, astronomers using the NASA/ESA Hubble Space Telescope have discovered that the blowtorch-like jet from a supermassive black hole at the core of a huge galaxy seems to cause stars to erupt along its trajectory. The stars, called novae, are not caught inside the jet, but are apparently in a dangerous neighbourhood nearby.

The finding confounds researchers searching for an explanation. "We don't know what's going on, but it's just a very exciting finding," said lead author Alec Lessing of Stanford University. "This means there's something missing from our understanding of how black hole jets interact with their surroundings."

A nova erupts in a double-star system where an ageing, swelled-up, normal star spills hydrogen onto a burned-out white dwarf companion star. When the dwarf has tanked up a mile-deep surface layer of hydrogen that layer explodes like a giant nuclear bomb. The white dwarf isn't destroyed by the nova eruption, which ejects its surface layer and then goes back to syphoning fuel from its companion, and the nova-outburst cycle starts over again.

Hubble found twice as many novae going off near the jet as elsewhere in the giant galaxy during the surveyed time period. The jet is launched by a 6.5-billion-solar-mass central black hole surrounded by a disc of swirling matter. The black hole, engorged with infalling matter, launches a 3000-light-year-long jet of plasma blazing through space at nearly the speed of light. Anything caught in the energetic beam would be sizzled. But being near its blistering outflow is apparently also risky, according to the new Hubble findings.

The finding of twice as many novae near the jet implies that there are twice as many nova-forming double-star systems near the jet or that these systems erupt twice as often as similar systems elsewhere in the galaxy.

"There's something that the jet is doing to the star systems that wander into the surrounding neighbourhood. Maybe the jet somehow snowplows hydrogen fuel onto the white dwarfs, causing them to erupt more frequently," said Lessing. "But it's not clear that it's a physical pushing. It could be the effect of the pressure of the light emanating from the jet. When you deliver hydrogen faster, you get eruptions faster. Something might be doubling the mass transfer rate onto the white dwarfs near the jet." Another idea the researchers considered is that the jet is heating the dwarf's companion star, causing it to overflow further and dump more hydrogen onto the dwarf. However, the researchers calculated that this heating is not nearly large enough to have this effect.

"We're not the first people who've said that it looks like there's more activity going on around the M87 jet," said co-investigator Michael Shara of the American Museum of Natural History in New York City. "But Hubble has shown this enhanced activity with far more examples and statistical significance than we ever had before."

Shortly after Hubble's launch in 1990, astronomers used its first-generation Faint Object Camera (FOC) to peer into the center of M87 where the monster black hole lurks. They noted that unusual things were happening around the black hole. Almost every time Hubble looked, astronomers saw bluish "transient events" that could be evidence for novae popping off like camera flashes from nearby paparazzi. But the FOC's view was so narrow that Hubble astronomers couldn't look away from the jet to compare with the near-jet region. For over two decades, the results remained mysteriously tantalising.

Compelling evidence for the jet's influence on the stars of the host galaxy was collected over a nine-month interval when Hubble observed with newer, wider-view cameras to count the erupting novae. This was a challenge for the telescope's observing schedule because it required revisiting M87 precisely every five days for another snapshot. Adding up all of the M87 images led to the deepest images of M87 that have ever been taken. 

Hubble found 94 novae in the one-third of M87 that its camera can encompass. "The jet was not the only thing that we were looking at — we were looking at the entire inner galaxy. Once you plotted all known novae on top of M87 you didn't need statistics to convince yourself that there is an excess of novae along the jet. This is not rocket science. We made the discovery simply by looking at the images. And while we were really surprised, our statistical analyses of the data confirmed what we clearly saw," said Shara.

“We are witnessing an intriguing but puzzling phenomenon,” commented Chiara Circosta, an ESA Research Fellow, who studies the impact that accreting supermassive blackholes have on the galaxies hosting them in the distant Universe. “I was very surprised by this discovery. Such detailed observations of nearby galaxies are precious to expand our understanding of how jets interact with their host galaxies and potentially affect star formation”

This accomplishment is entirely due to Hubble's unique capabilities. Ground-based telescope images do not have the clarity to see novae deep inside M87. They cannot resolve stars or stellar eruptions close to the galaxy's core because the black hole's surroundings are far too bright. Only Hubble can detect novae against the bright M87 background. 

Novae are remarkably common in the Universe. One nova erupts somewhere in M87 every day. But since there are at least 100 billion galaxies throughout the visible universe, around one million novae erupt every second somewhere out there.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.
                                                                                                                                       Research:(https://esahubble.org/news/heic2411/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2409a.jpg',
              title: 'Hubble finds strong evidence for intermediate-mass black hole in Omega Centauri',
              description:
              '''Hubble finds strong evidence for intermediate-mass black hole in Omega Centauri:                                        An international team of astronomers has used more than 500 images from the NASA/ESA Hubble Space Telescope spanning two decades to detect seven fast-moving stars in the innermost region of Omega Centauri, the largest and brightest globular cluster in the sky. These stars provide compelling new evidence for the presence of an intermediate-mass black hole.

Intermediate-mass black holes (IMBHs) are a long-sought ‘missing link’ in black hole evolution. Only a few other IMBH candidates have been found to date. Most known black holes are either extremely massive, like the supermassive black holes that lie at the cores of large galaxies, or relatively lightweight, with a mass less than 100 times that of the Sun. Black holes are one of the most extreme environments humans are aware of, and so they are a testing ground for the laws of physics and our understanding of how the Universe works. If IMBHs exist, how common are they? Does a supermassive black hole grow from an IMBH? How do IMBHs themselves form? Are dense star clusters their favoured home?

Omega Centauri is visible from Earth with the naked eye and is one of the favourite celestial objects for stargazers in the southern hemisphere. Although the cluster is 17 700 light-years away, lying just above the plane of the Milky Way, it appears almost as large as the full Moon when seen from a dark rural area. The exact classification of Omega Centauri has evolved through time, as our ability to study it has improved. It was first listed in Ptolemy's catalogue nearly two thousand years ago as a single star. Edmond Halley reported it as a nebula in 1677, and in the 1830s the English astronomer John Herschel was the first to recognise it as a globular cluster.

Globular clusters typically consist of up to one million old stars tightly bound together by gravity and are found both in the outskirts and central regions of many galaxies, including our own. Omega Centauri has several characteristics that distinguish it from other globular clusters: it rotates faster than a run-of-the-mill globular cluster, and its shape is highly flattened. Moreover, Omega Centauri is about 10 times as massive as other big globular clusters, almost as massive as a small galaxy.

Omega Centauri consists of roughly 10 million stars that are gravitationally bound. An international team has now created an enormous catalogue of the motions of these stars, measuring the velocities for 1.4 million stars by studying over 500 Hubble images of the cluster. Most of these observations were intended to calibrate Hubble’s instruments rather than for scientific use, but they turned out to be an ideal database for the team’s research efforts. The extensive catalogue, which is the largest catalogue of motions for any star cluster to date, will be made openly available (more information is available here).

“We discovered seven stars that should not be there,” explained Maximilian Häberle of the Max Planck Institute for Astronomy in Germany, who led this investigation. “They are moving so fast that they should escape the cluster and never come back. The most likely explanation is that a very massive object is gravitationally pulling on these stars and keeping them close to the centre. The only object that can be so massive is a black hole, with a mass at least 8200 times that of our Sun.”

Several studies have suggested the presence of an IMBH in Omega Centauri [1]. However, other studies proposed that the mass could be contributed by a central cluster of stellar-mass black holes, and had suggested the lack of fast-moving stars above the necessary escape velocity made an IMBH less likely in comparison.

“This discovery is the most direct evidence so far of an IMBH in Omega Centauri,” added team lead Nadine Neumayer, also of the Max Planck Institute for Astronomy, who initiated the study with Anil Seth of the University of Utah in the United States. “This is exciting because there are only very few other black holes known with a similar mass. The black hole in Omega Centauri may be the best example of an IMBH in our cosmic neighbourhood.”

If confirmed, at its distance of 17 700 light-years the candidate black hole resides closer to Earth than the 4.3 million solar mass black hole in the centre of the Milky Way, which is 26 000 light-years away. Besides the Galactic centre, it would also be the only known case of a number of stars closely bound to a massive black hole.

The science team now hopes to characterise the black hole. While it is believed to measure at least 8200 solar masses, its exact mass and its precise position are not fully known. The team also intends to study the orbits of the fast-moving stars, which requires additional measurements of the respective line-of-sight velocities. The team has been granted time with the NASA/ESA/CSA James Webb Space Telescope to do just that, and also has other pending proposals to use other observatories.

Omega Centauri was also a recent feature of a new data release from ESA’s Gaia mission, which contained over 500 000 stars. “Even after 30 years, the Hubble Space Telescope with its imaging instruments is still one of the best tools for high-precision astrometry in crowded stellar fields, regions where Hubble can provide added sensitivity from ESA’s Gaia mission observations,” shared team member Mattia Libralato of the National Institute for Astrophysics in Italy (INAF), and previously of AURA for the European Space Agency during the time of this study. “Our results showcase Hubble’s high resolution and sensitivity that are giving us exciting new scientific insights and will give a new boost to the topic of IMBHs in globular clusters.”

The results have been published online today in the journal Nature.

Notes
[1] In 2008, the Hubble Space Telescope and the Gemini Observatory found that the explanation behind Omega Centauri's peculiarities may be a black hole hidden in its centre.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

The international team of astronomers in this study consists of M. Häberle (Max Planck Institute for Astronomy, Germany [MPIA]), N. Neumayer (MPIA), A. Seth (University of Utah, USA [Utah]), A. Bellin (Space Telescope Science Institute, USA)i, M. Libralato (AURA for ESA, and INAF), H. Baumgardt (University of Queensland, Australia), M. Whitaker (Utah), A. Dumont (MPIA), M. A. Cuello (Universidad Central de Chile, Chile, and Space Telescope Science Institute, USA [STScI]), J. Anderson (STScI), C. Clontz (MPIA and STScI), N. Kacharov (Leibniz Institute for Astrophysics, Germany), S. Kamann (Liverpool John Moores University, United Kingdom [Liverpool]), A. Feldmeier-Krause (MPIA and University of Vienna, Austria [Vienna]), A. Milone (University of Padova, Italy), M. S. Nitschai (MPIA), R. Pechett (Liverpool), and G. van de Ven (Vienna).

This result makes use of several Hubble GO observation programmes: 9442, 10252, 10775, 12193, 13066, 13606, 15594, 15764, 15857, 16380, 16384, 16520, 16968, 11452, 11011, 12094, 12339, 12353, 12580, 12694, 12700, 12714, 12802, 13100, 13570, 14031, 14393, 14550, 14759, 15000, 15593, 15594, 15733, 15857, 16117, 16514, 16441, 16588, 16777, and 17023. They have been collectively compiled here.

Image credit: ESA/Hubble & NASA, M. Häberle (MPIA)
Research:(https://esahubble.org/news/heic2409/)
Contacts
Maximilian Häberle
Max Planck Institute for Astronomy, Germany
Email: haeberle@mpia.de

Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2312a.jpg',
              title: 'Hubble watches spoke season on Saturn',
              description:
              '''Hubble watches spoke season on Saturn:                                                                                                          This photo of Saturn was taken by the NASA/ESA Hubble Space Telescope on 22 October 2023, when the ringed planet was approximately 1365 million kilometres from Earth. Hubble's ultra-sharp vision reveals a phenomenon called ring spokes.

Saturn's spokes are transient features that rotate along with the rings. Their ghostly appearance only persists for two or three rotations around Saturn. During active periods, freshly-formed spokes continuously add to the pattern.

In 1981, NASA's Voyager 2 first photographed the ring spokes. Hubble continues observing Saturn annually as the spokes come and go. This cycle has been captured by Hubble's Outer Planets Atmospheres Legacy (OPAL) program that began nearly a decade ago to annually monitor weather changes on all four gas-giant outer planets.

Hubble's crisp images show that the frequency of spoke apparitions is seasonally driven, first appearing in OPAL data in 2021 but only on the morning (left) side of the rings. Long-term monitoring shows that both the number and contrast of the spokes vary with Saturn's seasons. Saturn is tilted on its axis like Earth and has seasons lasting approximately seven years.

This year, these ephemeral structures appear on both sides of the planet simultaneously as they spin around the giant world. Although they look small compared with Saturn, their length and width can stretch longer than Earth's diameter!

The OPAL team notes that the leading theory is that spokes are tied to interactions between Saturn's powerful magnetic field and the sun. Planetary scientists think that electrostatic forces generated from this interaction levitate dust or ice above the ring to form the spokes, though after several decades no theory perfectly predicts the spokes. Continued Hubble observations may eventually help solve the mystery.This image was created with Hubble data from proposal 16995 (A. Simon).

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

Image credit: NASA, ESA, STScI, A. Simon (NASA-GSFC)
Research(https://esahubble.org/news/heic2312/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2302a.jpg',
              title: 'Hubble captures movie of DART asteroid impact debris',
              description:
              '''Hubble captures movie of DART asteroid impact debris:                                                                                   The NASA/ESA Hubble Space Telescope captured a series of photos of rapid changes to the asteroid Dimorphos when it was deliberately hit by a 545-kilogram spacecraft on 26 September 2022. The primary objective of the NASA mission, called DART (Double Asteroid Redirection Test), was to test our ability to alter the asteroid’s trajectory as it orbits its larger companion asteroid, Didymos. Though Dimorphos poses no threat to Earth, data from the mission could help inform researchers how to potentially change an asteroid’s path away from Earth, if ever necessary.

Hubble’s resulting time-lapse movie of the aftermath of the collision reveals surprising and remarkable changes as dust and chunks of debris were flung into space from the wounded asteroid. Smashing head-on into the asteroid at 21 000 kilometres per hour, the DART impactor blasted over 900 000 kilograms of dust off of the asteroid.

The Hubble movie provides invaluable new clues into how the debris was dispersed into a complex pattern in the days following the impact.

The movie shows three overlapping stages of the aftermath of the crash: the formation of an ejecta cone, the spiral swirl of debris caught up along the asteroid’s orbit about its companion asteroid, and the tail swept behind the asteroid by the pressure of sunlight.

The Hubble movie starts at 1.3 hours before impact. In this view both Didymos and Dimorphos are within the central bright spot; even Hubble can’t resolve the two asteroids separately. The thin, straight spikes projecting away from the centre (and seen in later images) are artefacts of Hubble’s optics. The first post-impact snapshot is two hours after the event. Debris flies away from the asteroid, moving in with a range of speeds faster than four miles per hour (fast enough to escape the asteroid’s gravitational pull, so it does not fall back onto the asteroid). The ejecta forms a largely hollow cone with long, stringy filaments.

At about 17 hours after the collision the debris pattern entered a second stage. The dynamic interaction within the binary system started to distort the cone shape of the ejecta pattern. The most prominent structures are rotating, pinwheel-shaped features. The pinwheel is tied to the gravitational pull of the companion asteroid, Didymos.

Hubble next captures the debris being swept back into a comet-like tail by the pressure of sunlight on the tiny dust particles. This stretches out into a debris train where the lightest particles travel the fastest and farthest from the asteroid. Hubble also recorded the tail splitting in two for a few days. 

Due to launch in October 2024, ESA’s Hera mission will perform a detailed post-impact survey of the target asteroid Dimorphos. Hera will turn the grand-scale experiment into a well-understood and repeatable planetary defence technique that might one day be used for real.

Just like Hubble and the NASA/ESA/CSA James Webb Space Telescope, NASA’s DART and ESA’s Hera missions are great examples of what international collaboration can achieve; the two missions are supported by the same teams of scientists and astronomers, and operate via an international collaboration called AIDA — the Asteroid Impact and Deflection Assessment.

NASA and ESA worked together in the early 2000s to develop asteroid monitoring systems, but recognised there was a missing link in the chain between asteroid threat identification and ways of addressing that threat. In response NASA oversaw the DART mission while ESA developed the Hera mission to gather additional data on DART’s impact. With the Hera mission, ESA is assuming even greater responsibility for protecting our planet and ensuring that Europe plays a leading role in the common effort to tackle asteroid risks. As Europe’s flagship planetary defender, Hera is supported through the Agency’s Space Safety programme, part of the Operations Directorate. 
Resource(https://esahubble.org/news/heic2302/)
More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.
Image credit: NASA, ESA, STScI, J. Li (PSI)

Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org

Ninja Menning
ESA Newsroom and Media Relations Office
Email: media@esa.int''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2208a.jpg',
              title: 'A Dazzling Hubble Collection of Supernova Host Galaxies',
              description:
              '''A Dazzling Hubble Collection of Supernova Host Galaxies:                                                                       Spanning from 2003 to 2021, this collection of images from the NASA/ESA Hubble Space Telescope features galaxies that are all hosts to both Cepheid variables and supernovae. These two celestial phenomena are both crucial tools used by astronomers to determine astronomical distance, and have been used to refine our measurement of Hubble’s constant, the expansion rate of the Universe

Each of the images in this special collection features a spiral galaxy that hosts both Cepheid variables and a special class of supernovae, two remarkable stellar phenomena that on the face of it do not have much in common: Cepheid variables are pulsating stars that regularly brighten and dim and type Ia supernovae are the catastrophic explosions that mark the death throes of a hot, dense white dwarf star.  However, both can be used by astronomers to measure the distance to an astronomical object.

Establishing the distance of a celestial body is an enormous challenge for astronomers; it can be difficult to distinguish between objects that are dim and relatively close to the Earth and those which are bright and distant. To help overcome this challenge, astronomers have developed what is known as the cosmic distance ladder, a series of distance-determining methods, organised by the relative distances that they can measure. Two important steps in this ladder are Cepheid variables and supernovae: Cepheid variables because the period with which they pulsate can be used to calculate their distance; and supernovae because every type Ia supernova explosion reaches the same known luminosity, meaning that its brightness as viewed from Earth can be used to derive its distance. All the galaxies presented in this collection host Cepheid variables and have had at least one type Ia supernova explosion occur in them within the last 40 years. One of the galaxies, NGC 2525, even contained a supernova that was caught in real time in a remarkable timelapse.

Even before it was launched, one of Hubble’s main science goals was to observe Cepheid variables and supernovae. These observations can help measure the expansion rate of the Universe, a value which astronomers call the Hubble constant. Generations of astronomers have refined this value over almost 30 years using data from more than 1000 hours of Hubble time. Most recently, a team of astronomers called SH0ES [1] used observations of all the supernovae seen by Hubble in the last 40 years  — including those in the galaxies pictured here — to determine the value of the Hubble constant as 73.04 ± 1:04 kms-1 Mpc-1 [2]. 

“This is what the Hubble Space Telescope was built to do. You are getting the standard measure for the Universe from the gold standard of telescopes,” said Nobel Laureate Adam Riess of Johns Hopkins University in Baltimore, Maryland, who leads the SH0ES Team. “This is Hubble’s magnum opus.”

Interestingly, the expansion rate determined from observational data from telescopes is significantly different from the value predicted by our current standard cosmological model of the Universe. The richness of the Hubble data means that this is vanishingly unlikely to have happened by a chance selection of misleading observations. 

The wide collection of Cepheid variable and supernovae-hosting galaxies observed by Hubble were picked out in six different proposals for observing time with the telescope [3]. Whilst these proposals were part of Hubble’s decade-long quest to precisely measure the expansion rate of the Universe, the observations also produced a spate of beautiful galactic portraits, such as those of NGC 5643, NGC 7329, and NGC 3254. Still others have previously been featured in Hubble Pictures of the Week and other releases, including NGC 691, NGC 1559, NGC 2525, NGC 2608 and NGC 3147.

Notes
[1] SH0ES stands for “Supernova, H0, for the Equation of State of Dark Energy”

[2] The units of the Hubble constant — kms-1 Mpc-1 — are kilometres per second per megaparsec. If you multiply the distance to an astronomical object in megaparsecs by the Hubble constant you obtain the speed at which that object is receding from Earth as a result of the expansion of the Universe.

[3] The demand for observation time with Hubble is still extremely high, even after more than 30 years since the telescope’s launch, and in order to secure time astronomers need to justify in a written proposal why their work will be helpful and important to the astronomical community.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

The complete list of galaxies imaged above which are hosts to both Cepheid variables and supernovae consists of: NGC 691, NGC 1559, NGC 2525, NGC 2608, NGC 3147, NGC 3583, NGC 5468, NGC 5643, NGC 5861, NGC 7541, Mrk 1337, NGC 4680, NGC 5728, NGC 7329, NGC 7678, M101, NGC 1015, NGC 1309, NGC 1365, NGC 1448, NGC 3021, NGC 3370, NGC 3447, NGC 4424, NGC 5917, NGC 7250, UGC 9391, M106, NGC 3982, NGC 4536, NGC 4639, NGC 5584, The Antennae Galaxies, NGC 2442, NGC 3972, NGC 105 and NGC 3254. 

The SH0ES team of astronomers in this study consists of Adam G. Riess (Space Telescope Science Institute and the Department of Physics and Astronomy, Johns Hopkins University), Wenlong Yuan (Department of Physics and Astronomy, Johns Hopkins University), Lucas M. Macri (George P. and Cynthia W. Mitchell Institute for Fundamental Physics and Astronomy, Texas A&M University), Dan Scolnic (Department of Physics, Duke University), Dillon Brout (Center for Astrophysics, Harvard & Smithsonian), Stefano Casertano (Space Telescope Science Institute), David O. Jones (Department of Astronomy & Astrophysics, University of California, Santa Cruz), Yukei Murakami (Department of Physics and Astronomy, Johns Hopkins University), Louise Breuval (Department of Physics and Astronomy, Johns Hopkins University), Thomas G. Brink (Department of Astronomy, University of California, Berkeley), Alexei V. Filippenko ( Department of Astronomy, University of California, Berkeley and Miller Institute for Basic Research in Science, University of California, Berkeley), Samantha Hoffmann (Space Telescope Science Institute), Saurabh W. Jha (Department of Physics and Astronomy, Rutgers, the State University of New Jersey), W. D'arcy Kenworthy (Department of Physics and Astronomy, Johns Hopkins University), John Mackenty (Space Telescope Science Institute), Benjamin E. Stahl (Department of Astronomy, University of California, Berkeley) and Weikang Zheng (Department of Astronomy, University of California, Berkeley).

Image credit: NASA, ESA

Research(https://esahubble.org/news/heic2208/) 

Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2214a.jpg',
              title: 'Hubble Captures Three Faces of Evolving Supernova in Early Universe',
              description:
              '''Hubble Captures Three Faces of Evolving Supernova in Early Universe:                                                                Three different moments in a far-off supernova explosion were captured in a single snapshot by the NASA/ESA Hubble Space Telescope. The progenitor star exploded more than 11 billion years ago, when the Universe was less than a fifth of its current age of 13.8 billion years.

This is the first detailed look at a supernova at such an early time in the Universe’s evolution. The data could help scientists learn more about the formation of stars and galaxies in the early Universe.

This observation was possible thanks to the phenomenon called gravitational lensing, as first predicted by Einstein’s general theory of relativity. In this case, the light took three different paths through the cosmic lens of the massive galaxy cluster Abell 370, bending and magnifying the light from the more distant supernova located behind the cluster. The three paths were of three different lengths, so when the light arrived at Hubble (on the same day in December 2010), the supernova appeared at three different stages of evolution.

The Hubble exposure also captured the fading supernova’s rapid change of colour, which indicates its changing temperature. The bluer the colour, the hotter the supernova is. The earliest phase captured appears blue. As the supernova cooled its light turned redder.

This is also the first time astronomers have been able to measure the size of a dying star in the early Universe. They did this by observing the supernova’s brightness and rate of cooling, both of which depend on the size of the progenitor star. Hubble’s observations show that the red supergiant whose supernova explosion the researchers discovered had a radius about 500 times larger than the Sun.

An international team of astronomers found this supernova by sifting through the Hubble data archives, looking for transient events. The team also has time planned for the NASA/ESA/CSA James Webb Space Telescope to observe even more distant supernovae. They hope to contribute to a catalogue of very far-off supernovae to help astronomers understand if the stars that existed many billions of years ago are different from those in the nearby Universe. The team’s paper, entitled “Shock cooling of a red-supergiant supernova at redshift 3 in lensed images,” will be published in Nature on 10 November.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

This image was taken as part of the Hubble observation programme GO-11591 (PI J.-P. Kneib).

The associated science results were also supported by the Hubble Cycle 27 Archival Research programme, as well as by Hubble observation programmes GO-15936 and GO-16278.

Image credit: NASA, ESA, STScI, Wenlei Chen (UMN), Patrick Kelly (UMN), Hubble Frontier Fields

Research:(https://esahubble.org/news/heic2214/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: info@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2305a.jpg',
              title: 'Hubble follows shadow play around planet-forming disc',
              description:
              '''Hubble follows shadow play around planet-forming disc
The young star TW Hydrae is playing ‘shadow puppets’ with scientistsI:                                                               In 2017 astronomers reported discovering a shadow sweeping across the face of a vast pancake-shaped disc of gas and dust surrounding the red dwarf star TW Hydrae. The shadow isn’t from a planet, but from an inner disc slightly inclined relative to the much larger outer disc — causing it to cast a shadow. One explanation is that an unseen planet’s gravity is pulling dust and gas into its inclined orbit. Now, a second shadow — playing a game of peek-a-boo — has emerged in just a few years between observations stored in the MAST archive of the NASA/ESA Hubble Space Telescope. This could be from yet another disc nestled inside the system. The two discs are likely evidence of a pair of planets under construction.

TW Hydrae is less than 10 million years old and resides about 200 light-years away. In its infancy, some 4.6 billion years ago, our Solar System may have resembled the TW Hydrae system. Because the TW Hydrae system is tilted nearly face-on as seen from Earth, it is an optimum target for getting a bird’s-eye view of a planetary construction yard.

The second shadow was discovered in observations obtained on 6 June 2021, as part of a multi-year programme designed to track the shadows in circumstellar discs. John Debes of AURA/STScI for the European Space Agency at the Space Telescope Science Institute in Baltimore, Maryland, compared these latest observations of the TW Hydrae disc to Hubble observations made several years ago.

“We found out that the shadow had done something completely different,” said Debes, who is principal investigator and lead author of the study published in The Astrophysical Journal. “When I first looked at the data, I thought something had gone wrong with the observation because it wasn’t what I was expecting. I was flummoxed at first, and all my collaborators were like: what is going on? We really had to scratch our heads and it took us a while to actually figure out an explanation.”

“We hatched a theory of what might be causing the changing shadows,” added Rebecca Nealon, a member of the science team at the University of Warwick in the United Kingdom. “But to test this we had to run sophisticated models where we varied the number of discs and their orientations to try to reproduce Hubble’s observations.”

The best solution the team came up with is that there are two misaligned discs casting shadows. They were so close to each other in the earlier observation they were missed. Over time they’ve now separated and split into two shadows. “We’ve never really seen this before on a protoplanetary disc. It makes the system much more complex than we originally thought,” said Debes.

The simplest explanation is that the misaligned discs are likely caused by the gravitational pull of two planets in slightly different orbital planes. Hubble is piecing together a holistic view of the architecture of the system.

The discs may be proxies for planets that are lapping each other as they whirl around the star. It’s sort of like spinning two vinyl records at slightly different speeds. Sometimes the labels will match up but then one gets ahead of the other.

“It does suggest that the two planets have to be fairly close to each other. If one was moving much faster than the other, this would have been noticed in earlier observations. It’s like two racing cars that are close to each other, but one slowly overtakes and laps the other,” said Debes.

The suspected planets are located in a region roughly the distance of Jupiter from our Sun. And the shadows complete one rotation around the star about every 15 years — the orbital period that would be expected at that distance from the star.

Also, these two inner discs are inclined by about five to seven degrees relative to the plane of the outer disc. This is comparable to the range of orbital inclinations inside our Solar System. “This is right in line with typical Solar System-style architecture,” said Debes.

The outer disc that the shadows are falling on may extend as far as several times the radius of our Solar System’s Kuiper belt. This larger disc has a curious gap at twice Pluto’s average distance from the Sun. This might be evidence for a third planet in the system.

Any inner planets would be difficult to detect because their light would be lost in the glare of the star. Also, dust in the system would dim their reflected light. ESA’s Gaia space observatory may be able to measure a wobble in the star if Jupiter-mass planets are tugging on it, but this would take years given the long orbital periods.

The TW Hydrae data are from Hubble’s Space Telescope Imaging Spectrograph. The NASA/ESA/CSA James Webb Space Telescope’s infrared vision may also be able to show the shadows in more detail.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.
Image credit: NASA. ESA, L. Hustak (STScI)

Resource:(https://esahubble.org/news/heic2305/)
Contacts
John Debes
AURA/STScI for the European Space Agency
Space Telescope Science Institute, Baltimore, Maryland
Email: debes@stsci.edu

Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2403a.jpg',
              title: 'Hubble finds water vapour in small exoplanet’s atmosphere',
              description:
              '''Astronomers using the NASA/ESA Hubble Space Telescope observed the smallest exoplanet where water vapour has been detected in its atmosphere. At only approximately twice Earth’s diameter, the planet GJ 9827d could be an example of potential planets with water-rich atmospheres elsewhere in our galaxy.

“This would be the first time that we can directly show through an atmospheric detection that these planets with water-rich atmospheres can actually exist around other stars,” said team member Björn Benneke of the Université de Montréal. “This is an important step toward determining the prevalence and diversity of atmospheres on rocky planets."

However, it remains too early to tell whether Hubble spectroscopically measured a small amount of water vapour in a puffy hydrogen-rich atmosphere, or if the planet’s atmosphere is mostly made of water, left behind after a primaeval hydrogen/helium atmosphere evapourated under stellar radiation.

“Our observing programme was designed specifically with the goal of not only detecting the molecules in the planet’s atmosphere, but of actually looking specifically for water vapour. Either result would be exciting, whether water vapour is dominant or just a tiny species in a hydrogen-dominant atmosphere,” said the science paper’s lead author, Pierre-Alexis Roy of the Université de Montréal.

“Until now, we had not been able to directly detect the atmosphere of such a small planet. And we’re slowly getting into this regime now,” added Benneke. “At some point, as we study smaller planets, there must be a transition where there’s no more hydrogen on these small worlds, and they have atmospheres more like Venus (which is dominated by carbon dioxide)."

Because the planet is as hot as Venus at roughly 425 degrees Celcius, it definitely would be an inhospitable, steamy world if the atmosphere were predominantly water vapour.

At present the team is left with two possibilities. The planet is still clinging to a hydrogen-rich envelope laced with water, making it a mini-Neptune. Alternatively, it could be a warmer version of Jupiter’s moon Europa, which has twice as much water as Earth beneath its crust. “The planet GJ 9827d could be half water, half rock. And there would be a lot of water vapour on top of some smaller rocky body,” said Benneke.

If the planet has a residual water-rich atmosphere, then it must have formed farther away from its host star, where the temperature is cold and water is available in the form of ice, than its present location. In this scenario, the planet would have then migrated closer to the star and received more radiation. The hydrogen was then heated and escaped, or is still in the process of escaping, the planet’s weak gravity. The alternative theory is that the planet formed close to the hot star, with a trace of water in its atmosphere.

The Hubble programme observed the planet during 11 transits — events in which the planet crossed in front of its star — that were spaced out over three years. During transits, starlight is filtered through the planet’s atmosphere and carries the spectral fingerprint of water molecules. If there are clouds on the planet, they are low enough in the atmosphere that they don’t completely hide Hubble’s view of the atmosphere, and Hubble is able to probe water vapour above the clouds.

Hubble’s discovery opens the door to studying the planet in more detail. It’s a good target for the NASA/ESA/CSA James Webb Space Telescope to do infrared spectroscopy to look for other atmospheric molecules.

GJ 9827d was discovered by NASA’s Kepler Space Telescope in 2017. It completes an orbit around a red dwarf star every 6.2 days. The star, GJ 9827, lies 97 light-years from Earth in the constellation Pisces.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

Image credit: NASA, ESA, Leah Hustak and Ralf Crawford (STScI)
Research(https://esahubble.org/news/heic2403/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2405a.jpg',
              title: 'Hubble finds that ageing brown dwarfs grow lonely',
              description:
              '''It takes two to tango, but in the case of brown dwarfs that were once paired as binary systems, that relationship doesn’t last for very long, according to a recent survey using the NASA/ESA Hubble Space Telescope.

Brown dwarfs are interstellar objects larger than Jupiter but smaller than the lowest-mass stars. Like stars, they collapse out of a cloud of gas and dust but do not have enough mass to sustain the fusion of hydrogen like a normal star. 

Like stars, brown dwarfs can be born in pairs and orbit about each other. A Hubble Space Telescope survey has found that the older a brown dwarf is, the less likely it is to have a companion dwarf. This implies that a binary pair of dwarfs is so weakly linked by gravity that they drift apart over a few hundred million years as a result of the pull of bypassing stars. Call them the lonely hearts of the cosmos.

Hubble can detect binaries as close to each other as 480 million kilometres — the approximate separation between our Sun and the asteroid belt. But the astronomers who carried out the survey didn’t find any binary pairs in a sample of brown dwarfs in the solar neighbourhood. “Our survey confirms that widely separated companions are extremely rare among the lowest-mass and coldest isolated brown dwarfs, even though binary brown dwarfs are observed at younger ages. This suggests that such systems do not survive over time,” said lead author Clémence Fontanive of the Trottier Institute for Research on Exoplanets, Université de Montréal, Canada.

In a similar survey Fontanive conducted a couple of years ago, Hubble looked at extremely young brown dwarfs and some had binary companions, confirming that star-forming mechanisms do produce binary pairs among low-mass brown dwarfs. The lack of binary companions for older brown dwarfs suggests that some may have started out as binaries, but parted ways over time.

The new Hubble findings further support the theory that brown dwarfs are born the same way as stars, through the gravitational collapse of a cloud of molecular hydrogen. The difference is that they do not have enough mass to sustain nuclear fusion of hydrogen for generating energy, whereas stars do. More than half of the stars in our galaxy have a companion star that resulted from these formation processes, with more massive stars more commonly found in binary systems. “The motivation for the study was really to see how low in mass the trends seen among multiple star systems hold up,” said Fontanive.

“Our Hubble survey offers direct evidence that these binaries that we observe when they’re young are unlikely to survive to old ages, they’re likely going to get disrupted. When they’re young, they’re part of a molecular cloud, and then as they age the cloud disperses. As that happens, things start moving around and stars pass by each other. Because brown dwarfs are so light, the gravitational hold tying wide binary pairs is very weak, and bypassing stars can easily tear these binaries apart,” said Fontanive.

The team selected a sample of brown dwarfs previously identified by NASA’s Wide-Field Infrared Survey Explorer. It sampled some of the coldest and lowest-mass old brown dwarfs in the solar neighbourhood. These old brown dwarfs are so cool (a few hundred degrees warmer than Jupiter in most cases) that their atmospheres contain water vapour that condensed out.

To find the coolest companions, the team used two different near-infrared filters, one in which cold brown dwarfs are bright, and another covering specific wavelengths where they appear very faint as a result of water absorption in their atmospheres.

“Most stars have friends – whether that is a binary companion or exoplanets,” added team member Beth Biller of the University of Edinburgh in the United Kingdom. “This survey really demonstrates that the same is not true for brown dwarfs. After a brief period early in their lifespans, most brown dwarfs remain single for the rest of their very long existence.”

“This is the best observational evidence to date that brown dwarf pairs drift apart over time,” said Fontanive. “We could not have done this kind of survey and confirmed earlier models without Hubble’s sharp vision and sensitivity.”

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

Image credit: NASA, ESA, J. Olmsted (STScI)
Research(https://esahubble.org/news/heic2405/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2402a.jpg',
              title: 'Hubble finds weird home of farthest fast radio burst',
              description:
              '''A Fast Radio Burst (FRB) is a fleeting blast of energy that can – for a few milliseconds – outshine an entire galaxy. Over the past few years hundreds of FRBs have been detected. They pop off all over the sky like camera flashes at a stadium event, but the sources behind these intense bursts of radiation remain uncertain.

This FRB is particularly weird because it erupted halfway across the Universe, making it the farthest and most powerful one detected to date.

And if that’s not strange enough, it just got weirder based on the follow-up Hubble observations after its discovery. The FRB flashed in what seems like an unlikely place, a collection of galaxies that existed when the Universe was only 5 billion years old. Previous FRBs have been found in isolated galaxies.

FRB 20220610A was first detected on 10 June 2022 by the Australian Square Kilometre Array Pathfinder (ASKAP) radio telescope in Western Australia, and confirmed to come from a distant origin by the European Southern Observatory’s Very Large Telescope in Chile. It is four times more energetic than closer FRBs. This might challenge models of what is producing FRBs. Or could it be a selection effect where only very bright FRBs can be detected halfway across the Universe?

“It required Hubble’s keen sharpness and sensitivity to pinpoint exactly where the FRB came from,” said lead author Alexa Gordon of Northwestern University in Evanston, Illinois. “Without Hubble’s imaging, it would still remain a mystery as to whether this was originating from one monolithic galaxy or from some type of interacting system. It’s these types of environments – these weird ones – that are driving us toward better understanding the mystery of FRBs.”

Hubble’s crisp images suggest there may be as many as seven galaxies on a possible path to merging, which would also be very significant, say researchers. Such groups of galaxies are rare, and it’s possible this led to the conditions that triggered the FRB.

“We are ultimately trying to answer the questions: What causes them? What are their progenitors and what are their origins? The Hubble observations provide a spectacular view of the surprising types of environments that give rise to these mysterious events,” said co-investigator Wen-fai Fong, also of Northwestern University.

Though astronomers do not have a consensus on the possible mechanism behind this extraordinary phenomenon, it’s generally thought that FRBs must involve some sort of compact object, like a black hole or neutron star. One extreme type of neutron star is called a magnetar – the most intensely magnetic type of neutron star in the Universe. It has a magnetic field that is so strong that, if a magnetar were located halfway between Earth and the Moon, it would erase the magnetic strip on everyone’s credit card in the world. Much worse yet, if an astronaut travelled within a few hundred kilometres of the magnetar, they would effectively be dissolved, because every atom in their body would be disrupted.

Possible mechanisms involve some kind of jarring starquake, or alternatively, an explosion caused when a magnetar’s twisting magnetic field lines snap and reconnect. A similar phenomenon happens on the Sun, causing solar flares, but a magnetar’s field is a trillion times stronger than the Sun’s magnetosphere. The snapping would generate an FRB’s flash, or might make a shock wave that incinerates surrounding dust and heats gas into a plasma.

There could be several flavours of magnetars. In one case, it could be an exploding object orbiting a black hole surrounded by a disk of material. Another alternative is a pair of orbiting neutron stars whose magnetospheres periodically interact, creating a cavity where eruptions can take place. It’s estimated that magnetars are active for about 10,000 years before settling down, so they would be expected to be found where a firestorm of star birth is taking place. But this doesn’t seem to be the case for all magnetars.

In the near future, FRB experiments will increase their sensitivity, leading to an unprecedented rate in the number of FRBs detected at these distances. Hubble will play a crucial role in characterising the environments in which these FRBs occur. Astronomers will soon learn just how special the environment of this FRB was.

“We just need to keep finding more of these FRBs, both nearby and far away, and in all these different types of environments,” said Gordon.

The results are being presented at the 243rd meeting of the American Astronomical Society in New Orleans, Louisiana.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

Image credit: NASA, ESA, STScI, Alexa Gordon (Northwestern University)

Research:(https://esahubble.org/news/heic2402/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2401a.jpg',
              title: 'Hubble observes a changing exoplanet atmosphere',
              description:
              '''An international team of astronomers has assembled and reprocessed observations of the exoplanet WASP-121 b that were collected with the NASA/ESA Hubble Space Telescope in the years 2016, 2018 and 2019. This provided them with a unique dataset that allowed them not only to analyse the atmosphere of WASP 121 b, but also to compare the state of the exoplanet’s atmosphere across several years. They found clear evidence that the observations of WASP-121 b were varying in time. The team then used sophisticated modelling techniques to demonstrate that these temporal variations could be explained by weather patterns in the exoplanet's atmosphere.

Observing exoplanets — planets beyond our Solar System — is challenging, because of both their distance from Earth and the fact that they mostly orbit stars that are far bigger and brighter than the planets are. This means that astronomers who have been able to observe an exoplanet with a telescope as sophisticated as Hubble typically have to combine all their data in order to get enough information to make confident deductions about the exoplanet’s properties. By combining the observations to increase the strength of the exoplanet signal, astronomers can construct an averaged picture of its atmosphere, but this does not tell them whether it is changing. In other words, they cannot study the weather on other worlds using this averaging method. Studying weather requires far more data of high quality, taken over a wider period of time. Fortunately, Hubble has now been active for such an impressive length of time that a vast archive of Hubble data exists, sometimes with multiple sets of observations of the same celestial object — and that includes the exoplanet WASP-121 b.

WASP-121 b (also known as Tylos) is a well-studied hot Jupiter [1] that orbits a star that lies about 880 light-years from Earth, completing a full orbit in a very brisk 30-hour period. Its extremely close proximity to its host star means that it is tidally locked [2], and that the star-facing hemisphere is very hot, with temperatures exceeding 3000 Kelvins [3]. The team combined four sets of archival observations of WASP-121 b, all made using Hubble’s Wide Field Camera 3 (WFC 3). The complete assembled dataset included observations of: WASP-121 b transiting in front of its star (taken in June 2016); WASP-121 b transiting behind its star, also known as a secondary eclipse (taken in November 2016); and two phase-curves [4] of WASP-121 b (taken in March 2018 and February 2019 respectively). The team took the unique step of processing each dataset in the same way, even if it had been previously processed by a different team. Exoplanet data processing is time consuming and complicated, but nonetheless it was worth it because it allowed the team to directly compare the processed data from each set of observations with one another. One of the principal investigators of the team, Quentin Changeat, an ESA Research Fellow at the Space Telescope Science Institute, elaborates:

“Our dataset represents a significant amount of observing time for a single planet and is currently the only consistent set of such repeated observations. The information that we extracted from those observations was used to characterise (infer the chemistry, temperature, and clouds) of the atmosphere of WASP-121 b at different times. This provided us with an exquisite picture of the planet, changing in time.”

After cleaning each dataset, the team found clear evidence that the observations of WASP-121 b were varying in time. While instrumental effects could remain, the data showed an apparent shift in the exoplanet’s hot spot [5] and differences in spectral signature (which signifies the chemical composition of the exoplanet’s atmosphere) indicative of a changing atmosphere. Next, the team used highly sophisticated computational models to attempt to understand observed behaviour of the exoplanet’s atmosphere. The models indicated that their results could be explained by quasi-periodic weather patterns, specifically massive cyclones that are repeatedly created and destroyed as a result of the huge temperature difference between the star-facing and dark side of the exoplanet. This result represents a significant step forward in potentially observing weather patterns on exoplanets. 

“The high resolution of our exoplanet atmosphere simulations allows us to accurately model the weather on ultra-hot planets like WASP-121 b,” explained Jack Skinner, a postdoctoral fellow at the California Institute of Technology and co-leader of this study. “Here we make a significant step forward by combining observational constraints with atmosphere simulations to understand the time-varying weather on these planets.”

“Weather on Earth is responsible for many aspects of our life, and in fact the long-term stability of Earth’s climate and its weather is likely the reason why life could emerge in the first place,” added Changeat. “Studying exoplanets’ weather is vital to understanding the complexity of exoplanet atmospheres, especially in our search for exoplanets with habitable conditions.”

Future observations with Hubble and other powerful telescopes, including Webb, will provide greater insight into weather patterns on distant worlds: and ultimately, possibly to finding exoplanets with stable long-term climates and weather patterns.

Notes
[1] Hot Jupiters are a type of exoplanet with no direct Solar System analogue: they are inflated gas giants that orbit very close to their parent stars, often performing a complete orbit in a matter of a few days. 

[2] Tidal locking refers to the situation where an orbiting body always presents the same hemisphere to the object that it orbits. For example, the Moon is tidally locked to Earth, which explains why the surface of the Moon always looks the same from our perspective here on Earth. In some cases, the two bodies might be tidally locked to one another, although this is not the case for the Moon and Earth: from the perspective of an astronaut on the Moon, Earth still appears to rotate on its own axis. Tidally locked planets will have an extremely uneven temperature distribution across their entire surface, with the star-facing hemisphere much hotter than the other.

[3] Kelvins (K) are the unit of temperature typically used by many scientists, including astronomers. Kelvins are the same in size as degrees Celsius (℃), however, the Kelvin scale is offset from the Celsius scale, which is set to zero at the freezing point of water at one atmosphere of pressure. In contrast, zero on the Kelvin scale is known as absolute zero, and is thought to be the lowest temperature possible, where all kinetic activity of all molecules ceases. 0 K is equivalent to –273.15 ℃. 

[4] Exoplanet phase curves show the varying amount of light received from a star-exoplanet system as the exoplanet orbits its parent star. 

[5] Exoplanet hot spots are, as the name suggests, the hottest spots on the exoplanet’s surface. Whilst it would be intuitive to suppose that the hotspot will always be at the point on the planet closest to the star, in fact many studies have shown that exoplanet hotspots are frequently offset. This may be due to wind or other atmospheric patterns on the exoplanets themselves.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.

The international team of astronomers in this study consists of: Q. Changeat (European Space Agency [ESA]; Space Telescope Science Institute [STScI], USA, & Department of Physics and Astronomy, University College London, UK [UCL]), J. W. Skinner (California Institute of Technology, USA & Martin A. Fisher School of Physics, Brandeis University, USA), J. Y-K. Cho (Center for Computational Astrophysics, Flatiron Institute, USA [Flatiron] & Martin A. Fisher School of Physics, Brandeis University, USA), J. Nättilä (Flatiron & Physics Department and Columbia Astrophysics Laboratory, Columbia University, USA), I. P. Waldmann (UCL), A. F. Al-Refaie (UCL), A. Dyrek (AIM, CEA, CNRS, Université Paris-Saclay, France), B. Edwards (SRON, Netherlands Institute for Space Research, the Netherlands & UCL), T. Mikal-Evans (Max Planck Institute for Astronomy, Heidelberg, Germany), M. Joshua (Blue Skies Space Ltd., UK), G. Morello (Department of Space, Earth and Environment, Chalmers University of Technology, Sweden & Instituto de Astrofisica de Canarias, Spain), N. Skaf, University of California, Santa Cruz, A. Tsiaras (UCL), O. Venot (Univ de Paris Cite and Univ Paris Est Creteil, CNRS, LISA, France), K. H. Yip (UCL).

Image credit: NASA, ESA, Q. Changeat et al., M. Zamani (ESA/Hubble)

Research:(https://esahubble.org/news/heic2401/)
Contacts
Dr. Quentin Changeat
ESA Research Fellow at STScI
Email: Email: qchangeat@stsci.edu

Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: E-mail: Bethany.Downer@esahubble.org''',
            ),
            NewsCard(
              imgUrl: 'https://cdn.esahubble.org/archives/images/newsfeature/heic2307a.jpg',
              title: 'Hubble sees boulders escaping from asteroid Dimorphos',
              description:
              '''Astronomers using the NASA/ESA/ Hubble Space Telescope’s extraordinary sensitivity have discovered a swarm of boulders that were possibly shaken off the asteroid Dimorphos when NASA deliberately slammed the half-tonne DART impactor spacecraft into Dimorphos at approximately 22 500 kilometres per hour. DART intentionally impacted Dimorphos on 26 September 2022, slightly changing the trajectory of its orbit around the larger asteroid Didymos.

The 37 ejected boulders range in size from 1 metre to 6.7 metres across, based on Hubble photometry. They are drifting away from the asteroid at around one kilometre per hour. The total mass in these detected boulders is about 0.1% the mass of Dimorphos. The boulders are some of the faintest objects ever imaged in the Solar System.

This opens up a new dimension for studying the aftermath of the DART experiment using the European Space Agency’s upcoming Hera mission, which is due to launch in 2024. The spacecraft will perform a detailed post-impact survey of the target asteroid Dimorphos. Hera will turn the grand-scale experiment into a well-understood and repeatable planetary defence technique that might one day be used for real [1].

The boulders are most likely not shattered pieces of the diminutive asteroid caused by the impact. They were already scattered across the asteroid’s surface, as evident in the last close-up picture taken by the DART spacecraft just two seconds before collision, when it was only 11 kilometres above the surface.

The science team that observed these boulders with Hubble estimates that the impact shook off two percent of the boulders on the asteroid’s surface. While the boulder observations by Hubble also give an estimate for the size of the DART impact crater, Hera will eventually determine the actual crater size.

Long ago, Dimorphos may have formed from material shed into space by the larger asteroid Didymos. The parent body may have spun up too quickly or could have lost material after a glancing collision with another object, among other scenarios. The ejected material formed a ring that gravitationally coalesced to form Dimorphos. This would make it a flying rubble pile of rocky debris loosely held together by the relatively weak pull of its gravity. Therefore, the interior is probably not solid, but has a structure more like a bunch of grapes.

It’s not clear how the boulders were lifted off the asteroid’s surface. They could be part of an ejecta plume that was photographed by Hubble and other observatories. Or a seismic wave from the impact may have rattled through the asteroid — like hitting a bell with a hammer — shaking loose the surface rubble.

The DART and LICIACube (Light Italian CubeSat for Imaging of Asteroids) teams have also been studying boulders detected in images taken by LICIACube’s LUKE (LICIACube Unit Key Explorer) camera in the minutes immediately following DART's kinetic impact.

Notes
[1] Just like Hubble and the NASA/ESA/CSA James Webb Space Telescope, NASA’s DART and ESA’s Hera missions are great examples of what international collaboration can achieve; the two missions are supported by the same teams of scientists and astronomers, and operate via an international collaboration called AIDA — the Asteroid Impact and Deflection Assessment.

NASA and ESA worked together in the early 2000s to develop asteroid monitoring systems, but recognised there was a missing link in the chain between asteroid threat identification and ways of addressing that threat. In response NASA oversaw the DART mission while ESA developed the Hera mission to gather additional data on DART’s impact. With the Hera mission, ESA is assuming even greater responsibility for protecting our planet and ensuring that Europe plays a leading role in the common effort to tackle asteroid risks. As Europe’s flagship planetary defender, Hera is supported through the Agency’s Space Safety programme, part of the Operations Directorate.

More information
The Hubble Space Telescope is a project of international cooperation between ESA and NASA.
Image credit: NASA, ESA, D. Jewitt (UCLA)

Research:(https://esahubble.org/news/heic2307/)
Contacts
Bethany Downer
ESA/Hubble Chief Science Communications Officer
Email: Bethany.Downer@esahubble.org''',
            ),
          ],
        ),
      ),
    );
  }
}



class NewsDetailPage extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;

  NewsDetailPage({
    required this.imgUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class NewsCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;

  NewsCard({
    required this.imgUrl,
    required this.title,
    required this.description,
  });




  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imgUrl),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AutoSizeText(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 2, // Set the maximum number of lines
              minFontSize: 12, // Minimum font size to shrink to
              overflow: TextOverflow.ellipsis, // Handle text overflow with ellipsis
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(
                    imgUrl: imgUrl,
                    title: title,
                    description: description,
                  ),
                ),
              );
            },
            child: Text('Read More', style: TextStyle(color: Colors.purple)),
          ),
        ],
      ),
    );
  }
}


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _newsUpdatesEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // SharedPreferences'ten ayarları yükleme
  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _newsUpdatesEnabled = prefs.getBool('newsUpdatesEnabled') ?? false;
    });
  }

  // SharedPreferences'e ayarları kaydetme
  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
    prefs.setBool('newsUpdatesEnabled', _newsUpdatesEnabled);
  }

  // Bildirimleri açma/kapama
  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
    _saveSettings(); // Ayarları kaydet
  }

  // Haber güncellemelerini açma/kapama
  void _toggleNewsUpdates(bool value) {
    setState(() {
      _newsUpdatesEnabled = value;
    });
    _saveSettings(); // Ayarları kaydet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileSection(),
            Divider(color: Colors.grey),

            // Notifications Section
            _buildNotificationSection(),
            Divider(color: Colors.grey),

            // Theme Section
            _buildThemeSection(),
            Divider(color: Colors.grey),

            // Account & Privacy Section
            _buildAccountSection(),
            Divider(color: Colors.grey),

            // About Section
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  // Profile Section Widget
// Profile Section Widget
  Widget _buildProfileSection() {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/ss1.png'),
            radius: 30,
          ),
          title: Text(
            'Alper GEZERAVCI',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
          onTap: () {
            // Profil düzenleme sayfasına yönlendirme kodu buraya
          },
        ),
        // Discussion Bölmesi

      ],
    );
  }


  // Notifications Section Widget
  Widget _buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SwitchListTile(
          title: Text(
            'Enable Notifications',
            style: TextStyle(color: Colors.white),
          ),
          value: _notificationsEnabled,
          activeColor: Colors.deepPurpleAccent,
          onChanged: _toggleNotifications, // Bildirim ayarı değiştirildiğinde
        ),
        SwitchListTile(
          title: Text(
            'Receive News Updates',
            style: TextStyle(color: Colors.white),
          ),
          value: _newsUpdatesEnabled,
          activeColor: Colors.deepPurpleAccent,
          onChanged: _toggleNewsUpdates, // Haber güncelleme ayarı değiştirildiğinde
        ),
      ],
    );
  }

  // Theme Section Widget
  Widget _buildThemeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          title: Text(
            'Dark Theme',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.brightness_2, color: Colors.white),
          onTap: () {
            // Tema değiştirme kodu buraya
          },
        ),
        ListTile(
          title: Text(
            'Light Theme',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.brightness_7, color: Colors.white),
          onTap: () {
            // Tema değiştirme kodu buraya
          },
        ),
      ],
    );
  }



  // Account & Privacy Section Widget
  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account & Privacy',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.lock_outline, color: Colors.white),
          onTap: () {
            // Şifre değiştirme sayfasına yönlendirme kodu buraya
          },
        ),
        ListTile(
          title: Text(
            'Privacy Settings',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.security, color: Colors.white),
          onTap: () {
            // Gizlilik ayarları sayfasına yönlendirme kodu buraya
          },
        ),
      ],
    );
  }



  // About Section Widget
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        ListTile(
          title: Text(
            'Version 1.0.0',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ListTile(
          title: Text(
            'Terms & Conditions',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.info_outline, color: Colors.white),
          onTap: () {
            // Şartlar ve koşullar sayfasına yönlendirme kodu buraya
          },
        ),
      ],
    );
  }
}


