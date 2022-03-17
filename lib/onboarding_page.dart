import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_indicator/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with WidgetsBindingObserver {
  final PageController controller = PageController();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

    // },);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                children: [
                  firstPage(size),
                  secondPage(size),
                  thirdPage(size),
                ],
              ),
            ),
            // SizedBox(height: size.height * .03),
            PageIndicator(pageController: controller),
            SizedBox(height: size.height * .05),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * .15),
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage < 2) {
                    controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInCirc);
                    currentPage++;
                  } else {
                    controller.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInCirc);
                    currentPage = 0;
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF0075FF)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: size.height * .015)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            ),
            SizedBox(height: size.height * .03),
          ],
        ),
      ),
    );
  }

  Widget firstPage(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: SvgPicture.asset('assets/images/onboarding_image1.svg'),
        ),
        Expanded(
            child: Column(
              children: [
                const Text('Anywhere at anytime', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),),
                SizedBox(height: size.height * .03),
                SizedBox(
                  width: size.width * .75,
                  child: const Text(
                    'Stream your favorite tunes on the go at anytime with premium.',
                    style: TextStyle(fontSize: 18, color: Color(0xFF949494)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget secondPage(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: SvgPicture.asset('assets/images/onboarding_image2.svg'),
        ),
        Expanded(
            child: Column(
              children: [
                const Text('Listen ad free', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),),
                SizedBox(height: size.height * .03),
                SizedBox(
                    width: size.width * .75,
                    child: const Text(
                      'Enjoy ad free listening and jam out to your favorites songs.',
                      style: TextStyle(fontSize: 18, color: Color(0xFF949494)),
                      textAlign: TextAlign.center,
                    )
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget thirdPage(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: SvgPicture.asset('assets/images/onboarding_image3.svg')
        ),
        Expanded(
            child: Column(
              children: [
                const Text('First month on us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),),
                SizedBox(height: size.height * .03),
                SizedBox(
                  width: size.width * .75,
                  child: const Text(
                    'Due to the current circumstances try the first month free on us',
                    style: TextStyle(fontSize: 18, color: Color(0xFF949494)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    controller.dispose();

    super.dispose();
  }

}
