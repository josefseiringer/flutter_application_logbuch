class CarModel {
  final int? mnCarId;
  final String? szCarMarke;
  final String? szCarModel;
  final String? szCarKennzeichen;
  final String? szCarFahrgestellnummer;
  final String? szCarZulassungsbesitzer;
  final String? szCarErstzulassung;
  final String? crateAt;
  CarModel({
    this.mnCarId,
    this.szCarMarke,
    this.szCarModel,
    this.szCarKennzeichen,
    this.szCarFahrgestellnummer,
    this.szCarZulassungsbesitzer,
    this.szCarErstzulassung,
    this.crateAt,
  });

  CarModel copyWith({
    int? mnCarId,
    String? szCarMarke,
    String? szCarModel,
    String? szCarKennzeichen,
    String? szcarFahrgestellnummer,
    String? szCarZulassungsbesitzer,
    String? szCarErstzulassung,
    String? crateAt,
  }) {
    return CarModel(
      mnCarId: mnCarId ?? this.mnCarId,
      szCarMarke: szCarMarke ?? this.szCarMarke,
      szCarModel: szCarModel ?? this.szCarModel,
      szCarKennzeichen: szCarKennzeichen ?? this.szCarKennzeichen,
      szCarFahrgestellnummer: szcarFahrgestellnummer ?? szCarFahrgestellnummer,
      szCarZulassungsbesitzer:
          szCarZulassungsbesitzer ?? this.szCarZulassungsbesitzer,
      szCarErstzulassung: szCarErstzulassung ?? this.szCarErstzulassung,
      crateAt: crateAt ?? this.crateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'szCarMarke': szCarMarke,
      'szCarModel': szCarModel,
      'szCarKennzeichen': szCarKennzeichen,
      'szcarFahrgestellnummer': szCarFahrgestellnummer,
      'szCarZulassungsbesitzer': szCarZulassungsbesitzer,
      'szCarErstzulassung': szCarErstzulassung,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      mnCarId: map['mnCarId'] != null ? map['mnCarId'] as int : null,
      szCarMarke:
          map['szCarMarke'] != null ? map['szCarMarke'] as String : null,
      szCarModel:
          map['szCarModel'] != null ? map['szCarModel'] as String : null,
      szCarKennzeichen: map['szCarKennzeichen'] != null
          ? map['szCarKennzeichen'] as String
          : null,
      szCarFahrgestellnummer: map['szcarFahrgestellnummer'] != null
          ? map['szcarFahrgestellnummer'] as String
          : null,
      szCarZulassungsbesitzer: map['szCarZulassungsbesitzer'] != null
          ? map['szCarZulassungsbesitzer'] as String
          : null,
      szCarErstzulassung: map['szCarErstzulassung'] != null
          ? map['szCarErstzulassung'] as String
          : null,
      crateAt: map['crateAt'] != null ? map['crateAt'] as String : null,
    );
  }

  @override
  String toString() {
    return 'CarModel(mnCarId: $mnCarId, szCarMarke: $szCarMarke, szCarModel: $szCarModel, szCarKennzeichen: $szCarKennzeichen, szcarFahrgestellnummer: $szCarFahrgestellnummer, szCarZulassungsbesitzer: $szCarZulassungsbesitzer, szCarErstzulassung: $szCarErstzulassung, crateAt: $crateAt)';
  }
}
