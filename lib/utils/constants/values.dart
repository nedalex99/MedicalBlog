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

List<String> specialisationsList = [
  'Cardiology',
  'Neurology',
  'Pediatrics',
  'Allergy and Immunology',
  'Anesthesiology',
  'Dermatology',
  'Diagnostic radiology',
  'Emergency medicine',
  'Family medicine',
  'Internal medicine',
  'Medical genetics',
  'Neurology',
  'Nuclear medicine',
  'Obstetrics and gynecology',
  'Ophthalmology',
  'Pathology',
  'Pediatrics',
  'Preventive medicine',
  'Psychiatry',
  'Radiation oncology',
  'Surgery',
  'Urology',
];

List<String> imagesList = [
  "3WNu3G1croW5tSi4YqjrV3ciVPA2",
  "FRu4sWFLIUNsHgbZXzhd7c6ns1U2",
  "UWwb4SrOU1R8btjOSeFtQyXB7Ao1",
  "pTXsa1QFkZOK8BUWSG4ZxPIutgP2",
];

const kLikePoints = 2.0;
const kDislikePoints = 0.5;
const kReportPoints = 5.0;
