class GetProfessionalsLists {
  List<GetProfessionalList> profesionales = [];

  GetProfessionalsLists.fromJsonToList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var element in jsonList) {
      final profesional = GetProfessionalList.fromJsonToMap(element);
      profesionales.add(profesional);
    }
  }
}

class GetProfessionalList {
  GetProfessionalList({
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
  int? phoneNumber;
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

  static GetProfessionalList fromJson(Map<String, dynamic> json) =>
      GetProfessionalList(fullName: json['full_name'], id: json['id']);

  GetProfessionalList.fromJsonToMap(Map<String, dynamic> json) {
    id = json["id"];
    fullName = json["full_name"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    isActive = json["is_active"];
    secondLastName = json["second_last_name"];
    rut = json["rut"];
    birthDate = json["birth_date"];
    gender = json["gender"];
    phoneNumber = json["phone_number"];
    notes = json["notes"];
    isSuperadmin = json["is_superadmin"];
    isEmailActivated = json["is_email_activated"];
    isAdministrative = json["is_administrative"];
    isWarehouse = json["is_warehouse"];
    isSeller = json["is_seller"];
    isProfessional = json["is_professional"];
    isPatient = json["is_patient"];
    patientNotes = json["patient_notes"];
    companyDiscountPlanPaymentMethod =
        json["company_discount_plan_payment_method"];
    isPlanActivated = json["is_plan_activated"];
    isPlanHolder = json["is_plan_holder"];
    isPlanBeneficiary = json["is_plan_beneficiary"];
    companyDiscountPlanActivationDate =
        json["company_discount_plan_activation_date"];
    companyDiscountPlanDeactivationDate =
        json["company_discount_plan_deactivation_date"];
    user = json["user"];
    defaultCompany = json["default_company"];
    companyDiscountPlan = json["company_discount_plan"];
    companyDiscountPlanHolder = json["company_discount_plan_holder"];
    addresses = List<dynamic>.from(json["addresses"].map((x) => x));
  }
}
