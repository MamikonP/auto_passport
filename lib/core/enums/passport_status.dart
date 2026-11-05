enum PassportStatus {
  verified,
  pending,
  expired;

  String get label => switch (this) {
        PassportStatus.verified => 'Verified',
        PassportStatus.pending => 'Pending',
        PassportStatus.expired => 'Expired',
      };
}
