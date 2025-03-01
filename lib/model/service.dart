class ServiceModel {
  final String id;
  final String name;
  final String service_duration;
  final String location;
  final String service_ref;
  final String company_id;
  final String category_id;
  final String amount;
  final String country;
  final String state;
  final bool active;
  final String currency;
  final String image_url;
  final String opening_time;
  final String closing_time;
  final String createdAt;
  final String updatedAt;
  final String description;
  ServiceModel(
      {required this.id,
      required this.name,
      required this.service_duration,
      required this.location,
      required this.service_ref,
      required this.company_id,
      required this.category_id,
      required this.amount,
      required this.country,
      required this.state,
      required this.active,
      required this.opening_time,
      required this.closing_time,
      required this.createdAt,
      required this.currency,
      required this.updatedAt,
      required this.description,
      required this.image_url});
}
