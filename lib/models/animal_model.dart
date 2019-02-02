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
  final WIDTH faceWidth;
  final LENGTH faceLength;
  final WIDTH noseWidth;
  final LENGTH noseLength;
  final WIDTH lipWidth;
  final LENGTH lipLength; 

  const Animal({
    this.image,
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
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
    return const Animal(
      image: 'assets/images/animals/penguin.jpg',
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