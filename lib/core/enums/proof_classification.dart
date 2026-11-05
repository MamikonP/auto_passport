enum ProofClassification {
  informalMaster('Informal Master Proof'),
  formalStoreReceipt('Formal Store Receipt');

  final String label;
  const ProofClassification(this.label);

  static ProofClassification fromString(String? val) {
    return ProofClassification.values.firstWhere(
      (p) => p.name.toLowerCase() == val?.toLowerCase() || p.label.toLowerCase() == val?.toLowerCase(),
      orElse: () => ProofClassification.informalMaster,
    );
  }
}
