enum Status { loading, error, completed }

enum Role {
  user('USER'),
  artist('ARTIST'),
  collector('COLLECTOR'),
  curator('CURATOR'),
  museum('MUSEUM'),
  educational('EDUCATIONAL_INSTITUTE');

  final String role;

  const Role(this.role);
}

enum ArtStatus {
  unique('Unique'),
  resale('Resale');

  final String value;

  const ArtStatus(this.value);
}

enum SaveType {
  arts('Arts'),
  event('Event'),
  exhibition('Exhibition'),
  learning('Learning');

  final String value;

  const SaveType(this.value);
}
