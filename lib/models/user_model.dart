class UserModel {
  final String headline;
  final String subhead;
  final String avatarUrl;
  final String githubUrl;
  final String linkedInUrl;
  final String mediumUrl;

  UserModel({
    this.headline,
    this.subhead,
    this.avatarUrl,
    this.githubUrl,
    this.linkedInUrl,
    this.mediumUrl
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : headline = json['headline'] ?? '',
        subhead = json['subhead'] ?? '',
        avatarUrl = json['avatar_url'] ?? '',
        githubUrl = json['github_url'] ?? '',
        linkedInUrl = json['linked_in_url'] ?? '',
        mediumUrl = json['medium_url'] ?? '';
}