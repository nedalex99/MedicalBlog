import 'package:medical_blog/model/tutorial_data.dart';
import 'package:medical_blog/utils/constants/images.dart';
import 'package:medical_blog/utils/constants/strings.dart';

List<TutorialData> tutorialList = [
  TutorialData(
    image: kFirstImageTutorial,
    title: kFirstTutorialTitle,
    description: kFirstTutorialDescription,
    position: 0,
  ),
  TutorialData(
    image: kSecondImageTutorial,
    title: kSecondTutorialTitle,
    description: kSecondTutorialDescription,
    position: 1,
  ),
  TutorialData(
    image: kThirdImageTutorial,
    title: kThirdTutorialTitle,
    description: kThirdTutorialDescription,
    position: 2,
  ),
];

const kLikePoints = 2.0;
const kDislikePoints = 0.5;
const kReportPoints = 5.0;
