//---------------  Format text to first and last word as "John Doe Smith" to "JS"
String getInitials(String fullName) {
  if (fullName.trim().isEmpty) return '';

  List<String> words =
      fullName.trim().split(' ').where((word) => word.isNotEmpty).toList();

  if (words.isEmpty) return '';

  String firstInitial = words.first[0].toUpperCase();
  String lastInitial = words.length > 1 ? words.last[0].toUpperCase() : '';

  return firstInitial + lastInitial;
}
