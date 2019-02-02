List<Animal> animalList = [
  Animal.bison(),
  Animal.buffalo(),
  Animal.camel(),
  Animal.cat(),
  Animal.cheetah(),
  Animal.crocodile(),
  Animal.deer(),
  Animal.dolphin(),
  Animal.duck(),
  Animal.duck(),
  Animal.eagle(),
  Animal.elephant(),
  Animal.fox(),
  Animal.goat(),
  Animal.gorilla(),
  Animal.hippo(),
  Animal.horse(),
  Animal.iguana(),
  Animal.koala(),
  Animal.lama(),
  Animal.lion(),
  Animal.monkey(),
  Animal.owl(),
  Animal.parrot(),
  Animal.penguin(),
  Animal.pig(),
  Animal.rabbit(),
  Animal.rhinoceros(),
  Animal.seal(),
  Animal.shark(),
  Animal.sheep(),
  Animal.tiger(),
  Animal.turtle(),
  Animal.whale(),
  Animal.zebra()
];

class Animal {
  final String image;
  final String name;
  final WIDTH faceWidth;
  final LENGTH faceLength;
  final WIDTH noseWidth;
  final LENGTH noseLength;
  final WIDTH lipWidth;
  final LENGTH lipLength; 

  const Animal({
    this.image,
    this.name,
    this.faceWidth,
    this.faceLength,
    this.noseWidth,
    this.noseLength,
    this.lipWidth,
    this.lipLength
  });

  factory Animal.dog() {
    return const Animal(
      image: 'assets/images/animals/dog.jpg',
      name: '개',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.turtle() {
    return const Animal(
      image: 'assets/images/animals/turtle.jpg',
      name: '거북이',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.gorilla() {
    return const Animal(
      image: 'assets/images/animals/gorilla.jpg',
      name: '고릴라',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.dolphin() {
    return const Animal(
      image: 'assets/images/animals/dolphin.jpg',
      name: '돌고래',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.bison() {
    return const Animal(
      image: 'assets/images/animals/bison.jpg',
      name: '들소',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.owl() {
    return const Animal(
      image: 'assets/images/animals/owl.jpg',
      name: '부엉이',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.lion() {
    return const Animal(
      image: 'assets/images/animals/lion.jpg',
      name: '사자',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.shark() {
    return const Animal(
      image: 'assets/images/animals/shark.jpg',
      name: '상어',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.buffalo() {
    return const Animal(
      image: 'assets/images/animals/buffalo.jpg',
      name: '버팔로',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.crocodile() {
    return const Animal(
      image: 'assets/images/animals/crocodile.jpg',
      name: '악어',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.sheep() {
    return const Animal(
      image: 'assets/images/animals/sheep.jpg',
      name: '양',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.elephant() {
    return const Animal(
      image: 'assets/images/animals/elephant.jpg',
      name: '코끼리',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.rhinoceros() {
    return const Animal(
      image: 'assets/images/animals/rhinoceros.jpg',
      name: '코뿔소',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.hippo() {
    return const Animal(
      image: 'assets/images/animals/hippo.jpg',
      name: '하마',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.pig() {
    return const Animal(
      image: 'assets/images/animals/pig.jpg',
      name: '돼지',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.lama() {
    return const Animal(
      image: 'assets/images/animals/lama.jpg',
      name: '라마',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.seal() {
    return const Animal(
      image: 'assets/images/animals/seal.jpg',
      name: '물개',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.deer() {
    return const Animal(
      image: 'assets/images/animals/deer.jpg',
      name: '사슴',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.fox() {
    return const Animal(
      image: 'assets/images/animals/fox.jpg',
      name: '여우',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.goat() {
    return const Animal(
      image: 'assets/images/animals/goat.jpg',
      name: '염소',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.cheetah() {
    return const Animal(
      image: 'assets/images/animals/cheetah.jpg',
      name: '치타',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.koala() {
    return const Animal(
      image: 'assets/images/animals/koala.jpg',
      name: '코알라',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.rabbit() {
    return const Animal(
      image: 'assets/images/animals/rabbit.jpg',
      name: '토끼',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.tiger() {
    return const Animal(
      image: 'assets/images/animals/tiger.jpg',
      name: '호랑이',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.cat() {
    return const Animal(
      image: 'assets/images/animals/cat.jpg',
      name: '고양이',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.camel() {
    return const Animal(
      image: 'assets/images/animals/camel.jpg',
      name: '낙타',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.eagle() {
    return const Animal(
      image: 'assets/images/animals/eagle.jpg',
      name: '독수리',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.horse() {
    return const Animal(
      image: 'assets/images/animals/horse.jpg',
      name: '말',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.snake() {
    return const Animal(
      image: 'assets/images/animals/snake.jpg',
      name: '뱀',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.parrot() {
    return const Animal(
      image: 'assets/images/animals/parrot.jpg',
      name: '앵무새',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.zebra() {
    return const Animal(
      image: 'assets/images/animals/zebra.jpg',
      name: '얼룩말',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.duck() {
    return const Animal(
      image: 'assets/images/animals/duck.jpg',
      name: '오리',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.monkey() {
    return const Animal(
      image: 'assets/images/animals/monkey.jpg',
      name: '원숭이',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.iguana() {
    return const Animal(
      image: 'assets/images/animals/iguana.jpg',
      name: '이구아나',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.penguin() {
    return const Animal(
      image: 'assets/images/animals/penguin.jpg',
      name: '펭귄',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.whale() {
    return const Animal(
      image: 'assets/images/animals/whale.jpg',
      name: '고래',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  }
}



enum WIDTH {
  WIDE,
  NORMAL,
  NARROW
}

enum LENGTH {
  LONG,
  NORMAL,
  SHORT
}