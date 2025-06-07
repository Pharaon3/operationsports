import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BBCodeParser {
  /// Converts BBCode to HTML string.
  static String bbcodeToHtml(String input) {
    String output = input;

    // Basic text formatting
    output = output
        .replaceAllMapped(
          RegExp(r'\[b](.+?)\[/b]', dotAll: true, caseSensitive: false),
          (m) => '<strong>${m[1]}</strong>',
        )
        .replaceAllMapped(
          RegExp(r'\[i](.+?)\[/i]', dotAll: true, caseSensitive: false),
          (m) => '<em>${m[1]}</em>',
        )
        .replaceAllMapped(
          RegExp(r'\[u](.+?)\[/u]', dotAll: true, caseSensitive: false),
          (m) => '<u>${m[1]}</u>',
        );

    // Links and images
    output = output
        .replaceAllMapped(
          RegExp(
            r'\[url=(.+?)\](.+?)\[/url]',
            dotAll: true,
            caseSensitive: false,
          ),
          (m) => '<a href="${m[1]}">${m[2]}</a>',
        )
        .replaceAllMapped(
          RegExp(r'\[url](.+?)\[/url]', dotAll: true, caseSensitive: false),
          (m) => '<a href="${m[1]}">${m[1]}</a>',
        )
        .replaceAllMapped(
          RegExp(r'\[img](.+?)\[/img]', dotAll: true, caseSensitive: false),
          (m) => '<img src="${m[1]}" />',
        );

    // Quote blocks
    output = output
        .replaceAllMapped(
          RegExp(
            r'\[quote=(.+?);.*?](.+?)\[/quote]',
            dotAll: true,
            caseSensitive: false,
          ),
          (m) =>
              '<blockquote><strong>${m[1]} said:</strong><br><em>${m[2]}</em></blockquote>',
        )
        .replaceAllMapped(
          RegExp(r'\[quote](.+?)\[/quote]', dotAll: true, caseSensitive: false),
          (m) => '<blockquote><em>${m[1]}</em></blockquote>',
        );

    // Font size
    output = output.replaceAllMapped(
      RegExp(
        r'\[size="?(\d+)"?](.+?)\[/size]',
        dotAll: true,
        caseSensitive: false,
      ),
      (m) => '<span style="font-size:${m[1]}px">${m[2]}</span>',
    );

    // Center
    output = output.replaceAllMapped(
      RegExp(r'\[center](.+?)\[/center]', dotAll: true, caseSensitive: false),
      (m) => '<div style="text-align:center;">${m[1]}</div>',
    );

    // Spoiler
    output = output.replaceAllMapped(
      RegExp(r'\[spoiler](.+?)\[/spoiler]', dotAll: true, caseSensitive: false),
      (m) => '<details><summary>Spoiler</summary>${m[1]}</details>',
    );

    // Ordered list
    output = output.replaceAllMapped(
      RegExp(r'\[list=1](.+?)\[/list]', dotAll: true, caseSensitive: false),
      (m) {
        final items =
            m[1]!
                .split(RegExp(r'\[\*\]', caseSensitive: false))
                .where((item) => item.trim().isNotEmpty)
                .map((item) => '<li>${item.trim()}</li>')
                .join();
        return '<ol>$items</ol>';
      },
    );

    // Unordered list
    output = output.replaceAllMapped(
      RegExp(r'\[list](.+?)\[/list]', dotAll: true, caseSensitive: false),
      (m) {
        final items =
            m[1]!
                .split(RegExp(r'\[\*\]', caseSensitive: false))
                .where((item) => item.trim().isNotEmpty)
                .map((item) => '<li>${item.trim()}</li>')
                .join();
        return '<ul>$items</ul>';
      },
    );

    // Newlines to <br>
    output = output.replaceAll('\n', '<br>');

    return output;
  }

  /// Builds an Html widget from BBCode input string.
  static Widget buildHtmlWidget(String inputString) {
    final htmlContent = bbcodeToHtml(inputString);

    return Html(
      data: htmlContent,
      style: {
        '*': Style(color: Colors.white, fontSize: FontSize(16)),
        'a': Style(
          color: Colors.lightBlue,
          textDecoration: TextDecoration.underline,
        ),
        'blockquote': Style(
          backgroundColor: Colors.grey[800],
          padding: HtmlPaddings.all(12),
          margin: Margins.symmetric(vertical: 12),
          border: Border.all(color: Colors.grey[700]!),
        ),
        'ul': Style(
          padding: HtmlPaddings.only(left: 20),
          listStyleType: ListStyleType.disc,
        ),
        'ol': Style(
          padding: HtmlPaddings.only(left: 20),
          listStyleType: ListStyleType.decimal,
        ),
        'details': Style(
          backgroundColor: Colors.grey[900],
          padding: HtmlPaddings.all(10),
          margin: Margins.only(top: 10, bottom: 10),
          border: Border.all(color: Colors.grey[700]!),
        ),
      },
    );
  }
}
