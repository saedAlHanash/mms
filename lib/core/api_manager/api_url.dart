class GetUrl {
  static const temp = '';
  static const getHome = 'home';

  //--------------

  static const getAllCourses = 'courses';

  static const getAllLessons = 'lessons';

  static const getAllLessonsFree = 'lessons/free';

  static const getAllSeasons = 'seasons';

  static const getAllSummaries = 'summaries';

  static const getCourseProgress = 'courses/progress-user';
  static const getMe = 'auth/me';

  static const getAllNotifications = 'notifications';

  static const getSocialMedia = 'social-media';

  static const privacyPolicy = 'privacy-policy';

  static const getAnnouncements = 'announcements';

  static const favorite = 'favorites';

  static const productById = 'products';
  static const products = 'products';
  static const search = 'products/search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static const setting = 'settings';

  static const orders = 'orders';

  static const categoryById = 'category';
  static const subCategoryById = 'subCategory';

  static const coupon = 'carts/redeem-coupon';

  static const flashDeals = 'products/flash-deals';

  static const categories = 'categories';
  static const banners = 'ads/banners';
  static const slider = 'ads/sliders';

  static const colors = 'colors';

  static const manufacturers = 'manufacturers';

  static const newArrivalProducts = 'products/new-arrivals';

  static const cart = 'carts';

  static const profile = 'profile';

  static const orderById = 'orders';

  static const subCategories = 'categories/sub';

  static const governors = 'governors';

  static const orderStatus = 'orders/statues';

  static const driverLocation = 'orders/coordinate';

  static const getMessages = 'drivers/messages';

  static const getSupportMessages = 'conversations';

  static const getRoomMessages = 'messages';

  static const faq = 'questions';

  static const termsAndConditions = 'pages';

  static const educationalGrade = 'educational-grade';

  static const myCommittees = 'Committee/GetMyCommittees';

  static const committees = 'Committee/GetAll';

  static const committee = 'Committee/Get';

  static const goal = '';

  static const loggedParty = 'Party/GetLoggedParty';

  static const meeting = 'Meeting/GetDetails';

  static const agenda = '';

  static const agendas = '';

  static const vote = 'Poll/Get';

  static var poll = '';
}

class PostUrl {
  static const votes = 'Poll/GetAll';
  static const addReview = 'reviews';
  static const loginUrl = 'Auth/Authenticate';
  static const signup = 'auth/register';

  static const forgetPassword = 'auth/forget-password';

  static const resetPassword = 'password/reset';

  static const closeVideo = 'lessons/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';

  static const uploadFile = 'FileManager/Upload';

  static const insertCode = 'courses/insert-code';

  static const logout = 'logout';

  static const confirmCode = 'auth/verify-account';

  static const otpPassword = 'password/check';

  static const addFavorite = 'favorites';

  static const restPass = 'reset-password';

  static const createOrder = 'checkout/cash';
  static const createEPaymentOrder = 'checkout/credit';

  static const resendCode = 'auth/resend-verification-code';

  static const addToCart = 'carts';

  static const updateProfile = 'Party/Update';

  static const addSupportMessage = 'messages/add';

  static const loginSocial = 'social/login';
  static const addPhone = 'social/add-phone';

  static const socialVerifyPhone = 'social/verify-phone';

  static const meetings = 'Meeting/GetAll';

  static const addGuest = 'Meeting/AddGuestSuggestion';

  static const addAbsence = 'AbsenceRequest/Add';

  static const addComment = 'AgendaItemComment/Add';

  static const addDiscussionComment = 'DiscussionComment/Add';

  static var notifications = 'Party/GetNotification';

  static var temps = '';

  static var createTemp = '';

  static var createVote = 'Vote/Add';

  static var createPoll = '';

  static var polls = '';

  static String addMessage(int id) {
    return 'drivers/messages/$id/add';
  }

  static String increase(int id) {
    return 'carts/products/$id/quantity/increase';
  }

  static String decrease(int id) {
    return 'carts/products/$id/quantity/decrease';
  }
}

class PutUrl {
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';

  static var updateTemp = '';

  static var updateVote = 'Vote/Update';

  static var updatePoll = '';
}

class DeleteUrl {
  static const removeFavorite = 'favorites';

  static const removeFromCart = 'carts/products';

  static const clearCart = 'carts';

  static var deleteTemp = '';

  static var deleteVote = 'Vote/Delete';

  static var deletePoll = '';
}

const additionalConst = '/api/v1/';
const baseUrl = 'mms.coretech-mena.com';
