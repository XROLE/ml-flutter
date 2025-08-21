import 'package:string_similarity/string_similarity.dart';

class Helper {
  String? extractAddress(String doc) {
    RegExp exp = RegExp(
      r'\d+\s+[\w\s]+\s+(Street|St|Road|Rd|Avenue|Ave|Close|Cl|Crescent|Cres|Lane|Ln)\s*,?\s*[\w\s,]*?(Abia|Adamawa|Akwa Ibom|Anambra|Bauchi|Bayelsa|Benue|Borno|Cross River|Delta|Ebonyi|Edo|Ekiti|Enugu|FCT|Federal Capital Territory|Gombe|Imo|Jigawa|Kaduna|Kano|Katsina|Kebbi|Kogi|Kwara|Lagos|Nasarawa|Niger|Ogun|Ondo|Osun|Oyo|Plateau|Rivers|Sokoto|Taraba|Yobe|Zamfara)',
      caseSensitive: false,
    );
    Iterable<Match> matches = exp.allMatches(doc);
    return matches.isNotEmpty ? "${matches.first.group(0)}, Nigeria" : null;
  }

  String normalizeAddress(String address) {
    return address
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  double hybridStringMatch(String strA, String strB) {
    final addressA = normalizeAddress(strA);
    final addressB = normalizeAddress(strB);

    // Direct string similarity (Levenshtein/Cosine)
    double stringScore = addressA.similarityTo(addressB);

    // Token-based similarity
    final tokensA = addressA.split(" ").toSet();
    final tokensB = addressB.split(" ").toSet();
    final intersection = tokensA.intersection(tokensB).length;
    final union = tokensA.union(tokensB).length;
    double tokenScore = union == 0 ? 0 : intersection / union;

    // Weighted hybrid score
    return ((0.6 * stringScore) + (0.4 * tokenScore)) * 100;
  }
}
