import 'package:flutter/material.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  List<Map<String, dynamic>> _discussions = []; // Tartışma listesi
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final List<TextEditingController> _replyControllers = []; // Her tartışma için yanıt controller'ı

  // Favori ve Kaydetme ikonlarının durumu
  void _addDiscussion(String topic, String name) {
    setState(() {
      _discussions.add({
        'topic': topic,
        'name': name,
        'isFavorite': false,
        'isSaved': false,
        'replies': [], // Yanıtlar için alan
      });
      _replyControllers.add(TextEditingController()); // Her yeni tartışma için yanıt controller'ı ekliyoruz
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      _discussions[index]['isFavorite'] = !_discussions[index]['isFavorite'];
    });
  }

  void _toggleSave(int index) {
    setState(() {
      _discussions[index]['isSaved'] = !_discussions[index]['isSaved'];
    });
  }

  // Cevap ekleme fonksiyonu (Guest account ile)
  void _addReply(int index, String reply) {
    setState(() {
      _discussions[index]['replies'].add({
        'reply': reply,
        'commentedBy': 'Guest Account', // Otomatik olarak Guest Account eklenir
      });
      _replyControllers[index].clear(); // Yanıt kutusunu temizle
    });
  }

  // Tartışma ekleme ekranı (Dialog)
  void _showAddDiscussionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Add New Discussion',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Resim ekleme kısmı
              Image.asset(
                'images/astro2.png', // Resminizin yolunu buraya ekleyin
                height: 100, // Resmin yüksekliği
                width: 100, // Resmin genişliği
                fit: BoxFit.cover, // Resmi kutuya sığdırma
              ),
              SizedBox(height: 20), // Resim ile diğer öğeler arasında boşluk bırakma

              TextField(
                controller: _topicController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Discussion Topic',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog'u kapat
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_topicController.text.isNotEmpty &&
                    _nameController.text.isNotEmpty) {
                  _addDiscussion(_topicController.text, _nameController.text);
                  _topicController.clear();
                  _nameController.clear();
                  Navigator.pop(context); // Tartışma eklendi, dialog'u kapat
                }
              },
              child: Text('Add'),
            ),
          ],
        );

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Discussion Page',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          // AppBar'ın sağ kısmına eklediğimiz düzenleme butonu
          TextButton.icon(
            onPressed: _showAddDiscussionDialog, // Tartışma ekleme diyalogunu açar
            icon: Icon(Icons.edit, color: Colors.white),
            label: Text(
              'Start Discussion',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _discussions.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              _discussions[index]['topic'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Started by: ${_discussions[index]['name']}',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          SizedBox(height: 10),

                          if (_discussions[index]['replies'].isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _discussions[index]['replies']
                                    .map<Widget>((reply) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reply['reply'],
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'Commented by: ${reply['commentedBy']}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyControllers[index],
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Add a reply',
                                    labelStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.grey[800],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              // Gönderme ikonu ile yuvarlak buton
                              IconButton(
                                icon: Icon(Icons.send),
                                color: Colors.deepPurpleAccent,
                                iconSize: 30,
                                onPressed: () {
                                  if (_replyControllers[index].text.isNotEmpty) {
                                    _addReply(
                                        index, _replyControllers[index].text);
                                  }
                                },
                                padding: EdgeInsets.all(0), // Kenar boşluklarını azalt
                                splashRadius: 30, // Splash boyutunu ayarla
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(
                                  _discussions[index]['isFavorite']
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _discussions[index]['isFavorite']
                                      ? Colors.red
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  _toggleFavorite(index);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  _discussions[index]['isSaved']
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: _discussions[index]['isSaved']
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  _toggleSave(index);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
