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
              controller: _searchCtrl,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                hintText: 'What do you want to listen to?',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchCtrl.clear();
                    context.read<MediaSearchCubit>().setStateToNone();
                  },
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
        ],
      ),
    );
  }
}
