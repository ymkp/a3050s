import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'app_state.dart';
part 'app_cubit.freezed.dart';

@lazySingleton
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState(pageIndex: 1));

  void changePageIndex({required int index}) {
    emit(
      state.copyWith(
        pageIndex: index,
      ),
    );
  }
}
