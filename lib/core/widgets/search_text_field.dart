import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_audio_player/features/tracks_screen/controller/tracks_screen_controller.dart';

class SearchTextField extends StatelessWidget {
  final TracksScreenController _controller = Get.find<TracksScreenController>();

  SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller.searchTextController,
      decoration: InputDecoration(
        hintText: 'Search tracks by artist name',
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        suffixIcon: Obx(
          () => _controller.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              : const Icon(Icons.search),
        ),
      ),
      // validator: Validator.validateInputText,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        _controller.fetchTracks();
      },
    );
  }
}
