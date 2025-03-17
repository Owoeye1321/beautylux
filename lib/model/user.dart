import 'package:intl/intl.dart';

class UserModel {
  final String first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final String? occupation;
  final bool? is_active;
  final String? email_verification_code;
  final String? two_fa_code;
  final String? salt;
  final String? otp;
  final String? image_url;
  final String bio;
  final bool? availability;
  final String? subscription_plan;
  final String? token;
  final String? opening_time;
  final String? closing_time;
  final String business_name;
  final String business_address;
  final String? company_id;
  final bool? is_email_verified;
  final bool? is_phone_verified;
  final String? otp_expiry;
  final String? country;
  final String? subscription_expiry_date;
  final String? state;
  final String? sms_notifications;
  final String? push_notifications;
  final String? in_app_notifications;
  final String? booking_confirmation;
  final String? cancellation_notification;
  final String? rescheduling_notification;
  final String? low_stock_alert;
  final String? new_product_launch;
  final String? currency;
  final String? role;
  final String? customer_ref;
  final String? address_id;
  final String? city;
  final String? postal_code;
  final String? createdAt;
  final String? updatedAt;
  UserModel(
      {required this.first_name,
      this.last_name,
      this.email,
      this.phone,
      this.occupation,
      this.is_active,
      this.email_verification_code,
      this.two_fa_code,
      this.salt,
      this.otp,
      this.image_url,
      required this.bio,
      this.availability,
      this.subscription_plan,
      this.opening_time,
      this.closing_time,
      required this.business_name,
      required this.business_address,
      this.company_id,
      this.is_email_verified,
      this.is_phone_verified,
      this.otp_expiry,
      this.country,
      this.subscription_expiry_date,
      this.state,
      this.sms_notifications,
      this.push_notifications,
      this.in_app_notifications,
      this.booking_confirmation,
      this.cancellation_notification,
      this.rescheduling_notification,
      this.low_stock_alert,
      this.new_product_launch,
      this.currency,
      this.role,
      this.customer_ref,
      this.address_id,
      this.city,
      this.token,
      this.postal_code,
      this.createdAt,
      this.updatedAt});

  static List<UserModel> fromJsonList(Map<String, dynamic> data) {
    List<UserModel> allUsers = [];
    for (Map<String, dynamic> eachUser in data['data']) {
      var first_name =
          eachUser['first_name'].toString() == "null" ? "user" : eachUser['first_name'].toString();
      var bio = eachUser['bio'].toString() == "null" ? "Providing services" : eachUser['bio'].toString();
      var business_name = eachUser['business_name'].toString() == "service"
          ? "Providing services"
          : eachUser['business_name'].toString();
      var business_address = eachUser['business_address'].toString() == "service"
          ? "Lagos, nigeria"
          : eachUser['business_address'].toString();
      DateTime date = DateTime.parse(eachUser['createdAt']);
      UserModel user = UserModel(
          first_name: first_name,
          bio: bio,
          business_name: business_name,
          business_address: business_address,
          createdAt: DateFormat.jm().format(date));

      allUsers.add(user);
    }
    return allUsers;
  }
}
