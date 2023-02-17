class StringHelper {
  StringHelper._();

  static String getDurationAsMinuteSeconds(Duration duration) {
    return RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
            .firstMatch('$duration')
            ?.group(1) ??
        '$duration';
  }
}
