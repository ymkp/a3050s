import 'package:a3050s/features/app/widgets/customs/custom_cached_image_container.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaExternalDialog extends StatelessWidget {
  const MediaExternalDialog({
    super.key,
    required this.artistName,
    required this.artworkUrl,
    required this.collectionName,
    required this.externalUrl,
    required this.trackName,
    required this.price,
  });

  final String artworkUrl;
  final String artistName;
  final String collectionName;
  final String trackName;
  final String externalUrl;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCachedImageContainer(
          imageURL: artworkUrl,
          width: 400,
          height: 400,
        ),
        Text(trackName),
        Wrap(
          spacing: 10,
          children: [Text(artistName), Text(collectionName)],
        ),
        Text(price),
        MaterialButton(
          onPressed: () async {
            final uri = Uri.file(externalUrl);
            if (!await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
              webOnlyWindowName: '_blank',
            )) {
              throw Exception('Could not open $uri');
            }
          },
          child: const Text('Get it on Apple Music'),
        )
      ],
    );
  }
}
