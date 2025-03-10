import 'package:logaluxe_users/model/appointment.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/user.dart';

List<Appointment> allAppointment = [
  Appointment(
    payment_status: "pending",
    status: "booked",
    products: [
      AppointmentProduct(id: "prod_001", count: 2, product_name: "Shampoo"),
      AppointmentProduct(id: "prod_002", count: 1, product_name: "Haircut"),
    ],
    time: "10:30 AM",
    first_name: "John",
    last_name: "Doe",
    phone: "+1234567890",
    currency: "USD",
    start_date: DateTime.now(),
    end_date: DateTime.now().add(Duration(hours: 1)),
    total_amount: 100,
    service_amount: 80,
    service_id: ServiceModel(
      id: "srv_001",
      name: "Haircut",
      service_duration: "1 hour",
      location: "Downtown Salon",
      service_ref: "HC123",
      company_id: "cmp_001",
      category_id: "cat_001",
      amount: 80,
      country: "USA",
      state: "California",
      active: true,
      opening_time: "09:00 AM",
      closing_time: "08:00 PM",
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      currency: "USD",
      description: "Professional haircut service",
      image_url: "http://res.cloudinary.com/dkr0odvfi/image/upload/v1740668742/kcivpncdwqqd5xlnfrhb.jpg",
    ),
    note: "Please be on time",
    customer_id: UserModel(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      phone: "+1234567890",
      occupation: "Engineer",
      bio: "Loves grooming",
      business_name: "Doe Inc.",
      business_address: "123 Main St",
    ),
    company_id: UserModel(
      first_name: "Jane",
      last_name: "Smith",
      email: "jane.smith@salon.com",
      phone: "+9876543210",
      occupation: "Salon Owner",
      bio: "Expert Stylist",
      business_name: "Luxury Salon",
      business_address: "456 Elm St",
    ),
    duration: "1 hour",
    appointment_ref: "APP_123",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Appointment(
    payment_status: "pending",
    status: "completed",
    products: [
      AppointmentProduct(id: "prod_003", count: 1, product_name: "Facial"),
    ],
    time: "2:00 PM",
    first_name: "Alice",
    last_name: "Williams",
    phone: "+1987654321",
    currency: "EUR",
    start_date: DateTime.now().add(Duration(days: 1)),
    end_date: DateTime.now().add(Duration(days: 1, hours: 2)),
    total_amount: 50,
    service_amount: 50,
    service_id: ServiceModel(
      id: "srv_002",
      name: "Facial Treatment",
      service_duration: "2 hours",
      location: "Beauty Spa",
      service_ref: "FACIAL123",
      company_id: "cmp_002",
      category_id: "cat_002",
      amount: 50,
      country: "France",
      state: "Paris",
      active: true,
      opening_time: "10:00 AM",
      closing_time: "07:00 PM",
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      currency: "EUR",
      description: "Luxury facial treatment",
      image_url: "http://res.cloudinary.com/dkr0odvfi/image/upload/v1740668782/t6uugitpty9oyiq0n1zh.jpg",
    ),
    note: "Sensitive skin, please use mild products",
    customer_id: UserModel(
      first_name: "Alice",
      last_name: "Williams",
      email: "alice.williams@example.com",
      phone: "+1987654321",
      occupation: "Model",
      bio: "Loves skincare",
      business_name: "Glow Co.",
      business_address: "789 Beauty St",
    ),
    company_id: UserModel(
      first_name: "Marie",
      last_name: "Curie",
      email: "marie.curie@spa.com",
      phone: "+1234567891",
      occupation: "Spa Owner",
      bio: "Skin Expert",
      business_name: "Luxury Spa",
      business_address: "123 Glow St",
    ),
    duration: "2 hours",
    appointment_ref: "APP_456",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Appointment(
    payment_status: "pending",
    status: "canceled",
    products: [],
    time: "5:00 PM",
    first_name: "Michael",
    last_name: "Brown",
    phone: "+1122334455",
    currency: "GBP",
    start_date: DateTime.now().add(Duration(days: 2)),
    end_date: DateTime.now().add(Duration(days: 2, hours: 1)),
    total_amount: 70,
    service_amount: 70,
    service_id: ServiceModel(
      id: "srv_003",
      name: "Massage Therapy",
      service_duration: "1 hour",
      location: "Wellness Center",
      service_ref: "MASSAGE001",
      company_id: "cmp_003",
      category_id: "cat_003",
      amount: 70,
      country: "UK",
      state: "London",
      active: true,
      opening_time: "08:00 AM",
      closing_time: "09:00 PM",
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      currency: "GBP",
      description: "Relaxing full-body massage",
      image_url: "http://res.cloudinary.com/dkr0odvfi/image/upload/v1740668893/tt8sxlqjfz8pokh9kayc.jpg",
    ),
    note: "Lower back pain, focus on that area",
    customer_id: UserModel(
      first_name: "Michael",
      last_name: "Brown",
      email: "michael.brown@example.com",
      phone: "+1122334455",
      occupation: "Athlete",
      bio: "Sports enthusiast",
      business_name: "Wellness Pro",
      business_address: "321 Relax St",
    ),
    company_id: UserModel(
      first_name: "Emma",
      last_name: "Watson",
      email: "emma.watson@wellness.com",
      phone: "+2233445566",
      occupation: "Wellness Expert",
      bio: "Healing Hands",
      business_name: "Wellness Center",
      business_address: "654 Calm St",
    ),
    duration: "1 hour",
    appointment_ref: "APP_789",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  )
];
