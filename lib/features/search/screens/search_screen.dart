import 'package:a3050s/features/search/widgets/media_search_result_container.dart';
import 'package:a3050s/features/search/widgets/media_search_text_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MediaSearchTextField(),
        Expanded(child: MediaSearchResultContainer())
      ],
    );
  }
}
