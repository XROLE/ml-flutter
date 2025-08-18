class Helper {
  String states = "Abia|Adamawa|Akwa Ibom|Anambra|Bauchi|Bayelsa|Benue|Borno|Cross River|Delta|Ebonyi|Edo|Ekiti|Enugu|FCT|Federal Capital Territory|Gombe|Imo|Jigawa|Kaduna|Kano|Katsina|Kebbi|Kogi|Kwara|Lagos|Nasarawa|Niger|Ogun|Ondo|Osun|Oyo|Plateau|Rivers|Sokoto|Taraba|Yobe|Zamfara";
  String jhg = "Enugu|Lagos";
  
  String? extractAddress(String doc) {
    RegExp exp = RegExp(
      r'\d+\s+[\w\s]+\s+(Street|St|Road|Rd|Avenue|Ave|Close|Cl|Crescent|Cres|Lane|Ln)\s*,?\s*[\w\s,]*?(Abia|Adamawa|Akwa Ibom|Anambra|Bauchi|Bayelsa|Benue|Borno|Cross River|Delta|Ebonyi|Edo|Ekiti|Enugu|FCT|Federal Capital Territory|Gombe|Imo|Jigawa|Kaduna|Kano|Katsina|Kebbi|Kogi|Kwara|Lagos|Nasarawa|Niger|Ogun|Ondo|Osun|Oyo|Plateau|Rivers|Sokoto|Taraba|Yobe|Zamfara)',
      caseSensitive: false,
    );
    Iterable<Match> matches = exp.allMatches(doc);

    // for (var match in matches) {
    //   print("Here is the match =====================> ${match.group(0)}");
    // }

    return matches.isNotEmpty ? "${matches.first.group(0)}, Nigeria" : null;
  }
}
