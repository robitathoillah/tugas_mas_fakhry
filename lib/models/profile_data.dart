class ProfileData {
  final String name;
  final String title;
  final String bio;

  const ProfileData({
    required this.name,
    required this.title,
    required this.bio,
  });

  /// Data bawaan saat belum ada data tersimpan.
  static const defaults = ProfileData(
    name: 'Fakhry Firdaus',
    title: 'Software Engineer & Dosen',
    bio: 'Suka membangun aplikasi mobile dan berbagi ilmu.',
  );

  // Konversi Objek ke Map/JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'title': title,
        'bio': bio,
      };

  // Konversi Map/JSON ke Objek
  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        name: json['name'] ?? 'Fakhry Firdaus',
        title: json['title'] ?? 'Software Engineer & Dosen',
        bio: json['bio'] ?? 'Suka membangun aplikasi mobile dan berbagi ilmu.',
      );
}