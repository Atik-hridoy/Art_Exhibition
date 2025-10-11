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
