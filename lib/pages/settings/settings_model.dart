
class SettingsModel {
  final int? mnSettingId;
  final String? szFullName;
  final String? szStreet;
  final String? szPostalCity;
  final double? mnMaxRangeYear;
  SettingsModel({
    this.mnSettingId,
    this.szFullName,
    this.szStreet,
    this.szPostalCity,
    this.mnMaxRangeYear,
  });

  SettingsModel copyWith({
    int? mnSettingId,
    String? szFullName,
    String? szStreet,
    String? szPostalCity,
    double? mnMaxRangeYear,
  }) {
    return SettingsModel(
      mnSettingId: mnSettingId ?? this.mnSettingId,
      szFullName: szFullName ?? this.szFullName,
      szStreet: szStreet ?? this.szStreet,
      szPostalCity: szPostalCity ?? this.szPostalCity,
      mnMaxRangeYear: mnMaxRangeYear ?? this.mnMaxRangeYear,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'szFullName': szFullName,
      'szStreet': szStreet,
      'szPostalCity': szPostalCity,
      'mnMaxRangeYear': mnMaxRangeYear,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      mnSettingId:
          map['mnSettingId'] != null ? map['mnSettingId'] as int : null,
      szFullName:
          map['szFullName'] != null ? map['szFullName'] as String : null,
      szStreet: map['szStreet'] != null ? map['szStreet'] as String : null,
      szPostalCity:
          map['szPostalCity'] != null ? map['szPostalCity'] as String : null,
      mnMaxRangeYear: map['mnMaxRangeYear'] != null
          ? map['mnMaxRangeYear'] as double
          : null,
    );
  }

  @override
  String toString() {
    return 'SettingsModel(mnSettingId: $mnSettingId, szFullName: $szFullName, szStreet: $szStreet, szPostalCity: $szPostalCity, mnMaxRangeYear: $mnMaxRangeYear)';
  }
}
