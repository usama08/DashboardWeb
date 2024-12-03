import '../enums/dependencies.dart';

class NoData extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double imageHeight;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  const NoData({super.key,required this.title,required this.image,required this.description,
    required this.descriptionStyle,required this.imageHeight,required this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image,height:imageHeight),
        const SizedBox(height: 10),
        Text(title,style:titleStyle),
        const SizedBox(height: 5),
        Text(description,style: descriptionStyle),
      ],
    );
  }
}