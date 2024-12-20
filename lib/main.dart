import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HLSPlayerPage(),
    );
  }
}

class HLSPlayerPage extends StatefulWidget {
  const HLSPlayerPage({super.key});

  @override
  State<HLSPlayerPage> createState() => _HLSPlayerPageState();
}

class _HLSPlayerPageState extends State<HLSPlayerPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.network(
        "https://lightning-traceurban-samsungau.amagi.tv/playlist.m3u8"
        // "https://cbtvnow.com:5866/hls/livest2024.m3u8"
        // "https://d1zx6l1dn8vaj5.cloudfront.net/out/v1/b89cc37caa6d418eb423cf092a2ef970/index.m3u8"
        // "https://playout172.livextend.cloud/liveiframe/_definst_/ngrp:liveartvabr_abr/playlist.m3u8"
        // "https://w1.manasat.com/ktv-angola/smil:ktv-angola.smil/playlist.m3u8"
        // "https://d1zx6l1dn8vaj5.cloudfront.net/out/v1/b89cc37caa6d418eb423cf092a2ef970/index.m3u8"
        // "https://stream.live.novotempo.com/tv/smil:tvnuevotiempo.smil/playlist.m3u8"
        // "https://stream.live.novotempo.com/tv/smil:tvnovotempo.smil/playlist.m3u8"
        // "https://service-stitcher.clusters.pluto.tv/stitch/hls/channel/5f12151794c1800007a8ae63/master.m3u8?advertisingId=&appName=web&appStoreUrl=&appVersion=DNT&app_name=&architecture=&buildVersion=&deviceDNT=0&deviceId=5f12151794c1800007a8ae63&deviceLat=-23.5475&deviceLon=-46.6361&deviceMake=web&deviceModel=web&deviceType=web&deviceVersion=DNT&includeExtendedEvents=false&marketingRegion=BR&serverSideAds=false&sid=730&terminate=false&userId="
        // "https://service-stitcher.clusters.pluto.tv/v1/stitch/embed/hls/channel/5f1212fb81e85c00077ae9ef/master.m3u8?advertisingId=channel&appName=rokuchannel&appVersion=1.0&bmodel=bm1&channel_id=channel&content=channel&content_rating=ROKU_ADS_CONTENT_RATING&content_type=livefeed&coppa=false&deviceDNT=1&deviceId=channel&deviceMake=rokuChannel&deviceModel=web&deviceType=rokuChannel&deviceVersion=1.0&embedPartner=rokuChannel&genre=ROKU_ADS_CONTENT_GENRE&is_lat=1&platform=web&rdid=channel&studio_id=viacom&tags=ROKU_CONTENT_TAGS",
        // "https://stmv1.srvstm.com/sistema7933/sistema7933/playlist.m3u8"
        // "https://5c483b9d1019c.streamlock.net/falalitoraltv/falalitoraltv/playlist.m3u8"
        // "https://stmv1.samcast.com.br/demaistv6503/demaistv6503/playlist.m3u8",
        // "https://cdn.jmvstream.com/w/LVW-8503/LVW8503_d0V5oduFlK/playlist.m3u8",
        // "https://ythls.armelin.one/channel/UCJElRTCNEmLemgirqvsW63Q.m3u8",
        // "https://30a-tv.com/feeds/vidaa/golf.m3u8",
        // "https://sgn-cdn-video.vods2africa.com/Tv-Zimbo/index.fmp4.m3u8"
        // "https://stream.ads.ottera.tv/playlist.m3u8?network_id=2116"
        // 'https://stream.ads.ottera.tv/playlist.m3u8?network_id=2116',
        );

    await _controller.initialize();
    _controller.setLooping(true);
    setState(() {
      _isPlaying = true;
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HLS Player'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlayPause,
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }
}
