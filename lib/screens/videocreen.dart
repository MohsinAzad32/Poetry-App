import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;
  final PageController pageController = PageController();

  final videos = [
    'assets/one.mp4',
    'assets/two.mp4',
    'assets/three.mp4',
    'assets/four.mp4',
    'assets/five.mp4',
    'assets/six.mp4',
    'assets/seven.mp4',
    'assets/eight.mp4',
    'assets/nine.mp4',
    'assets/ten.mp4',
  ];

  void initializeVideoPlayer(int index) {
    controller = VideoPlayerController.asset(videos[index])
      ..initialize().then((_) {
        setState(() {});
        controller.play();

        // Listen for video completion to restart the video
        controller.addListener(() {
          if (controller.value.position == controller.value.duration) {
            controller.seekTo(Duration.zero);
            controller.play();
          }
        });
      });
  }

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(0); // Start with the first video

    // Listen to page changes
    pageController.addListener(() {
      int nextIndex = pageController.page!.round();
      if (nextIndex != videos.indexOf(controller.dataSource)) {
        controller.pause();
        controller.dispose(); // Dispose the current controller
        initializeVideoPlayer(nextIndex); // Initialize the new video
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose(); // Dispose the PageController as well
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Reels',
          style: TextStyle(
            fontFamily: 'DancingScript',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: controller.value.isInitialized
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      });
                    },
                    child: Stack(
                      children: [
                        VideoPlayer(
                          controller,
                          key: UniqueKey(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // Get the current video path
                                    String videoUrl = controller.dataSource;

                                    // Save the video to a temporary directory
                                    final tempDir =
                                        await getTemporaryDirectory();
                                    final filePath =
                                        '${tempDir.path}/my_video.mp4';

                                    try {
                                      // Load video as bytes from assets (or another source)
                                      final byteData =
                                          await rootBundle.load(videoUrl);
                                      final buffer =
                                          byteData.buffer.asUint8List();
                                      final file = File(filePath);
                                      await file.writeAsBytes(buffer);

                                      // Share the video file
                                      await Share.shareXFiles([XFile(filePath)],
                                          text:
                                              'Check out this awesome video!');
                                    } catch (e) {
                                      // Handle errors
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Error sharing the video!'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      print(e);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.share_rounded,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 50,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  downloadVideo(BuildContext context) async {
    try {
      // Get the temporary directory to store the video
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/downloaded_video.mp4';
      String videoUrl = controller.dataSource; // Ensure this URL is correct

      print('Downloading video from: $videoUrl');

      // Download the video using Dio
      await Dio().download(
        videoUrl,
        filePath,
      );

      // Save the video to the gallery
      final success = await GallerySaver.saveVideo(filePath);
      print('Video saved: $success');

      if (success != null && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video saved to gallery!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save video!'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e'); // Log the error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error downloading video!'),
        ),
      );
    }
  }
}
