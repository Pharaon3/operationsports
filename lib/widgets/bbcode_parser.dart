import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BBCodeParser {
  // Normalize HTML tags to BBCode before parsing
  static String normalizeHtmlToBBCode(String input) {
    return input
        .replaceAllMapped(RegExp(r'<b>(.*?)</b>', caseSensitive: false), (m) => '[b]${m[1]}[/b]')
        .replaceAllMapped(RegExp(r'<i>(.*?)</i>', caseSensitive: false), (m) => '[i]${m[1]}[/i]')
        .replaceAllMapped(RegExp(r'<u>(.*?)</u>', caseSensitive: false), (m) => '[u]${m[1]}[/u]')
        .replaceAllMapped(RegExp(r'<a href="(.*?)">(.*?)</a>', caseSensitive: false), (m) => '[url=${m[1]}]${m[2]}[/url]')
        .replaceAllMapped(RegExp(r'<br\s*/?>', caseSensitive: false), (_) => '\n')
        .replaceAll(RegExp(r'<.*?>'), ''); // remove any remaining HTML tags
  }

  static List<InlineSpan> parseTextSpans(String input) {
    final spans = <InlineSpan>[];

    final regex = RegExp(
      r'(\[b](.+?)\[/b])|' // 1,2
      r'(\[i](.+?)\[/i])|' // 3,4
      r'(\[u](.+?)\[/u])|' // 5,6
      r'(\[url=(.+?)\](.+?)\[/url])|' // 7,8,9
      r'(\[img](.+?)\[/img])|' // 10,11
      r'(\[quote(?:=(.+?))?\](.+?)\[/quote])|' // 12,13,14
      r'(\[size="?(\d+)"?](.+?)\[/size])', // 15,16,17
      caseSensitive: false,
      dotAll: true,
    );

    int currentIndex = 0;
    final matches = regex.allMatches(input);

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: input.substring(currentIndex, match.start),
            style: const TextStyle(color: Colors.white),
          ),
        );
      }

      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(
          text: match.group(4),
          style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ));
      } else if (match.group(5) != null) {
        spans.add(TextSpan(
          text: match.group(6),
          style: const TextStyle(decoration: TextDecoration.underline, color: Colors.white),
        ));
      } else if (match.group(7) != null) {
        final url = match.group(8)!;
        final text = match.group(9)!;

        spans.add(WidgetSpan(
          child: GestureDetector(
            onTap: () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                launchUrl(uri);
              }
            },
            child: Text(
              text,
              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        ));
      } else if (match.group(10) != null) {
        final imageUrl = match.group(11)!;
        spans.add(WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Image.network(imageUrl),
          ),
        ));
      } else if (match.group(12) != null) {
        final author = match.group(13);
        final quoteText = match.group(14)!.trim();
        final formattedQuote = '"$quoteText"';

        spans.add(WidgetSpan(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (author != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '$author said:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  formattedQuote,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
      } else if (match.group(15) != null) {
        final fontSize = double.tryParse(match.group(16) ?? '14') ?? 14;
        final text = match.group(17)!;
        spans.add(TextSpan(
          text: text,
          style: TextStyle(fontSize: fontSize.toDouble(), color: Colors.white),
        ));
      }

      currentIndex = match.end;
    }

    if (currentIndex < input.length) {
      spans.add(TextSpan(
        text: input.substring(currentIndex),
        style: const TextStyle(color: Colors.white),
      ));
    }

    return spans;
  }

  static List<Widget> parseBBCodeToWidgets(String rawInput) {
    final cleanedInput = normalizeHtmlToBBCode(rawInput);
    final spans = parseTextSpans(cleanedInput);

    return [
      RichText(
        text: TextSpan(children: spans),
        textAlign: TextAlign.left,
      ),
    ];
  }
}
