import 'package:flutter/material.dart';
import 'package:socialapp/src/models/video_model.dart';
import 'package:socialapp/src/widgets/video_post.dart';
import 'package:socialapp/src/widgets/video_tabs_details.dart';

class VideoTabs extends StatefulWidget {
  const VideoTabs({Key? key, required this.videoModel}) : super(key: key);
  final Video videoModel;

  @override
  State<VideoTabs> createState() => _VideoTabsState();
}

class _VideoTabsState extends State<VideoTabs>
    with SingleTickerProviderStateMixin {
  final List<Tab> _myTabs = <Tab>[
    const Tab(text: 'Detalles'),
    const Tab(text: 'Compartir'),
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        tabs: _myTabs,
        controller: _tabController,
      ),
      body: TabBarView(controller: _tabController, children: [
        VideoTabDetails(videoModel: widget.videoModel),
        
        
        VideoPost(videoModel: widget.videoModel)
      ]),
    );
  }
}
