import '../models/story.dart';

class StoryBrain {
  final List<Story> _storyData = const [
    Story(
      title:
          'Xe của bạn nổ lốp giữa đêm trên đường núi. Một xe tải dừng lại, tài xế hỏi bạn có cần quá giang đến thị trấn không.',
      choice1: 'Lên xe xin đi nhờ.',
      choice2: 'Từ chối và đợi cứu hộ.',
      nextStory1: 2,
      nextStory2: 1,
    ),
    Story(
      title:
          'Bạn gọi cứu hộ nhưng sóng yếu. Lúc đó, bạn thấy một đèn nhà bên cạnh rừng.',
      choice1: 'Đi về phía ngôi nhà để xin giúp đỡ.',
      choice2: 'Đứng yên bên xe chờ đến sáng.',
      nextStory1: 2,
      nextStory2: 3,
    ),
    Story(
      title:
          'Tài xế đề nghị bạn mở hộp găng tay để lấy bản đồ đường tắt. Bạn thấy bên trong có một túi tiền lớn.',
      choice1: 'Nói là bạn không thấy gì và đóng hộp lại.',
      choice2: 'Cầm túi tiền và nhảy xuống xe.',
      nextStory1: 5,
      nextStory2: 4,
    ),
    Story(
      title:
          'Bạn ngủ quên và đến sáng được cảnh sát đường bộ tìm thấy. Bạn đã an toàn trở về thành phố.',
      choice1: 'Chơi lại',
      isEnding: true,
    ),
    Story(
      title:
          'Bạn cầm tiền rồi chạy vào rừng, nhưng bị lạc đường cả đêm. May mắn, sáng sớm người dân địa phương đưa bạn về.',
      choice1: 'Chơi lại',
      isEnding: true,
    ),
    Story(
      title:
          'Bạn giữ bình tĩnh và trung thực. Tài xế muốn chở bạn đến thị trấn an toàn. Bạn có một đêm bất ngờ nhưng đẹp.',
      choice1: 'Chơi lại',
      isEnding: true,
    ),
  ];

  int _storyIndex = 0;

  String getStoryTitle() => _storyData[_storyIndex].title;
  String getChoice1() => _storyData[_storyIndex].choice1;
  String? getChoice2() => _storyData[_storyIndex].choice2;
  bool hasSecondChoice() => _storyData[_storyIndex].choice2 != null;
  bool isEnding() => _storyData[_storyIndex].isEnding;

  void nextStory(int choiceNumber) {
    final Story current = _storyData[_storyIndex];
    if (current.isEnding) {
      reset();
      return;
    }

    if (choiceNumber == 1 && current.nextStory1 != null) {
      _storyIndex = current.nextStory1!;
      return;
    }

    if (choiceNumber == 2 && current.nextStory2 != null) {
      _storyIndex = current.nextStory2!;
    }
  }

  void reset() {
    _storyIndex = 0;
  }
}
