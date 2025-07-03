class JobsData {
  late final String postDate;
  late final String postBoard;
  late final String postName;
  late final String lastDate;
  late final String link;
  late final List<String> applyOnline;
  late final String notificationFile;
  late final String officialWebsite;
  late final List<String> qualification;

  JobsData({
    required this.postDate,
    required this.postBoard,
    required this.postName,
    required this.qualification,
    required this.lastDate,
    required this.link,
    required this.applyOnline,
    required this.notificationFile,
    required this.officialWebsite,
  });

  factory JobsData.fromJson(Map<String, dynamic> json) {
    // Normalize 'qualification'
    List<String> qualifications;
    final rawQualification = json['qualification'];
    if (rawQualification is List) {
      qualifications = rawQualification.map((e) => e.toString()).toList();
    } else if (rawQualification is String) {
      qualifications = [rawQualification];
    } else {
      qualifications = ['N/A'];
    }

    // Normalize 'applyOnline'
    List<String> applyLinks;
    final rawApply = json['applyOnline'];
    if (rawApply is List) {
      applyLinks = rawApply.map((e) => e.toString()).toList();
    } else if (rawApply is String) {
      applyLinks = [rawApply];
    } else {
      applyLinks = ['N/A'];
    }

    return JobsData(
      postDate: json['postDate'] ?? 'N/A',
      postBoard: json['postBoard'] ?? 'N/A',
      postName: json['postName'] ?? '',
      qualification: qualifications,
      lastDate: json['lastDate'] ?? 'N/A',
      link: json['link'] ?? 'N/A',
      applyOnline: applyLinks,
      notificationFile: json['notification'] ?? 'N/A',
      officialWebsite: json['official_website'] ?? 'N/A',
    );
  }
}
