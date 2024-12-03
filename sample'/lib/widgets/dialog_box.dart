import '../../../enums/dependencies.dart';

class DialogBox extends StatelessWidget {
  final String heading, body;
  final String type;
  final bool isConfirm;
  final VoidCallback? onTap;
  const DialogBox({super.key, required this.heading,this.isConfirm=false,this.onTap, required this.body,this.type="Success"});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 12,right: 12,top: 15,bottom: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeroIcon(type=="Success"?HeroIcons.checkBadge:
            type=="Warning"? HeroIcons.exclamationTriangle:
            type=="Info"? HeroIcons.informationCircle:
            type=="Alert"? HeroIcons.arrowRightStartOnRectangle:
            HeroIcons.xCircle,color:
            type=="Success"? AppColors.primaryColor:
            type=="Warning"? Colors.amber:
            type=="Alert"? AppColors.primaryDark:
            type=="Info"? Colors.blueAccent:
                Colors.red,size: 60,style: HeroIconStyle.solid),
            const SizedBox(height: 5),
            TextWidget(text: heading, size: 16, fontFamily: 'bold', color: AppColors.primaryDark, textAlign: TextAlign.center,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16, left: 16),
              child: TextWidget(text: body, size: 14, fontFamily: 'regular', color: AppColors.primaryDark.withOpacity(0.6), textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: AppColors.fieldColorDark,),
            if(isConfirm)...[
             Row(
               children: [
                 Expanded(child: InkWell(
                   onTap: onTap,
                   child: SizedBox(
                     height: 40,
                     child: Center(
                       child: TextWidget(text: 'Confirm', size: 16, fontFamily: 'bold', color:AppColors.primaryColor),
                     ),
                   ),
                 )),
                 const SizedBox(width: 10),
                 Expanded(child: InkWell(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: const SizedBox(
                     height: 40,
                     child: Center(
                       child: TextWidget(text: 'Cancel', size: 16, fontFamily: 'bold', color: Colors.red),
                     ),
                   ),
                 )),
               ],
             )
            ]
            else...[
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: TextWidget(text: 'Close', size: 16, fontFamily: 'bold', color:type=="Success"? AppColors.primaryColor:
                    type=="Alert"? AppColors.primaryDark:
                    type=="Warning"? Colors.amber:
                    type=="Info"? Colors.blueAccent:
                    Colors.red),
                  ),
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }
}
