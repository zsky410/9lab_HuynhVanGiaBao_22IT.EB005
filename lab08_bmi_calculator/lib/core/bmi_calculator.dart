class BmiCalculator {
  BmiCalculator({required this.heightCm, required this.weightKg});

  final int heightCm;
  final int weightKg;

  double calculateBmi() {
    final double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  String getResultText() {
    final double bmi = calculateBmi();
    if (bmi >= 25) return 'Thừa cân';
    if (bmi >= 18.5) return 'Bình thường';
    return 'Thiếu cân';
  }

  String getInterpretation() {
    final double bmi = calculateBmi();
    if (bmi >= 25) {
      return 'Bạn nên tập luyện đều và điều chỉnh ăn uống để giảm chỉ số BMI.';
    }
    if (bmi >= 18.5) {
      return 'Tuyệt vời! Chỉ số BMI của bạn đang ở mức tốt.';
    }
    return 'Bạn nên bổ sung dinh dưỡng hợp lý để cải thiện cân nặng.';
  }
}
