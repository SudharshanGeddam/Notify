class ExamDetails {
  final String sector;
  final String postDate;
  final String postBoard;
  final String postName;
  final String updateInfo;
  final String detailsLink;
  final List<String> qualifications;
  final List<String> applicationFees;
  final List<String> ageLimit;
  final List<String> importantDates;
  final List<String> importantLinks;

  ExamDetails({
    required this.sector,
    required this.postDate,
    required this.postBoard,
    required this.postName,
    required this.updateInfo,
    required this.detailsLink,
    required this.qualifications,
    required this.applicationFees,
    required this.ageLimit,
    required this.importantDates,
    required this.importantLinks,
  });

  factory ExamDetails.fromJson(Map<String, dynamic> json) {
    return ExamDetails(
      sector: json['sector'] ?? '',
      postDate: json['postDate'] ?? '',
      postBoard: json['postBoard'] ?? '',
      postName: json['postName'] ?? '',
      updateInfo: json['updateInformation'] ?? '',
      detailsLink: json['detailLink'] ?? '',
      applicationFees: json['applicationFee'] is List
          ? List<String>.from(json['applicationFee'])
          : [json['applicationFee'] ?? ''],
      importantDates: json['importantDates'] is List
          ? List<String>.from(json['importantDates'])
          : [json['importantDates'] ?? ''],
      ageLimit: json['ageLimit'] is List
          ? List<String>.from(json['ageLimit'])
          : [json['ageLimit'] ?? ''],
      qualifications: json['qualification'] is List
          ? List<String>.from(json['qualification'])
          : [json['qualification'] ?? ''],
      importantLinks: json['importantLinks'] != null
          ? List<String>.from((json['importantLinks'] as Map).values)
          : [],
    );
  }
}
