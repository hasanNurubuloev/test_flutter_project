class OnBoardingContent{
  String image;
  String title;
  String description;

  OnBoardingContent({required this.image, required this.title, required this.description});
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
      image : 'assets/images/1.jpg',
      title : 'Discovery',
      description : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
          'sed do eiusmod tempor incididunt ut labore et dolore '
          'magna aliqua.'
  ),
  OnBoardingContent(
      image : 'assets/images/2.jpg',
      title : 'Purchase',
      description : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
          'sed do eiusmod tempor incididunt ut labore et dolore '
          'magna aliqua.'
  ),
  OnBoardingContent(
      image : 'assets/images/3.jpg',
      title : 'Delivery',
      description : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
          'sed do eiusmod tempor incididunt ut labore et dolore '
          'magna aliqua.'
  ),
];