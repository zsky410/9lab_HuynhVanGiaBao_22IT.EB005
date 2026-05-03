class Story {
  const Story({
    required this.title,
    required this.choice1,
    this.choice2,
    this.nextStory1,
    this.nextStory2,
    this.isEnding = false,
  });

  final String title;
  final String choice1;
  final String? choice2;
  final int? nextStory1;
  final int? nextStory2;
  final bool isEnding;
}
