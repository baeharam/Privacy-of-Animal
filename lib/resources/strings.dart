// routes 이름
const String routeIntro = '/intro';
const String routeLogin = '/login';
const String routeTagSelect = '/tagSelect';
const String routeTagChat = '/tagChat';
const String routeLoginDecision = '/loginDecision';
const String routeSignUpDecision = '/signUpDecision';

// IntroScreen
const String introMessage1Above = '내 얼굴 사진을 바탕으로';
const String introMessage1Below = '분석되는 \"닮은꼴 동물\"';
const String introMessage2Above = '내 관심사를 바탕으로';
const String introMessage2Below = '비슷한 취향 상대방 연결!';
const String introMessage3Above = '가상에서 뿐만 아니라';
const String introMessage3Below = '실제 친구가 될 수 있는 채팅';

// LoginScreen
const String loginEmptyEmailError = '이메일을 입력하세요.';
const String loginInvalidEmailError = '유효한 이메일이 아닙니다.';
const String loginEmptyPasswordError = '비밀번호를 입력하세요.';
const String loginInavlidPasswordError = '비밀번호는 6자리 이상입니다';
const String loginError = '로그인에 실패했습니다.';
const String loginEmailSendError = '이메일 전송에 실패했습니다.';
const String loginEmailSendSuccess = '이메일 전송에 성공했습니다.';

// FindPasswordDialog
const String findPasswordMessage = '등록된 이메일을 입력해주시면\n비밀번호를 재설정 할 수 있는\n이메일을 보내드립니다.';

// SignUpScreen
const String signUpEmptyNameError = '이름을 입력하세요.';
const String signUpInvalidNameError = '이름을 제대로 입력해주세요.';
const String signUpEmptyAgeError = '나이를 입력하세요.';
const String signUpEmptyJobError = '직업을 입력하세요.';
const String signUpInvalidJobError = '직업을 제대로 입력해주세요.';
const String signUpNameHint = '본인의 이름을 입력해주세요.';
const String signUpAgeHint = '나이를 설정해주세요.';
const String signUpJobHint = '직업을 입력해주세요.';
const String signUpEmailHint = '이메일을 입력해주세요.';
const String signUpPasswordHint = '6글자 이상의 비밀번호를 입력해주세요.';
const String signUpAccountFailedTitle = '계정생성 실패!';
const String signUpProfileFailedTitle = '프로필생성 실패!';
const String signUpAccountFailedMessage = '이메일과 비밀번호를\n다시 입력해주세요.';
const String signUpProfileFailedMessage = '프로필을 다시 입력해주세요.';

// Cloud Firestore 컬렉션 이름
const String firestoreUsersCollection = 'users';

// Cloud Firestore 실제 프로필 필드
const String firestoreRealProfileField = 'real_profile';
const String firestoreAgeField = 'age';
const String firestoreGenderField = 'gender';
const String firestoreJobField = 'job';
const String firestoreNameField = 'name';

// Cloud Firestore 플래그 필드
const String firestoreIsTagSelectedField = 'is_tag_selected';
const String firestoreIsTagChattedField = 'is_tag_chatted';
const String firestoreIsFaceAnalyzedField = 'is_face_analyzed';

// Cloud Firestore 태그 필드
const String firestoreTagField = 'tags';
const String firestoreTagTitle1Field = 'tag_title_1';
const String firestoreTagTitle2Field = 'tag_title_2';
const String firestoreTagTitle3Field = 'tag_title_3';
const String firestoreTagTitle4Field = 'tag_title_4';
const String firestoreTagTitle5Field = 'tag_title_5';


// 로컬 DB 이름
const String userDB = 'user.db';

// 태그 이름
const String movie = 'movie';
const String food = 'food';
const String photo = 'photo';
const String trip = 'trip';
const String book = 'book';
const String sport = 'sport';
const String game = 'game';
const String leisure = 'leisure';
const String celebrity = 'celebrity';
const String art = 'art';
const String singleLif = 'single_life';
const String makeup = 'make_up';
const String fashion = 'fashion';
const String cartoon = 'cartoon';
const String drama = 'drama';

// 테이블 3개에 대한 컬럼이름
const String uidCol = 'uid';
const String tagName1Col = 'tag_name_1';
const String tagDetail1Col = 'tag_detail_1';
const String tagName2Col = 'tag_name_2';
const String tagDetail2Col = 'tag_detail_2';
const String tagName3Col = 'tag_name_3';
const String tagDetail3Col = 'tag_detail_3';
const String tagName4Col = 'tag_name_4';
const String tagDetail4Col = 'tag_detail_4';
const String tagName5Col = 'tag_name_5';
const String tagDetail5Col = 'tag_detail_5';
const String nameCol = 'name';
const String genderCol = 'gender';
const String ageCol = 'age';
const String jobCol = 'job';
const String imgCol = 'image';
const String animalNameCol = 'animal_name';
const String emotionCol = 'emotion';
const String animalConfidenceCol = 'animal_confidence';
const String genderConfidenceCol = 'gender_confidence';
const String emotionConfidenceCol = 'emotion_confidence';
const String ageConfidenceCol = 'age_confidence';

// 태그 테이블 생성하는 SQL
const String tagTableCreationSQL = 
  'CREATE TABLE tag_table '
  '($uidCol TEXT PRIMARY KEY,'
  '$tagName1Col TEXT,'
  '$tagDetail1Col TEXT,'
  '$tagName2Col TEXT,'
  '$tagDetail2Col TEXT,'
  '$tagName3Col TEXT,'
  '$tagDetail3Col TEXT,'
  '$tagName4Col TEXT,'
  '$tagDetail4Col TEXT,'
  '$tagName5Col TEXT,'
  '$tagDetail5Col TEXT)';

// 실제 프로필 테이블 생성하는 SQL
const String realProfileTableCreationSQL = 
  'CREATE TABLE real_profile_table'
  '($uidCol TEXT PRIMARY KEY, $nameCol TEXT, $genderCol TEXT, $ageCol INTEGER, $jobCol TEXT)';


// 가상 프로필 테이블 생성하는 SQL  
const String fakeProfileTableCreationSQL = 
  'CREATE TABLE fake_profile_table'
  '($uidCol TEXT PRIMARY KEY, $nameCol TEXT, $imgCol TEXT, $animalNameCol, $genderCol TEXT, $ageCol INTEGER, $emotionCol TEXT,'
  '$animalConfidenceCol REAL, $genderConfidenceCol REAL, $emotionConfidenceCol REAL, $ageConfidenceCol REAL';