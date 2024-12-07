import 'package:flutter/material.dart';

String makeHold(String colors) {
  String boltColor = colors == '#171717' ? '#838383' : '#111111';
  String svgString = '''
<svg width="42" height="42" viewBox="0 0 42 42" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M41 27.2963C41 38.342 32.0457 41 21 41C9.9543 41 1 38.342 1 27.2963C1 16.2506 7.29621 1 21 1C34.7038 1 41 16.2506 41 27.2963Z" fill="${colors}" stroke="#111111"/>
  <ellipse cx="20.8542" cy="22.5637" rx="3.88248" ry="3.90944" fill="${boltColor}"/>
</svg>
''';

  return svgString;
}
