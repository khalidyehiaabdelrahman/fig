enum ProfileStatus { loggedOut, loggedIn, signedUp }

class ProfileState {
  final ProfileStatus status;
  final String username;
  final String email;
  final bool isLoading;
  final String? errorMessage;

  ProfileState({
    required this.status,
    required this.username,
    required this.email,
    this.isLoading = false,
    this.errorMessage,
  });

  factory ProfileState.initial() {
    return ProfileState(
      status: ProfileStatus.loggedOut,
      username: '',
      email: '',
      isLoading: false,
      errorMessage: null,
    );
  }

  ProfileState copyWith({
    ProfileStatus? status,
    String? username,
    String? email,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
