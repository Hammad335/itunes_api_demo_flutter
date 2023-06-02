import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_audio_player/core/widgets/widgets.dart';
import 'package:itunes_audio_player/features/tracks_screen/controller/tracks_screen_controller.dart';
import '../../../constants/constants.dart';
import '../../../core/styles/text_styles.dart';

class TracksScreen extends StatelessWidget {
  static const String name = '/tracks-screen';

  TracksScreen({Key? key}) : super(key: key);

  final TracksScreenController _controller = Get.find<TracksScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              const HeaderText(),
              SearchTextField(),
              const SizedBox(height: 30),
              Obx(
                () => _controller.allMusicTracks.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _controller.allMusicTracks.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () =>
                                _controller.setCurrentIndexAndNavigate(index),
                            child: TrackWidget(
                              controller: _controller,
                              index: index,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            EMPTY_TRACKS_LIST_TEXT,
                            textAlign: TextAlign.center,
                            style: TextStyles.emptyListBodyTextStyle,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
