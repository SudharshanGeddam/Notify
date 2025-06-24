class LatestExamsDetails {
  final String sector;
  final String postDate;
  final String updateInfo;
  final String detailsLink;
  final List<String> qualifications;
  final List<String> applicationFees;
  final List<String> ageLimit;
  final List<String> importantDates;
  final List<String> importantLinks;

  LatestExamsDetails({
    required this.sector,
    required this.postDate,
    required this.updateInfo,
    required this.detailsLink,
    required this.qualifications,
    required this.applicationFees,
    required this.ageLimit,
    required this.importantDates,
    required this.importantLinks,
  });

  factory LatestExamsDetails.fromJson(Map<String, dynamic> json) {
    return LatestExamsDetails(
      sector: json['sector'] ?? '',
      postDate: json['postDate'] ?? '',
      updateInfo: json['updateInfo'] ?? '',
      detailsLink: json['detailsLink'] ?? '',
      qualifications: List<String>.from(json['qualifications'] ?? []),
      applicationFees: List<String>.from(json['applicationFees'] ?? []),
      ageLimit: List<String>.from(json['ageLimit'] ?? []),
      importantDates: List<String>.from(json['importantDates'] ?? []),
      importantLinks: List<String>.from(json['importantLinks'] ?? []),
    );
  }
}
