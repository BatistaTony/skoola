class IntroData {
  final String? image;
  final String? title;
  final String? description;

  IntroData({this.description, this.title, this.image});
}

List<IntroData> introDatas = [
  IntroData(
      image: "assets/images/intro1.png",
      title: "Learn anytime and anywhere",
      description:
          "Quarantine is the perfect time to spend your day learning something new, from anywhere!"),
  IntroData(
      image: "assets/images/intro2.png",
      title: "Find a course for you",
      description:
          "Quarantine is the perfect time to spend your day learning something new, from anywhere!"),
  IntroData(
      image: "assets/images/intro3.png",
      title: "Improve your skills",
      description:
          "Quarantine is the perfect time to spend your day learning something new, from anywhere!")
];
