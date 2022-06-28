// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromMap(jsonString);

import 'dart:convert';

class UserInfoResponse {
  UserInfoResponse({
    this.id,
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.isActive,
    this.secondLastName,
    this.rut,
    this.birthDate,
    this.gender,
    this.phoneNumber,
    this.notes,
    this.isSuperadmin,
    this.isEmailActivated,
    this.isAdministrative,
    this.isWarehouse,
    this.isSeller,
    this.isProfessional,
    this.isPatient,
    this.patientNotes,
    this.companyDiscountPlanPaymentMethod,
    this.isPlanActivated,
    this.isPlanHolder,
    this.isPlanBeneficiary,
    this.companyDiscountPlanActivationDate,
    this.companyDiscountPlanDeactivationDate,
    this.user,
    this.defaultCompany,
    this.companyDiscountPlan,
    this.companyDiscountPlanHolder,
    this.addresses,
  });

  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  bool? isActive;
  String? secondLastName;
  String? rut;
  dynamic birthDate;
  dynamic gender;
  dynamic phoneNumber;
  String? notes;
  bool? isSuperadmin;
  bool? isEmailActivated;
  bool? isAdministrative;
  bool? isWarehouse;
  bool? isSeller;
  bool? isProfessional;
  bool? isPatient;
  String? patientNotes;
  dynamic companyDiscountPlanPaymentMethod;
  bool? isPlanActivated;
  bool? isPlanHolder;
  bool? isPlanBeneficiary;
  dynamic companyDiscountPlanActivationDate;
  dynamic companyDiscountPlanDeactivationDate;
  int? user;
  int? defaultCompany;
  dynamic companyDiscountPlan;
  dynamic companyDiscountPlanHolder;
  List<dynamic>? addresses;

  UserInfoResponse copyWith({
    int? id,
    String? fullName,
    String? firstName,
    String? lastName,
    String? email,
    bool? isActive,
    String? secondLastName,
    String? rut,
    dynamic birthDate,
    dynamic gender,
    dynamic phoneNumber,
    String? notes,
    bool? isSuperadmin,
    bool? isEmailActivated,
    bool? isAdministrative,
    bool? isWarehouse,
    bool? isSeller,
    bool? isProfessional,
    bool? isPatient,
    String? patientNotes,
    dynamic companyDiscountPlanPaymentMethod,
    bool? isPlanActivated,
    bool? isPlanHolder,
    bool? isPlanBeneficiary,
    dynamic companyDiscountPlanActivationDate,
    dynamic companyDiscountPlanDeactivationDate,
    int? user,
    int? defaultCompany,
    dynamic companyDiscountPlan,
    dynamic companyDiscountPlanHolder,
    List<dynamic>? addresses,
  }) =>
      UserInfoResponse(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        isActive: isActive ?? this.isActive,
        secondLastName: secondLastName ?? this.secondLastName,
        rut: rut ?? this.rut,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        notes: notes ?? this.notes,
        isSuperadmin: isSuperadmin ?? this.isSuperadmin,
        isEmailActivated: isEmailActivated ?? this.isEmailActivated,
        isAdministrative: isAdministrative ?? this.isAdministrative,
        isWarehouse: isWarehouse ?? this.isWarehouse,
        isSeller: isSeller ?? this.isSeller,
        isProfessional: isProfessional ?? this.isProfessional,
        isPatient: isPatient ?? this.isPatient,
        patientNotes: patientNotes ?? this.patientNotes,
        companyDiscountPlanPaymentMethod: companyDiscountPlanPaymentMethod ??
            this.companyDiscountPlanPaymentMethod,
        isPlanActivated: isPlanActivated ?? this.isPlanActivated,
        isPlanHolder: isPlanHolder ?? this.isPlanHolder,
        isPlanBeneficiary: isPlanBeneficiary ?? this.isPlanBeneficiary,
        companyDiscountPlanActivationDate: companyDiscountPlanActivationDate ??
            this.companyDiscountPlanActivationDate,
        companyDiscountPlanDeactivationDate:
            companyDiscountPlanDeactivationDate ??
                this.companyDiscountPlanDeactivationDate,
        user: user ?? this.user,
        defaultCompany: defaultCompany ?? this.defaultCompany,
        companyDiscountPlan: companyDiscountPlan ?? this.companyDiscountPlan,
        companyDiscountPlanHolder:
            companyDiscountPlanHolder ?? this.companyDiscountPlanHolder,
        addresses: addresses ?? this.addresses,
      );
  factory UserInfoResponse.fromJson(String str) =>
      UserInfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfoResponse.fromMap(Map<String, dynamic> json) =>
      UserInfoResponse(
        id: json["id"],
        fullName: json["full_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isActive: json["is_active"],
        secondLastName: json["second_last_name"],
        rut: json["rut"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        notes: json["notes"],
        isSuperadmin: json["is_superadmin"],
        isEmailActivated: json["is_email_activated"],
        isAdministrative: json["is_administrative"],
        isWarehouse: json["is_warehouse"],
        isSeller: json["is_seller"],
        isProfessional: json["is_professional"],
        isPatient: json["is_patient"],
        patientNotes: json["patient_notes"],
        companyDiscountPlanPaymentMethod:
            json["company_discount_plan_payment_method"],
        isPlanActivated: json["is_plan_activated"],
        isPlanHolder: json["is_plan_holder"],
        isPlanBeneficiary: json["is_plan_beneficiary"],
        companyDiscountPlanActivationDate:
            json["company_discount_plan_activation_date"],
        companyDiscountPlanDeactivationDate:
            json["company_discount_plan_deactivation_date"],
        user: json["user"],
        defaultCompany: json["default_company"],
        companyDiscountPlan: json["company_discount_plan"],
        companyDiscountPlanHolder: json["company_discount_plan_holder"],
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
      );
  factory UserInfoResponse.toClear(Map<String, dynamic> json) =>
      UserInfoResponse(
        id: json[null],
        fullName: json[null],
        firstName: json[null],
        lastName: json[null],
        email: json[null],
        isActive: json[null],
        secondLastName: json[null],
        rut: json[null],
        birthDate: json[null],
        gender: json[null],
        phoneNumber: json[null],
        notes: json[null],
        isSuperadmin: json[null],
        isEmailActivated: json[null],
        isAdministrative: json[null],
        isWarehouse: json[null],
        isSeller: json[null],
        isProfessional: json[null],
        isPatient: json[null],
        patientNotes: json[null],
        companyDiscountPlanPaymentMethod: json[null],
        isPlanActivated: json[null],
        isPlanHolder: json[null],
        isPlanBeneficiary: json[null],
        companyDiscountPlanActivationDate: json[null],
        companyDiscountPlanDeactivationDate: json[null],
        user: json[null],
        defaultCompany: json[null],
        companyDiscountPlan: json[null],
        companyDiscountPlanHolder: json[null],
        addresses: json[null],
      );

  Map<String, dynamic> toClear() => {
        "id": null,
        "full_name": null,
        "first_name": null,
        "last_name": null,
        "email": null,
        "is_active": null,
        "second_last_name": null,
        "rut": null,
        "birth_date": null,
        "gender": null,
        "phone_number": null,
        "notes": null,
        "is_superadmin": null,
        "is_email_activated": null,
        "is_administrative": null,
        "is_warehouse": null,
        "is_seller": null,
        "is_professional": null,
        "is_patient": null,
        "patient_notes": null,
        "company_discount_plan_payment_method": null,
        "is_plan_activated": null,
        "is_plan_holder": null,
        "is_plan_beneficiary": null,
        "company_discount_plan_activation_date": null,
        "company_discount_plan_deactivation_date": null,
        "user": null,
        "default_company": null,
        "company_discount_plan": null,
        "company_discount_plan_holder": null,
        "addresses": null,
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "full_name": fullName,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_active": isActive,
        "second_last_name": secondLastName,
        "rut": rut,
        "birth_date": birthDate,
        "gender": gender,
        "phone_number": phoneNumber,
        "notes": notes,
        "is_superadmin": isSuperadmin,
        "is_email_activated": isEmailActivated,
        "is_administrative": isAdministrative,
        "is_warehouse": isWarehouse,
        "is_seller": isSeller,
        "is_professional": isProfessional,
        "is_patient": isPatient,
        "patient_notes": patientNotes,
        "company_discount_plan_payment_method":
            companyDiscountPlanPaymentMethod,
        "is_plan_activated": isPlanActivated,
        "is_plan_holder": isPlanHolder,
        "is_plan_beneficiary": isPlanBeneficiary,
        "company_discount_plan_activation_date":
            companyDiscountPlanActivationDate,
        "company_discount_plan_deactivation_date":
            companyDiscountPlanDeactivationDate,
        "user": user,
        "default_company": defaultCompany,
        "company_discount_plan": companyDiscountPlan,
        "company_discount_plan_holder": companyDiscountPlanHolder,
        "addresses": addresses,
        // "addresses": List<dynamic>.from(addresses!.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final userUpdate = userUpdateFromMap(jsonString);

class UserUpdate {
  UserUpdate({
    required this.firstName,
    required this.lastName,
    required this.secondLastName,
    required this.email,
    required this.rut,
    required this.phoneNumber,
  });

  String firstName;
  String lastName;
  String secondLastName;
  String email;
  String rut;
  String phoneNumber;

  factory UserUpdate.fromJson(String str) =>
      UserUpdate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserUpdate.fromMap(Map<String, dynamic> json) => UserUpdate(
        firstName: json["first_name"],
        lastName: json["last_name"],
        secondLastName: json["second_last_name"],
        email: json["email"],
        rut: json["rut"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "second_last_name": secondLastName,
        "email": email,
        "rut": rut,
        "phone_number": phoneNumber,
      };
}
