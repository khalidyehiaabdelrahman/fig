enum ProfileStatus { loggedOut, loggedIn }

class ProfileState {
  final ProfileStatus status;
  final String username;
  final String email;

  ProfileState({
    required this.status,
    required this.username,
    required this.email,
  });

  factory ProfileState.initial() {
    return ProfileState(
      status: ProfileStatus.loggedOut,
      username: '',
      email: '',
    );
  }

  ProfileState copyWith({
    ProfileStatus? status,
    String? username,
    String? email,
  }) {
    return ProfileState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }
}
