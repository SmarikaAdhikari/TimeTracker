class Onboard{
  String image;
  String title;
  Onboard({
   required this.image, 
   required this.title});

}
List <Onboard> onboard = [
  Onboard(image: 'images/logoTT.jpeg',title: 'Welcome to Time tracker, the app that helps you to spent your valuable time wisely'),
  Onboard(image: 'images/logoTT.jpeg',title: 'Here, you can track the time spent on each task and move the task to different status based on the progress of the task'),
  Onboard(image: 'images/logoTT.jpeg',title: 'After completion, you can view the task in history with details'),
];