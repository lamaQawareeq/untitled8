import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<String> videoPaths;

  MenuItem(this.title, this.subtitle, this.imagePath, this.videoPaths);
}

class MyMenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(
      'Molokhiya',
      'Ingredients: garlic, Molokhiya leaves, oil',
      'lib/images/Molokhiya.jpg',
      ['lib/videos/is1.mp4', 'lib/videos/11.mp4'],
    ),
    MenuItem(
      'Kunafa',
      'Ingredients: cheese, Pistachios, Ghee',
      'lib/images/3.jpg',
      ['lib/videos/4.mp4', 'lib/videos/2.mp4'],
    ),
    MenuItem(
      'Falafel',
      'Ingredients: hummus, Bean, flour',
      'lib/images/5.jpg',
      ['lib/videos/6.mp4', 'lib/videos/7.mp4'],
    ),
  ];

  MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 35, color: Colors.white),
              onPressed: () {},
            ),
            const Text(
              'Famous Food',
              style: TextStyle(
                fontFamily: 'Philosopher',
                color: Colors.white,
                fontSize: 27,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chat, size: 30, color: Colors.white),
              onPressed: () {},
            ),
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
                  child: MenuItemWidget(menuItems[index]),
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


class MenuItemWidget extends StatefulWidget {
  final MenuItem item;

  const MenuItemWidget(this.item, {super.key});

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  bool _showComments = false;
  bool _showVideos = false;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _comments = [];

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
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(
                      widget.item.imagePath,
                      fit: BoxFit.cover,
                    ),
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
                        Text(
                          widget.item.subtitle,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showComments = !_showComments;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                _showComments
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: const Color.fromARGB(255, 170, 0, 113),
                              ),
                              const Text(
                                'Comments',
                                style: TextStyle(color: Colors.black),
                              ),
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
                              Icon(
                                _showVideos
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: const Color.fromARGB(255, 170, 0, 113),
                              ),
                              const Text(
                                'Videos',
                                style: TextStyle(color: Colors.black),
                              ),
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
            if (_showVideos) buildVideosSection(),
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
              title: Text(comment['text']),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _comments.remove(comment); // Remove the comment
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
                    border: Border.all(
                      color: const Color.fromARGB(255, 170, 0, 113),
                    ),
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
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 170, 0, 113),
                ),
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    setState(() {
                      _comments.add({'text': _commentController.text});
                      _commentController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildVideosSection() {
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
            color: const Color.fromARGB(255, 170, 0, 113),
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
