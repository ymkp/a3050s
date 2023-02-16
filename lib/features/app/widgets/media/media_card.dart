import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/features/app/widgets/customs/custom_cached_image_container.dart';
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.media,
    required this.onTap,
  });
  final MediaModel media;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CustomCachedImageContainer(imageURL: media.artworkUrl100 ?? ''),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.trackName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        if (media.trackExplicitness == 'explicit')
                          const Icon(
                            Icons.explicit,
                            size: 15,
                          ),
                        Text(
                          media.kind,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          media.artistName,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _getMediaTime(media.trackTimeMillis),
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getMediaTime(int? trackTimeMillis) {
    if (trackTimeMillis == null) return '';
    final time = Duration(milliseconds: trackTimeMillis);
    return '${time.inMinutes}:${time.inSeconds % 60}';
  }
}
