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

//case PENDING = '1'; // قيد المراجعة
//     case PROCESSING = '2'; // جاري التجهيز
//     case READY = '3'; // جاهز للتوصيل
//     case SHIPPING = '4'; // جاري التوصيل
//     case COMPLETED = '5'; // تم التسليم
//     case CANCELED = '6'; // ملغي
//     case PAYMENT_FAILED = '7'; // فشل الدفع
//     case RETURNED = '8'; // تم الارجاع
