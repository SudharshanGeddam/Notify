class LatestExamsDetails {
  late final String postDate;
  late final String postBoard;
  late final String postName;
  late final String lasteDate;
  late final String link;
  late final String applyOnline;
  late final String notificationFile;
  late final String officialWebsite;
  late final List<String> qualification;

  LatestExamsDetails({
    required this.postDate,
    required this.postBoard,
    required this.postName,
    required this.qualification,
    required this.lasteDate,
    required this.link,
    required this.applyOnline,
    required this.notificationFile,
    required this.officialWebsite,
  });

  factory LatestExamsDetails.fromJson(Map<String, dynamic> json) {
    return LatestExamsDetails(
      postDate: json['postDate'] ?? 'N/A',
      postBoard: json['postBoard'] ?? 'N/A',
      postName: json['postName'] ?? '',
      qualification: json['qualification'] is List
          ? List<String>.from(json['qualification'])
          : [json['qualification'] ?? 'N/A'],
      lasteDate: json['lasteDate'] ?? 'N/A',
      link: json['link'] ?? 'N/A',
      applyOnline: json['applyOnline'] ?? 'N/A',
      notificationFile: json['notificationFile'] ?? 'N/A',
      officialWebsite: json['officialWebsite'] ?? 'N/A',
    );
  }
}
