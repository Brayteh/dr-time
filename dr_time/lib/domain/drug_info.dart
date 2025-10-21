class DrugInfo {
  final String brandName;
  final String genericName;
  final String? manufacturerName;
  final String? productType;
  final List<String> indicationsAndUsage;

  DrugInfo({
    required this.brandName,
    required this.genericName,
    this.manufacturerName,
    this.productType,
    this.indicationsAndUsage = const [],
  });

  factory DrugInfo.fromJson(Map<String, dynamic> json) {
    final openfda = json['openfda'] as Map<String, dynamic>?;
    final brandNameList = openfda?['brand_name'] as List<dynamic>?;
    final genericNameList = openfda?['generic_name'] as List<dynamic>?;
    final manufacturerNameList = openfda?['manufacturer_name'] as List<dynamic>?;
    final productTypeList = openfda?['product_type'] as List<dynamic>?;
    final indicationsList = json['indications_and_usage'] as List<dynamic>?;

    return DrugInfo(
      brandName: brandNameList != null && brandNameList.isNotEmpty ? brandNameList[0].toString() : 'N/A',
      genericName: genericNameList != null && genericNameList.isNotEmpty ? genericNameList[0].toString() : 'N/A',
      manufacturerName: manufacturerNameList != null && manufacturerNameList.isNotEmpty ? manufacturerNameList[0].toString() : null,
      productType: productTypeList != null && productTypeList.isNotEmpty ? productTypeList[0].toString() : null,
      indicationsAndUsage: indicationsList != null ? List<String>.from(indicationsList.map((e) => e.toString())) : [],
    );
  }
}