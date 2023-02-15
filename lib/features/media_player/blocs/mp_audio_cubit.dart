import 'package:a3050s/features/app/models/media_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'mp_audio_state.dart';
part 'mp_audio_cubit.freezed.dart';

class MPAudioCubit extends Cubit<MPAudioState> {
  MPAudioCubit() : super(MPAudioState.init());
}
