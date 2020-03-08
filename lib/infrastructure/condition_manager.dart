class ConditionManager {
  final int minValue, maxValue;
  final int mean;

  ConditionManager(this.minValue, this.maxValue)
      : mean = (minValue + maxValue) ~/ 2;
}
