// ignore_for_file: prefer_null_aware_method_calls, prefer_single_quotes

import 'dart:math';

import 'package:a3050s/utils/constants.dart';
import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: $constants.palette.grey.withOpacity(0.5),
            inactiveTrackColor: $constants.palette.grey.withOpacity(0.2),
          ),
          child: ExcludeSemantics(
            child: Slider(
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                widget.bufferedPosition.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble(),
              ),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbColor: $constants.palette.white,
            thumbShape: const RoundSliderThumbShape(
              disabledThumbRadius: 0,
              enabledThumbRadius: 5,
            ),
            inactiveTrackColor: Colors.transparent,
            activeTrackColor: $constants.palette.white,
          ),
          child: Slider(
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(
              _dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble(),
            ),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          left: 16,
          bottom: 0,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("${widget.position}")
                    ?.group(1) ??
                '${widget.position}',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: $constants.palette.grey),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 0,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("$_remaining")
                    ?.group(1) ??
                '$_remaining',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

T? ambiguate<T>(T? value) => value;
