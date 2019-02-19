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
  Animal.zebra(),
  Animal.alpaca(),
  Animal.antelope(),
  Animal.armadillo(),
  Animal.baboon(),
  Animal.beagle(),
  Animal.brownbear(),
  Animal.bulldog(),
  Animal.catfish(),
  Animal.dachshund(),
  Animal.donkey(),
  Animal.elephantseal(),
  Animal.eurasianlynx(),
  Animal.gazelle(),
  Animal.giraffe(),
  Animal.goose(),
  Animal.hammerheadshark(),
  Animal.kangarro(),
  Animal.lemurmonkey(),
  Animal.meerkat(),
  Animal.otter(),
  Animal.polarbear(),
  Animal.polarfox(),
  Animal.quokka(),
  Animal.skunk(),
  Animal.sloth(),
  Animal.snowrabbit(),
  Animal.squirrel(),
  Animal.swan(),
  Animal.toad(),
  Animal.weasel(),
  Animal.wolf()
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

  factory Animal.alpaca() {
    return const Animal(
      image: 'assets/images/animals/alpaca.jpg',
      name: '알파카',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.antelope() {
    return const Animal(
      image: 'assets/images/animals/antelopes.jpg',
      name: '영양',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.armadillo() {
    return const Animal(
      image: 'assets/images/animals/armadillo.jpg',
      name: '아르마딜로',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.baboon() {
    return const Animal(
      image: 'assets/images/animals/baboon.jpg',
      name: '개코원숭이',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.beagle() {
    return const Animal(
      image: 'assets/images/animals/beagle.jpg',
      name: '비글',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  } 
  factory Animal.brownbear() {
    return const Animal(
      image: 'assets/images/animals/brownbear.jpg',
      name: '불곰',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.bulldog() {
    return const Animal(
      image: 'assets/images/animals/bulldog.jpg',
      name: '불독',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }
  factory Animal.catfish() {
    return const Animal(
      image: 'assets/images/animals/catfish.jpg',
      name: '잉어',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.dachshund() {
    return const Animal(
      image: 'assets/images/animals/dachshund.jpg',
      name: '닥스훈트',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.donkey() {
    return const Animal(
      image: 'assets/images/animals/donkey.jpg',
      name: '당나귀',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.elephantseal() {
    return const Animal(
      image: 'assets/images/animals/elephantseal.jpg',
      name: '바다코끼리',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.eurasianlynx() {
    return const Animal(
      image: 'assets/images/animals/eurasianlynx.jpg',
      name: '스라소니',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.gazelle() {
    return const Animal(
      image: 'assets/images/animals/gazelle.jpg',
      name: '가젤',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.giraffe() {
    return const Animal(
      image: 'assets/images/animals/giraffe.jpg',
      name: '기린',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.goose() {
    return const Animal(
      image: 'assets/images/animals/goose.jpg',
      name: '거위',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.hammerheadshark() {
    return const Animal(
      image: 'assets/images/animals/hammerheadshark.jpg',
      name: '귀상어',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.SHORT
    );
  }
  factory Animal.kangarro() {
    return const Animal(
      image: 'assets/images/animals/kangarro.jpg',
      name: '캥거루',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.WIDE,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.lemurmonkey() {
    return const Animal(
      image: 'assets/images/animals/lemurmonkey.jpg',
      name: '여우원숭이',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.meerkat() {
    return const Animal(
      image: 'assets/images/animals/meerkat.jpg',
      name: '미어캣', 
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }
  factory Animal.otter() {
    return const Animal(
      image: 'assets/images/animals/otter.jpg',
      name: '수달',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.SHORT
    );
  }
  factory Animal.polarbear() {
    return const Animal(
      image: 'assets/images/animals/polarbear.jpg',
      name: '북극곰',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.polarfox() {
    return const Animal(
      image: 'assets/images/animals/polarfox.jpg',
      name: '북극여우',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.SHORT,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.quokka() {
    return const Animal(
      image: 'assets/images/animals/quokka.jpg',
      name: '쿼카',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.raccoon() {
    return const Animal(
      image: 'assets/images/animals/raccoon.jpg',
      name: '라쿤',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.skunk() {
    return const Animal(
      image: 'assets/images/animals/skunk.jpg',
      name: '스컹크',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.sloth() {
    return const Animal(
      image: 'assets/images/animals/sloth.jpg',
      name: '나무늘보',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NORMAL,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.snowrabbit() {
    return const Animal(
      image: 'assets/images/animals/snowrabbit.jpg',
      name: '눈토끼',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.squirrel() {
    return const Animal(
      image: 'assets/images/animals/squirrel.jpg',
      name: '다람쥐',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NARROW,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.swan() {
    return const Animal(
      image: 'assets/images/animals/swan.jpg',
      name: '백조',
      faceWidth: WIDTH.NARROW,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.LONG
    );
  }
  factory Animal.toad() {
    return const Animal(
      image: 'assets/images/animals/toad.jpg',
      name: '두꺼비',
      faceWidth: WIDTH.WIDE,
      faceLength: LENGTH.SHORT,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.weasel() {
    return const Animal(
      image: 'assets/images/animals/weasel.jpg',
      name: '족제비',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.NORMAL,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.NORMAL,
      lipWidth: WIDTH.NARROW,
      lipLength: LENGTH.NORMAL
    );
  }
  factory Animal.wolf() {
    return const Animal(
      image: 'assets/images/animals/wolf.jpg',
      name: '늑대',
      faceWidth: WIDTH.NORMAL,
      faceLength: LENGTH.LONG,
      noseWidth: WIDTH.NORMAL,
      noseLength: LENGTH.LONG,
      lipWidth: WIDTH.WIDE,
      lipLength: LENGTH.NORMAL
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