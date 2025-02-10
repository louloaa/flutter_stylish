class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Choose Your Products',
    image: 'assets/choose_products_image.png',
    discription: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."
  ),
  UnbordingContent(
    title: 'Make Payment',
    image: 'assets/make_payment.png',
    discription: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."
  ),
  UnbordingContent(
    title: 'Get Your Order',
    image: 'assets/get_your_order.png',
    discription: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."
  ),
];