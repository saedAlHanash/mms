enum CubitStatuses { init, loading, done, error }

enum AttachmentType { image, youtube, video, d3 }

enum PricingMatrixType { day, date }

enum FilterItem { activity, group, country, city }

enum UpdateType { name, phone, email, address, pass }

enum PaymentMethod { cash, ePay }

enum StartPage { login, home, signupOtp, passwordOtp }

enum CurrencyEnum { dollar, dinar }

enum GenderEnum { male, female }

enum NeedUpdateEnum { no, withLoading, noLoading }

enum UpdateProfileType { normal, confirmAddPhone }

enum OrderStatus {
  pending,
  processing,
  ready,
  shipping,
  completed,
  canceled,
  paymentFailed,
  returned,
}

enum TaskType { plannedTask, meetingTask }

enum PollStatus { open, closed }

enum PartyType { member, guest }

enum MinuteStatus { pending, approved, rejected, published }

enum MembershipType { member, chair, secretary, guest }

enum DiscussionStatus { open, closed }

enum FilterOperation {
  equals('Equals'),
  notEqual('NotEqual'),
  contains('Contains'),
  startsWith('StartsWith'),
  endsWith('EndsWith'),
  lessThan('LessThan'),
  lessThanEqual('LessThanEqual'),
  greaterThan('GreaterThan'),
  greaterThanEqual('GreaterThanEqual');

  const FilterOperation(this.realName);

  final String realName;

}

enum MeetingStatus {
  planned,
  scheduled,
  postponed,
  canceled,
  running,
  completed,
  archived
}
