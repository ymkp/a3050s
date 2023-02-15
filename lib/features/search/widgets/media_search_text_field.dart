import 'package:a3050s/features/search/blocs/media_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaSearchTextField extends StatefulWidget {
  const MediaSearchTextField({super.key});

  @override
  State<MediaSearchTextField> createState() => _MediaSearchTextFieldState();
}

class _MediaSearchTextFieldState extends State<MediaSearchTextField> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              key: const Key('__MediaSearchTextField__'),
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _searchCtrl.clear,
                ),
              ),
              textInputAction: TextInputAction.done,
              onEditingComplete: () async {
                if (_searchCtrl.text.isNotEmpty) {
                  await context
                      .read<MediaSearchCubit>()
                      .searchSong(_searchCtrl.text);
                  if (context.mounted) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                }
              },
            ),
          ),
          Expanded(
            child: IconButton(
              key: const Key('__searchButton__'),
              icon: const Icon(Icons.search),
              onPressed: () async {
                if (_searchCtrl.text.isNotEmpty) {
                  await context
                      .read<MediaSearchCubit>()
                      .searchSong(_searchCtrl.text);
                  if (context.mounted) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
