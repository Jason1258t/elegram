extension StringToEnum on String {
  T toEnum<T>(List<T> values) {
    return values.firstWhere((e) => e.toString().split('.')[1] == this);
  }
}
