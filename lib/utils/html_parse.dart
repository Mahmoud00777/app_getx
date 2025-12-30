import 'package:html/parser.dart';

String parseHtml(String htmlString) {
  try {
    // Parse the HTML document
    final document = parse(htmlString);

    // Get the div with class "ql-editor read-mode"
    final contentDiv = document.querySelector('div.ql-editor.read-mode');

    if (contentDiv != null) {
      // Extract text from all paragraphs, joining with newlines
      final paragraphs = contentDiv.querySelectorAll('p');
      return paragraphs.map((p) => p.text).join('\n');
    }

    // Fallback if the specific div isn't found
    return document.body?.text.trim() ?? htmlString;
  } catch (e) {
    print('Error parsing HTML: $e');
    return htmlString; // Return original string if parsing fails
  }
}
