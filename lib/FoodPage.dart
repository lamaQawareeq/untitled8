import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MenuItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<String> videoPaths;
  final int foodId;

  MenuItem(this.title, this.subtitle, this.imagePath, this.videoPaths, this.foodId);
}

class MyMenuScreen extends StatelessWidget {
  final String email; // تعريف المتغير email

  MyMenuScreen({super.key, required this.email});
  
  final List<MenuItem> menuItems = [
    MenuItem('Molokhiya', 'Ingredients: garlic, Molokhiya leaves, oil', 'lib/images/Molokhiya.jpg', ['lib/videos/is1.mp4', 'lib/videos/11.mp4'], 11),
    MenuItem('Kunafa', 'Ingredients: cheese, Pistachios, Ghee', 'lib/images/3.jpg', ['lib/videos/4.mp4', 'lib/videos/2.mp4'], 6),
    MenuItem('Falafel', 'Ingredients: hummus, Bean, flour', 'lib/images/5.jpg', ['lib/videos/6.mp4', 'lib/videos/7.mp4'], 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 170, 0, 113),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: const Icon(Icons.home, size: 35, color: Colors.white), onPressed: () {}),
            const Text('Famous Food', style: TextStyle(fontFamily: 'Philosopher', color: Colors.white, fontSize: 27)),
            IconButton(icon: const Icon(Icons.chat, size: 30, color: Colors.white), onPressed: () {}),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MenuItemWidget(menuItems[index], email: email), // تمرير البريد الإلكتروني هنا
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<List<Comment>> fetchComments(int foodId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3001/auth/comments/$foodId'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((comment) => Comment.fromJson(comment)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}

Future<void> addComment(String email, int foodId, String comment) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3001/auth/comments/add'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'food_id': foodId, 'comment': comment}),
  );

  // تعديل هنا
  if (response.statusCode < 200 || response.statusCode >= 300) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to add comment');
  }
}
class Comment {
  final String text;
  final String firstName;
  final String lastName;
  final String imageUrl;

  Comment({required this.text, required this.firstName, required this.lastName, required this.imageUrl});

  factory Comment.fromJson(Map<String, dynamic> json) {
    String firstNameLower = json['first_name'].toLowerCase(); // تحويل الاسم الأول إلى حروف صغيرة
    String imageUrl;

    // تحديد صورة المستخدم بناءً على الاسم الأول
    switch (firstNameLower) {
      case 'lama' || 'Lama':
        imageUrl = 'lib/images/lama.jpeg';
        break;
      case 'wafaa'|| 'Wafaa':
        imageUrl = 'lib/images/Wafaa.jpeg';
        break;
      case 'awrtani'|| 'Awrtani':
        imageUrl = 'lib/images/Awrtani.jpeg';
        break;
      default:
        imageUrl = 'lib/images/defult.png'; // الصورة الافتراضية
    }

    return Comment(
      text: json['comment'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      imageUrl: imageUrl,
    );
  }
}


class MenuItemWidget extends StatefulWidget {
  final MenuItem item;
  final String email; // تعريف المتغير email

  const MenuItemWidget(this.item, {super.key, required this.email}); // تمرير البريد الإلكتروني من الواجهة السابقة

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  bool _showComments = false;
  bool _showVideos = false;
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(widget.item.imagePath, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      widget.item.title,
                      style: const TextStyle(
                        fontFamily: 'Philosopher',
                        fontSize: 18,
                        color: Color.fromARGB(255, 170, 0, 113),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.item.subtitle, style: const TextStyle(color: Colors.black)),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _showComments = !_showComments;
                            });
                            if (_showComments) {
                              List<Comment> fetchedComments = await fetchComments(widget.item.foodId);
                              setState(() {
                                _comments.clear();
                                _comments.addAll(fetchedComments);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(_showComments ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: const Color.fromARGB(255, 170, 0, 113)),
                              const Text('Comments', style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showVideos = !_showVideos;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(_showVideos ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: const Color.fromARGB(255, 170, 0, 113)),
                              const Text('Videos', style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showComments) buildCommentsSection(),
            if (_showVideos) buildVideosSection(context),
          ],
        ),
      ),
    );
  }

Widget buildCommentsSection() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._comments.map((comment) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(comment.imageUrl), // عرض الصورة الشخصية بشكل دائري
              radius: 20.0, // حجم الصورة
            ),
            title: Text('${comment.firstName} ${comment.lastName}'),
            subtitle: Text(comment.text),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _comments.remove(comment);
                });
              },
            ),
          );
        }),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color.fromARGB(255, 170, 0, 113)),
                ),
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
            ),
           IconButton(
  icon: const Icon(Icons.send, color: Color.fromARGB(255, 170, 0, 113)),
  onPressed: () async {
    if (_commentController.text.isNotEmpty) {
      await addComment(widget.email, widget.item.foodId, _commentController.text);
      setState(() {
        _comments.add(Comment(
          text: _commentController.text, 
          firstName: 'User', // يمكنك تعديل هذا وفقًا لاسم المستخدم الفعلي
          lastName: 'Name', 
          imageUrl: 'lib/images/defult.png', // استخدم الصورة الافتراضية أو الصورة المناسبة هنا
        ));
        _commentController.clear();
      });
    }
  },
)

          ],
        ),
      ],
    ),
  );
}

  Widget buildVideosSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...widget.item.videoPaths.map((videoPath) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: VideoPlayerWidget(videoPath: videoPath),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(_controller),
        ),
        IconButton(
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
        ),
      ],
    );
  }
}