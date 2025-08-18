class Helper {
  String? extractAddress(String doc) {
    RegExp exp = RegExp(
      r'\d+\s+[\w\s]+\s+(Street|St|Road|Rd|Avenue|Ave|Close|Cl|Crescent|Cres|Lane|Ln)\s*,?\s*[\w\s,]*',
      caseSensitive: false,
    );
    Iterable<Match> matches = exp.allMatches(doc);

    // for (var match in matches) {
    //   print("Here is the match =====================> ${match.group(0)}");
    // }

    return matches.isNotEmpty ? matches.first.group(0) : null;
  }
}
