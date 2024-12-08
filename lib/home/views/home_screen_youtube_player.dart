import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miles_sample/common/common_widgets.dart';
import 'package:miles_sample/generated/assets.dart';
import 'package:miles_sample/home/models/HomeScreenModel.dart';
import 'package:miles_sample/story/models/story_model.dart';
import 'package:miles_sample/theme/font_properties.dart';
import 'package:miles_sample/utils/grid_background.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreenYoutubePlayer extends StatefulWidget {
  const HomeScreenYoutubePlayer(
      {super.key,
      required this.videoId,
      required this.postListData,
      required this.index});

  final String videoId;
  final List<HomeScreenDataPosts>? postListData;
  final int index;

  @override
  State<HomeScreenYoutubePlayer> createState() =>
      _HomeScreenYoutubePlayerState();
}

class _HomeScreenYoutubePlayerState extends State<HomeScreenYoutubePlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  bool isLikedLocal = false;
  bool isDeviceFullScreen = false;

  late String id;

  @override
  void initState() {
    super.initState();

    id = YoutubePlayer.convertUrlToId(widget.videoId ?? "")!;

    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: SizedBox(
          width: 300,
          child: Text(
            widget.postListData?[widget.index].title ?? "",
            maxLines: 5,
            style: FontProperties.headLineNormal.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          GridBackground(),
          Align(
            alignment: Alignment.center,
            child: YoutubePlayerBuilder(
                onExitFullScreen: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.portraitUp]);
                },
                onEnterFullScreen: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.landscapeLeft]);
                  _controller.play();
                },
                player: YoutubePlayer(
                  topActions: <Widget>[
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        _controller.metadata.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {
                        log('Settings Tapped!');
                      },
                    )
                  ],
                  controlsTimeOut: const Duration(seconds: 5),
                  width: double.infinity,
                  thumbnail: (widget.postListData?[widget.index].files?.first
                                  .thumbnail ??
                              "")
                          .isNotEmpty
                      ? Image.network(
                          loadingBuilder: (context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CommonWidgets.smallLoader();
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              CommonWidgets.smallLoader(),
                          fit: BoxFit.fitWidth,
                          widget.postListData?[widget.index].files?.first
                                  .thumbnail ??
                              "")
                      : SvgPicture.asset(Assets.iconsMilesLogo),
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  liveUIColor: Colors.red,
                  onReady: () {
                    _isPlayerReady = true;
                  },
                  onEnded: (data) {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                    Navigator.pop(context);
                  },
                ),
                builder: (context, player) => player),
          ),
        ],
      ),
    );
  }
}
