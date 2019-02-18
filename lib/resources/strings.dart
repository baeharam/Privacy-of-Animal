// routes 이름
const String routeIntro = '/intro';
const String routeLogin = '/login';
const String routeTagSelect = '/tagSelect';
const String routeTagChat = '/tagChat';
const String routePhoto = '/signUpPhoto';
const String routeAnalyzeIntro = '/analyzeIntro';
const String routeCelebrity = '/analyzeCelebrity';
const String routeRandomLoading = '/randomRandomLoading';
const String routeRandomChat = '/randomRandomChat';

const String routeLoginDecision = '/loginDecision';
const String routeSignUpDecision = '/signUpDecision';
const String routePhotoDecision = '/photoDecision';
const String routeHomeDecision = '/homeDecision';

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
const String signUpEmptyNickNameError = '닉네임을 입력하세요.';
const String signUpNameHint = '본인의 이름을 입력해주세요.';
const String signUpAgeHint = '나이를 설정해주세요.';
const String signUpJobHint = '직업을 입력해주세요.';
const String signUpNickNameHint = '닉네임을 입력해주세요.';
const String signUpEmailHint = '이메일을 입력해주세요.';
const String signUpPasswordHint = '6글자 이상의 비밀번호를 입력해주세요.';
const String signUpAccountFailedTitle = '계정생성 실패!';
const String signUpProfileFailedTitle = '프로필생성 실패!';
const String signUpAccountFailedMessage = '이메일과 비밀번호를\n다시 입력해주세요.';
const String signUpProfileFailedMessage = '프로필을 다시 입력해주세요.';

// TagChatScreen
// 처음 고정 메시지 3개
const List<String> tagChatNPCIntro = [tagChatNPCIntro1,tagChatNPCIntro2,tagChatNPCIntro3];
const String tagChatNPCIntro1 = '안녕! 조금만 더 질문을 할게 ㅎㅎ';
const String tagChatNPCIntro2 = '너의 관심사 매칭을 도와주기 위해서야!';
const String tagChatNPCIntro3 = '최대한 정성껏 대답 부탁해~';

// ProfileScreen
const String profileEmptyTagEditError = '답변을 입력해주세요.';

// 태그 이름
const String movie = '영화';
const String food = '음식';
const String photo = '사진';
const String trip = '여행';
const String book = '독서';
const String sport = '운동';
const String game = '게임';
const String leisure = '레저';
const String celebrity = '연예인';
const String art = '예술';
const String singleLife = '자취';
const String makeup = '메이크업';
const String fashion = '패션';
const String cartoon = '만화';
const String drama = '드라마';
const String music = '음악';

// 태그별 질문 
const String tagMovieMessage = '인생영화가 뭐야?';
const String tagTripMessage = '제일 최근에 가고 싶었던 여행지는?';
const String tagBookMessage = '가장 감명깊게 읽었던 책은?';
const String tagArtMessage = '제일 좋아하는 예술 작품이 뭐야?';
const String tagCartoonMessage = '너를 가슴뛰게 한 만화는?';
const String tagCelebrityMessage = '누구 덕질하고 있어?';
const String tagDramaMessage = '너에게 있어 인생 드라마는?';
const String tagFashionMessage = '가장 좋아하는 데일리룩은?';
const String tagFoodMessage = '가장 좋아하는 음식은?';
const String tagGameMessage = '진짜 이 게임은 최고다하는거 있어?';
const String tagLeisureMessage = '가장 하고 싶은 레저스포츠가 뭐야?';
const String tagMakeupMessage = '가장 좋아하는 화장품 브랜드는?';
const String tagPhotoMessage = '너의 인생사진은 어디서 찍은 사진이야?';
const String tagSingleLifeMessage = '자취 꿀팁은?';
const String tagSportMessage = '가장 즐겨하는 운동은?';
const String tagMusicMessage = '음악 하나 추천해줘!';

// PhotoScreen
const String photoWarningMessage1 = '※ 정면 사진이 아닐시 분석이 안될 수 있습니다.';
const String photoWarningMessage2 = '※ 분석한 후 3일이 지나야 재분석이 가능합니다.';

// API url
const String kakaoAPIurl = 'https://kapi.kakao.com/v1/vision/face/detect';
const String naverFaceAPIurl = 'https://openapi.naver.com/v1/vision/face';
const String naverCelebrityAPIurl = 'https://openapi.naver.com/v1/vision/celebrity';
const String cloudFunctionUrl = 'https://console.firebase.google.com/project/privacy-of-animal-a94e7/overview';

// 동물 이름
const String bisonAnimal = 'bison';
const String buffaloAnimal = 'buffalo';
const String camelAnimal = 'camel';
const String catAnimial = 'cat';
const String cheetahAnimal = 'cheetah';
const String crocodileAnimal = 'crocodile';
const String deerAnimal = 'deer';
const String dolphinAnimal = 'dolphin';
const String duckAnimal = 'duck';
const String eagleAnimal = 'eagle';
const String elephantAnimal = 'elephant';
const String foxAnimal = 'fox';
const String goatAnimal = 'goat';
const String gorillaAnimal = 'gorilla';
const String hippoAnimal = 'hippo';
const String horseAnimal = 'horse';
const String iguanaAnimal = 'iguana';
const String koalaAnimal = 'koala';
const String lamaAnimal = 'lama';
const String lionAnimal = 'lion';
const String monkeyAnimal = 'monkey';
const String owlAnimal = 'owl';
const String parrotAnimal = 'parrot';
const String penguinAnimal = 'penguin';
const String rabbitAnimal = 'rabbit';
const String rhinocerosAnimal = 'rhinoceros';
const String sealAnimal = 'seal';
const String sharkAnimal = 'shark';
const String sheepAnimal = 'sheep';
const String snakeAnimal = 'snake';
const String tigerAnimal = 'tiger';
const String whaleAnimal = 'whale';
const String zebraAnimal = 'zebra';


// Cloud Firestore 컬렉션 이름
const String firestoreUsersCollection = 'users';
const String firestoreRandomChatCollection = 'random_chat';
const String firestoreDeletedUserListCollection = 'deleted_user_list';
const String firestoreRandomMessageCollection = 'random_messages';
const String firestoreFriendsMessageCollection = friendsMessagesTable;

// Cloud Firestore 서브 컬렉션 이름
const String firestoreFriendsSubCollection = 'friends';

// Cloud Firestore 친구 필드
const String firestoreFriendsField = 'is_friends';

// Cloud Firestore 실제 프로필 필드
const String firestoreRealProfileField = realProfileTable;
const String firestoreAgeField = ageCol;
const String firestoreGenderField = genderCol;
const String firestoreJobField = jobCol;
const String firestoreNameField = nameCol;

// Cloud Firestore 가상 프로필 필드
const String firestoreFakeProfileField = fakeProfileTable;
const String firestoreFakeGenderField = fakeGenderCol;
const String firestoreFakeGenderConfidenceField = fakeGenderConfidenceCol;
const String firestoreFakeAgeField = fakeAgeCol;
const String firestoreFakeAgeConfidenceField = fakeAgeConfidenceCol;
const String firestoreFakeEmotionField = fakeEmotionCol;
const String firestoreFakeEmotionConfidenceField = fakeEmotionConfidenceCol;
const String firestoreAnimalNameField = animalNameCol;
const String firestoreAnimalImageField = animalImageCol;
const String firestoreAnimalConfidenceField = animalConfidenceCol;
const String firestoreNickNameField = nickNameCol;
const String firestoreCelebrityField = celebrityCol;
const String firestoreCelebrityConfidenceField = celebrityConfidenceCol;
const String firestoreAnalyzedTimeField = analyzedTimeCol;

// Cloud Firestore 플래그 필드
const String firestoreIsTagSelectedField = isTagSelected;
const String firestoreIsTagChattedField = isTagChatted;
const String firestoreIsFaceAnalyzedField = isFaceAnalyzed;

// Cloud Firestore 태그 필드
const String firestoreTagField = tagTable;
const String firestoreTagTitle1Field = tagName1Col;
const String firestoreTagTitle2Field = tagName2Col;
const String firestoreTagTitle3Field = tagName3Col;
const String firestoreTagTitle4Field = tagName4Col;
const String firestoreTagTitle5Field = tagName5Col;
const List<String> firestoreTagTitleList = tagTitleList;

const String firestoreTagDetail1Field = tagDetail1Col;
const String firestoreTagDetail2Field = tagDetail2Col;
const String firestoreTagDetail3Field = tagDetail3Col;
const String firestoreTagDetail4Field = tagDetail4Col;
const String firestoreTagDetail5Field = tagDetail5Col;
const List<String> firestoreTagDetailList = tagDetailList;

// Cloud Firestore 랜덤 메시지 필드
const String firestoreChatBeginField = 'begin';
const String firestoreChatUsersField = 'users';
const String firestoreChatOutField = 'out';
const String firestoreChatFromField = fromCol;
const String firestoreChatToField = toCol;
const String firestoreChatContentField = contentCol;
const String firestoreChatTimestampField = timeStampCol;

// Cloud Firestore 친구 메시지 필드
const String firestoreChatDeleteField = 'delete';

// SharedPreferences 플래그 key값
const String isTagSelected = 'is_tag_selected';
const String isTagChatted = 'is_tag_chatted';
const String isFaceAnalyzed = 'is_face_analyzed';

// 로컬 DB 이름
const String userDB = 'user.db';

// 테이블 이름
const String tagTable = 'tags';
const String realProfileTable = 'real_profile';
const String fakeProfileTable = 'fake_profile';
const String celebrityUrlTable = 'celebrity_url';
const String friendsMessagesTable = 'friends_messages';

// 테이블 3개의 각 컬럼 이름
// 공통 컬럼
const String id = 'id';
const String uidCol = 'uid';

// 태그 테이블
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
const List<String> tagTitleList = [tagName1Col,tagName2Col,tagName3Col,tagName4Col,tagName5Col];
const List<String> tagDetailList = [tagDetail1Col,tagDetail2Col,tagDetail3Col,tagDetail4Col,tagDetail5Col];

// 실제 프로필 테이블
const String nameCol = 'name';
const String genderCol = 'gender';
const String ageCol = 'age';
const String jobCol = 'job';

// 가상 프로필 테이블
const String fakeGenderCol = 'fake_gender';
const String fakeGenderConfidenceCol = 'fake_gender_confidence';
const String fakeAgeCol = 'fake_age';
const String fakeAgeConfidenceCol = 'fake_age_confidence';
const String fakeEmotionCol = 'fake_emotion';
const String fakeEmotionConfidenceCol = 'fake_emotion_confidence';
const String animalNameCol = 'animal_name';
const String animalImageCol = 'animal_image';
const String animalConfidenceCol = 'animal_confidence';
const String nickNameCol = 'nick_name';
const String celebrityCol = 'celebrity';
const String celebrityConfidenceCol = 'celebrity_confidence';
const String analyzedTimeCol = 'analyzed_time';

// 채팅 내용 테이블
const String fromCol = 'from';
const String toCol = 'to';
const String timeStampCol = 'timestamp';
const String contentCol = 'content';

// 태그 테이블 생성하는 SQL
const String tagTableCreationSQL = 
  'CREATE TABLE $tagTable '
  '($id INTEGER PRIMARY KEY AUTOINCREMENT,'
  '$uidCol TEXT,'
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
  'CREATE TABLE $realProfileTable'
  '($id INTEGER PRIMARY KEY AUTOINCREMENT,'
  '$uidCol TEXT, $nameCol TEXT, $genderCol TEXT, $ageCol TEXT, $jobCol TEXT)';


// 가상 프로필 테이블 생성하는 SQL  
const String fakeProfileTableCreationSQL = 
  'CREATE TABLE $fakeProfileTable'
  '($id INTEGER PRIMARY KEY AUTOINCREMENT,'
  '$uidCol TEXT, $nickNameCol TEXT, $fakeGenderCol TEXT, $fakeGenderConfidenceCol REAL, '
  '$fakeAgeCol TEXT, $fakeAgeConfidenceCol REAL, '
  '$fakeEmotionCol TEXT, $firestoreFakeEmotionConfidenceField REAL, '
  '$animalNameCol TEXT, $animalImageCol TEXT, $animalConfidenceCol REAL, '
  '$celebrityCol TEXT, $celebrityConfidenceCol REAL, $analyzedTimeCol INTEGER)';

// 채팅 테이블 생성하는 SQL
const String friendsMessagesCreationSQL = 
  'CREATE TABLE $friendsMessagesTable'
  '($id INTEGER PRIMARY KEY AUTOINCREMENT,'
  '$fromCol TEXT, $toCol TEXT, $timeStampCol INTEGER, $contentCol TEXT)';