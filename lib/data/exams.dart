class Exams {
  final String sector;
  final String postDate;
  final String updateInformation;
  final String detailLink;
  final List<String> applicationFee;
  final List<String> importantDates;
  final List<String> ageLimit;
  final List<String> qualification;
  final List<String> importantLinks;

  Exams({
    required this.sector,
    required this.postDate,
    required this.updateInformation,
    required this.detailLink,
    required this.applicationFee,
    required this.importantDates,
    required this.ageLimit,
    required this.qualification,
    required this.importantLinks,
  });

  factory Exams.fromJson(Map<String, dynamic> json) {
    return Exams(
      sector: json['sector'] ?? '',
      postDate: json['postDate'] ?? '',
      updateInformation: json['updateInformation'] ?? '',
      detailLink: json['detailLink'] ?? '',
      applicationFee: json['applicationFee'] is List
          ? List<String>.from(json['applicationFee'])
          : [json['applicationFee'] ?? ''],
      importantDates: json['importantDates'] is List
          ? List<String>.from(json['importantDates'])
          : [json['importantDates'] ?? ''],
      ageLimit: json['ageLimit'] is List
          ? List<String>.from(json['ageLimit'])
          : [json['ageLimit'] ?? ''],
      qualification: json['qualification'] is List
          ? List<String>.from(json['qualification'])
          : [json['qualification'] ?? ''],
      importantLinks: json['importantLinks'] != null
          ? List<String>.from((json['importantLinks'] as Map).values)
          : [],
    );
  }
}
