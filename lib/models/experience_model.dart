class ExperienceModel {
  final String title;
  final String company;
  final String companyUrl;
  final String employmentType;
  final String startDate;
  final String endDate;

  ExperienceModel({
    this.title,
    this.company,
    this.companyUrl,
    this.employmentType,
    this.startDate,
    this.endDate
  });

  ExperienceModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        company = json['company'] ?? '',
        companyUrl = json['company_url'] ?? '',
        employmentType = json['employment_type'] ?? '',
        startDate = json['start_date'] ?? '',
        endDate = json['end_date'] ?? '';
}