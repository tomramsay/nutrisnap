/// Number formatting extensions.
extension NumExtensions on num {
  /// Format as compact number: 1200 → '1.2K'
  String toCompact() {
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
    return toStringAsFixed(0);
  }

  /// Format with 1 decimal place: 67.523 → '67.5'
  String to1dp() => toStringAsFixed(1);

  /// Format as percentage: 0.917 → '91.7%'
  String toPercent() => '${(this * 100).toStringAsFixed(1)}%';

  /// Format as integer with no decimals.
  String toInt0() => toStringAsFixed(0);

  /// Clamp to 0–1 range for progress indicators.
  double toProgress() => clamp(0.0, 1.0).toDouble();
}
