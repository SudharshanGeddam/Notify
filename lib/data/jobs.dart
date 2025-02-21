class Job {
  late final String postDate;
  late final String postBoard;
  late final String postName;
  late final String qualification;
  late final String lastDate;
  late final String link;
  late final String applyOnline;
  late final String notificationFile;
  late final String officialWebsite;

  Job({
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

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      postDate: json['postDate'] ?? '',
      postBoard: json['postBoard'] ?? '',
      postName: json['postName'] ?? '',
      qualification: json['qualification'] ?? '',
      lastDate: json['lastDate'] ?? '',
      link: json['link'] ?? '',
      applyOnline: json['apply_online'] ?? '',
      notificationFile: json['notification'] ?? '',
      officialWebsite: json['official_website'] ?? '',
    );
  }
}
