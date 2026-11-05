class DossierConfigModel {
  final bool includePartBoxPhotos;
  final bool includeCostTotals;
  final bool watermarkWithVin;
  final String publicSlug;

  const DossierConfigModel({
    this.includePartBoxPhotos = true,
    this.includeCostTotals = true,
    this.watermarkWithVin = true,
    required this.publicSlug,
  });

  String get publicUrl => 'autopassport.am/v/$publicSlug';
}
