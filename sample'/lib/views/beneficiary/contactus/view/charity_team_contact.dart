// ignore_for_file: prefer_const_constructors
import '../../../../enums/dependencies.dart';

class CharityTeamContact extends StatefulWidget {
  const CharityTeamContact({super.key});

  @override
  State<CharityTeamContact> createState() => _CharityTeamContactState();
}

class _CharityTeamContactState extends State<CharityTeamContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            color: AppColors.blackColor,
            size: 24,
            style: HeroIconStyle.solid,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // CharityLife Team Logo
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryColor,
                backgroundImage: AssetImage(AppImages.charitylogo),
              ),
              SizedBox(height: 16),
              TextWidget(
                text: 'CharityLife Team',
                size: 20,
                fontFamily: 'bold',
                color: AppColors.primaryDark,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              TextWidget(
                text: 'Customer Support',
                size: 12,
                fontFamily: 'bold',
                color: AppColors.greyDark,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  // Handle call action
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyDark.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      HeroIcon(
                        HeroIcons.phone,
                        color: AppColors.primaryDark,
                        size: 24,
                        style: HeroIconStyle.solid,
                      ),
                      SizedBox(width: 8),
                      TextWidget(
                        text: 'Call CharityLife customer care',
                        size: 14,
                        fontFamily: 'regular',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  // Handle chat action
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyDark.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeroIcon(
                        HeroIcons.paperAirplane,
                        color: AppColors.primaryDark,
                        size: 24,
                        style: HeroIconStyle.solid,
                      ),
                      SizedBox(width: 8),
                      TextWidget(
                        text: 'Chat with our Support team',
                        size: 14,
                        fontFamily: 'regular',
                        color: AppColors.primaryDark,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
