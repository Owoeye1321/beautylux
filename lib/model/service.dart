class ServiceModel {
  final String id;
  final String name;
  final String service_duration;
  final String location;
  final String service_ref;
  final String company_id;
  final String category_id;
  final int amount;
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

  static List<ServiceModel> fromResponse(Map<String, dynamic> data) {
    List<ServiceModel> allServices = [];
    for (Map<String, dynamic> eachService in data['data']) {
      ServiceModel service = ServiceModel(
        id: eachService['id'],
        name: eachService['name'],
        service_duration: eachService['service_duration'],
        location: eachService['location'],
        service_ref: eachService['service_ref'],
        company_id: eachService['company_id'],
        category_id: eachService['category_id'],
        amount: eachService['amount'],
        country: eachService['country'],
        state: eachService['state'],
        active: eachService['active'],
        opening_time: eachService['opening_time'],
        closing_time: eachService['closing_time'],
        createdAt: eachService['createdAt'],
        currency: eachService['currency'],
        updatedAt: eachService['updatedAt'],
        description: eachService['description'],
        image_url: eachService['image_url'],
      );
      allServices.add(service);
    }
    return allServices;
  }
}
