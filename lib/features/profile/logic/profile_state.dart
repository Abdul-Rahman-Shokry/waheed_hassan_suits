sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileGuest extends ProfileState {
  const ProfileGuest();
}

class ProfileAuthenticated extends ProfileState {
  const ProfileAuthenticated();
}

class ProfileLoggingOut extends ProfileState {
  const ProfileLoggingOut();
}

class ProfileLogoutSuccess extends ProfileState {
  const ProfileLogoutSuccess();
}

class ProfileLogoutFailed extends ProfileState {
  final String message;

  const ProfileLogoutFailed(this.message);
}

class ProfileDeletingAccount extends ProfileState {
  const ProfileDeletingAccount();
}

class ProfileDeleteAccountSuccess extends ProfileState {
  const ProfileDeleteAccountSuccess();
}

class ProfileDeleteAccountFailed extends ProfileState {
  final String message;

  const ProfileDeleteAccountFailed(this.message);
}