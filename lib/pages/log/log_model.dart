class LogModel {
  final int? mnLogId;
  final String? szCarModel;
  final DateTime? jdStartDate;
  final DateTime? jdEndDate;
  final double? mnDistanz;
  final String? szRoute;
  final String? szNotiz;
  final String? crateAt;
  LogModel({
    this.mnLogId,
    this.szCarModel,
    this.jdStartDate,
    this.jdEndDate,
    this.mnDistanz,
    this.szRoute,
    this.szNotiz,
    this.crateAt,
  });

  LogModel copyWith({
    int? mnLogId,
    String? szCarModel,
    DateTime? jdStartDate,
    DateTime? jdEndDate,
    double? mnDistanz,
    String? szRoute,
    String? szNotiz,
    String? crateAt,
  }) {
    return LogModel(
      mnLogId: mnLogId ?? this.mnLogId,
      szCarModel: szCarModel ?? this.szCarModel,
      jdStartDate: jdStartDate ?? this.jdStartDate,
      jdEndDate: jdEndDate ?? this.jdEndDate,
      mnDistanz: mnDistanz ?? this.mnDistanz,
      szRoute: szRoute ?? this.szRoute,
      szNotiz: szNotiz ?? this.szNotiz,
      crateAt: crateAt ?? this.crateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'szCarModel': szCarModel,
      'jdStartDate': jdStartDate?.millisecondsSinceEpoch,
      'jdEndDate': jdEndDate?.millisecondsSinceEpoch,
      'mnDistanz': mnDistanz,
      'szRoute': szRoute,
      'szNotiz': szNotiz,
    };
  }

  factory LogModel.fromMap(Map<String, dynamic> map) {
    return LogModel(
      mnLogId: map['mnLogId'] != null ? map['mnLogId'] as int : null,
      szCarModel:
          map['szCarModel'] != null ? map['szCarModel'] as String : null,
      jdStartDate: map['jdStartDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['jdStartDate'] as int)
          : null,
      jdEndDate: map['jdEndDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['jdEndDate'] as int)
          : null,
      mnDistanz: map['mnDistanz'] != null ? map['mnDistanz'] as double : null,
      szRoute: map['szRoute'] != null ? map['szRoute'] as String : null,
      szNotiz: map['szNotiz'] != null ? map['szNotiz'] as String : null,
      crateAt: map['crateAt'] != null ? map['crateAt'] as String : null,
    );
  }

  @override
  String toString() {
    return 'LogModel(mnLogId: $mnLogId, jdStartDate: $jdStartDate, jdEndDate: $jdEndDate, mnDistanz: $mnDistanz, szRoute: $szRoute, szNotiz: $szNotiz, crateAt: $crateAt, szCarModel: $szCarModel)';
  }
}
