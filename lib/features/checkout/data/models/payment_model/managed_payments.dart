class ManagedPayments {
  bool? enabled;

  ManagedPayments({this.enabled});

  factory ManagedPayments.fromJson(Map<String, dynamic> json) {
    return ManagedPayments(enabled: json['enabled'] as bool?);
  }

  Map<String, dynamic> toJson() => {'enabled': enabled};
}
