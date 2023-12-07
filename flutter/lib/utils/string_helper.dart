class StringHelper {
  StringHelper._();

  static String fileSize(int size) {
    if (size < 1000) {
      return '$size B';
    }
    if (size < 1000 * 1000) {
      return '${(size / 1000).toStringAsFixed(2)} KB';
    }
    if (size < 1000 * 1000 * 1000) {
      return '${(size / (1000 * 1000)).toStringAsFixed(2)} MB';
    }

    return '${(size / (1000 * 1000 * 1000)).toStringAsFixed(2)} GB';
  }

  static String time(DateTime time, {bool hiddenDetail = false}) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff < const Duration(days: 1)) {
      if (time.day == now.day) {
        if (!hiddenDetail) {
          return '今天 ${time.hour.toString().padLeft(2, '0')}:'
              '${time.minute.toString().padLeft(2, '0')}:'
              '${time.second.toString().padLeft(2, '0')}';
        } else {
          return '${time.hour.toString().padLeft(2, '0')}:'
              '${time.minute.toString().padLeft(2, '0')}';
        }
      } else {
        if (!hiddenDetail) {
          return '昨天 ${time.hour.toString().padLeft(2, '0')}:'
              '${time.minute.toString().padLeft(2, '0')}:'
              '${time.second.toString().padLeft(2, '0')}';
        } else {
          return '昨天';
        }
      }
    }
    if (diff < const Duration(days: 30)) {
      if (!hiddenDetail) {
        return '${time.month}月${time.day}日 '
            '${time.hour.toString().padLeft(2, '0')}:'
            '${time.minute.toString().padLeft(2, '0')}:'
            '${time.second.toString().padLeft(2, '0')}';
      } else {
        return '${time.month}月${time.day}日';
      }
    }

    if (!hiddenDetail) {
      return '${time.year}年${time.month}月${time.day}日 '
          '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}:'
          '${time.second.toString().padLeft(2, '0')}';
    } else {
      return '${time.year}年${time.month}月${time.day}日';
    }
  }
}
