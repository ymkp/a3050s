import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/features/app/widgets/customs/custom_cached_image_container.dart';
import 'package:a3050s/utils/constants.dart';
import 'package:a3050s/utils/helpers/string_helper.dart';
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.media,
    required this.onTap,
    this.isOnPlay = false,
    this.onRemoveTap,
  });
  final MediaModel media;
  final VoidCallback onTap;
  final bool isOnPlay;
  final VoidCallback? onRemoveTap;

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
                        // Text(
                        //   media.kind,
                        //   style: Theme.of(context).textTheme.labelMedium,
                        // ),
                        Text(
                          media.artistName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (onRemoveTap != null)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: $constants.palette.grey,
                  ),
                  onPressed: onRemoveTap,
                )
              else
                isOnPlay
                    ? Image.asset(
                        'assets/images/eq-small.gif',
                        height: 30,
                        width: 30,
                      )
                    : Text(
                        StringHelper.getDurationAsMinuteSeconds(
                          Duration(milliseconds: media.trackTimeMillis ?? 0),
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      )
            ],
          ),
        ),
      ),
    );
  }
}
