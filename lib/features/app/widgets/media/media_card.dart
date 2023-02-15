import 'package:a3050s/features/app/models/media_model.dart';
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  const MediaCard(this.media, {super.key});
  final MediaModel media;

  @override
  Widget build(BuildContext context) {
    return Text(media.artistName);
  }
}
