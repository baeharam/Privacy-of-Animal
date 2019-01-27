
class Animal {
  final String image;
  final WIDTH faceWidth;
  final LENGTH faceLength;
  final WIDTH noseWidth;
  final LENGTH noseLength;
  final WIDTH lipWidth;
  final LENGTH lipLength; 

  Animal({
    this.image,
    this.faceWidth,
    this.faceLength,
    this.noseWidth,
    this.noseLength,
    this.lipWidth,
    this.lipLength
  });

  factory Animal.dog() {
    return Animal(
      image: 'assets/images/animals/dog.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.turtle() {
    return Animal(
      image: 'assets/images/animals/turtle.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.gorilla() {
    return Animal(
      image: 'assets/images/animals/gorilla.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.dolphin() {
    return Animal(
      image: 'assets/images/animals/dolphin.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.bison() {
    return Animal(
      image: 'assets/images/animals/bison.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.owl() {
    return Animal(
      image: 'assets/images/animals/owl.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.lion() {
    return Animal(
      image: 'assets/images/animals/lion.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.shark() {
    return Animal(
      image: 'assets/images/animals/shark.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.buffalo() {
    return Animal(
      image: 'assets/images/animals/buffalo.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.crocodile() {
    return Animal(
      image: 'assets/images/animals/crocodile.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.sheep() {
    return Animal(
      image: 'assets/images/animals/sheep.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.elephant() {
    return Animal(
      image: 'assets/images/animals/elephant.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.rhinoceros() {
    return Animal(
      image: 'assets/images/animals/rhinoceros.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.hippo() {
    return Animal(
      image: 'assets/images/animals/hippo.jpg',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.pig() {
    return Animal(
      image: 'assets/images/animals/pig.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.lama() {
    return Animal(
      image: 'assets/images/animals/shark.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.seal() {
    return Animal(
      image: 'assets/images/animals/seal.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.deer() {
    return Animal(
      image: 'assets/images/animals/deer.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.fox() {
    return Animal(
      image: 'assets/images/animals/fox.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.goat() {
    return Animal(
      image: 'assets/images/animals/goat.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.cheetah() {
    return Animal(
      image: 'assets/images/animals/cheetah.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.koala() {
    return Animal(
      image: 'assets/images/animals/koala.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.rabbit() {
    return Animal(
      image: 'assets/images/animals/rabbit.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.tiger() {
    return Animal(
      image: 'assets/images/animals/tiger.jpg',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.cat() {
    return Animal(
      image: 'assets/images/animals/cat.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.camel() {
    return Animal(
      image: 'assets/images/animals/camel.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.eagle() {
    return Animal(
      image: 'assets/images/animals/eagle.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.horse() {
    return Animal(
      image: 'assets/images/animals/horse.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.snake() {
    return Animal(
      image: 'assets/images/animals/snake.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.parrot() {
    return Animal(
      image: 'assets/images/animals/parrot.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }

  factory Animal.zebra() {
    return Animal(
      image: 'assets/images/animals/zebra.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.duck() {
    return Animal(
      image: 'assets/images/animals/duck.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }

  factory Animal.monkey() {
    return Animal(
      image: 'assets/images/animals/monkey.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.iguana() {
    return Animal(
      image: 'assets/images/animals/iguana.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }

  factory Animal.penguin() {
    return Animal(
      image: 'assets/images/animals/penguin.jpg',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
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