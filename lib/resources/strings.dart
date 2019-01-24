// intro_screen
const String introMessage1Above = '내 얼굴 사진을 바탕으로';
const String introMessage1Below = '분석되는 \"닮은꼴 동물\"';
const String introMessage2Above = '내 관심사를 바탕으로';
const String introMessage2Below = '비슷한 취향 상대방 연결!';
const String introMessage3Above = '가상에서 뿐만 아니라';
const String introMessage3Below = '실제 친구가 될 수 있는 채팅';

// 로컬 DB
const String userDB = 'user.db';
const String tagTableCreationSQL = 
  'CREATE TABLE tag_table (uid TEXT PRIMARY KEY, movie TEXT, food TEXT)';
const String realProfileTableCreationSQL = 
  'CREATE TABLE real_profile_table'
  '(uid TEXT PRIMARY KEY, name TEXT, gender TEXT, age INTEGER, job TEXT)';
const String fakeProfileTableCreationSQL = 
  'CREATE TABLE fake_profile_table'
  '(uid TEXT PRIMARY KEY, name TEXT, image TEXT, animal_name, gender TEXT, age INTEGER, emotion TEXT,'
  'animal_confidence DOUBLE, gender_confidence DOUBLE, emotion_confidence, age_confidence';
