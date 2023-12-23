enum BreakPoint {
  // 手机
  xs,
  // 平板
  md,
  // 桌面端
  lg,
  ;
}

class BreakPointHelper {
  BreakPointHelper._();

  static BreakPoint calculate(double width) {
    if (width > 992) {
      return BreakPoint.lg;
    }
    return BreakPoint.xs;
  }
}
