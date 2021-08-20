class SingleAnswerItem{

final String question;
final String button;
final String answerA;
final String answerB;
final String answerC;

const SingleAnswerItem({required this.question, required this.button,
  required this.answerA, required this.answerB, required this.answerC});
}

final singleAnswerList = [
SingleAnswerItem(
  question: 'Select your preferred subjects',
  button : 'NEXT',
  answerA: 'Meditation & Breathing',
  answerB: 'Yoga',
  answerC: 'Fitness',
),
  SingleAnswerItem(
    question: 'Your current level of Yoga',
    button : 'NEXT',
    answerA: 'Never practiced',
    answerB: 'I have some experience',
    answerC: 'I regularly practice it',
  ),
  SingleAnswerItem(
    question: 'Your level of Meditation & Breathing',
    button : 'NEXT',
    answerA: 'Beginner',
    answerB: 'Intermediate',
    answerC: 'Advanced',
  ),
  SingleAnswerItem(
    question: 'Your gender',
    button : 'NEXT',
    answerA: 'Female',
    answerB: 'Male',
    answerC: '',
  ),
];