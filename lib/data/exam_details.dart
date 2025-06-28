class JobDetails {
  final String postDate;
  final String postBoard;
  final String postName;
  final String lastDate;
  final String detailsLink;
  final List<String> qualifications;
  final String officialWebsite;
  final List<String> applyOnline;

  JobDetails({
    required this.postDate,
    required this.postBoard,
    required this.postName,
    required this.lastDate,
    required this.detailsLink,
    required this.qualifications,
    required this.officialWebsite,
    required this.applyOnline,
  });

  factory JobDetails.fromJson(Map<String, dynamic> json) {
  return JobDetails(
    postDate: json['postDate'] ?? 'N/A',
    postBoard: json['postBoard'] ?? 'N/A',
    postName: json['postName'] ?? 'N/A',
    lastDate: json['lastDate'] ?? 'N/A',
    detailsLink: json['detailLink'] ?? 'N/A',
    qualifications: json['qualification'] is List
        ? List<String>.from(json['qualification'])
        : [json['qualification'] ?? 'N/A'],
    officialWebsite: json['official_website'] ?? 'N/A',
    applyOnline: json['apply_online'] != null &&
            json['apply_online'] is Map<String, dynamic>
        ? List<String>.from((json['apply_online'] as Map).values)
        : [],
  );
}

}
