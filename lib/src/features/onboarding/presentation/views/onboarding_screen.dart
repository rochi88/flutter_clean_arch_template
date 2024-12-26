// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../../../common/providers/app_state_provider.dart';
import '../../../../common/themes/app_constants.dart';
import '../../../../common/themes/app_sizes.dart';
import '../widgets/dot_indicators.dart';
import '../widgets/onbording_content.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Onbord> _onbordData = [
    Onbord(
      image: 'assets/illustration/illustration-0.png',
      imageDarkTheme: 'assets/illustration/illustration_darkTheme_0.png',
      title: 'Find the item you’ve \nbeen looking for',
      description:
          'Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.',
    ),
    Onbord(
      image: 'assets/illustration/illustration-1.png',
      imageDarkTheme: 'assets/illustration/illustration_darkTheme_1.png',
      title: 'Get those shopping \nbags filled',
      description:
          'Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.',
    ),
    Onbord(
      image: 'assets/illustration/illustration-2.png',
      imageDarkTheme: 'assets/illustration/illustration_darkTheme_2.png',
      title: 'Fast & secure \npayment',
      description: 'There are many payment options available for your ease.',
    ),
    Onbord(
      image: 'assets/illustration/illustration-3.png',
      imageDarkTheme: 'assets/illustration/illustration_darkTheme_3.png',
      title: 'Package tracking',
      description:
          'In particular, Shoplon can pack your orders, and help you seamlessly manage your shipments.',
    ),
    Onbord(
      image: 'assets/illustration/illustration-4.png',
      imageDarkTheme: 'assets/illustration/illustration_darkTheme_4.png',
      title: 'Nearby stores',
      description:
          'Easily track nearby shops, browse through their items and get information about their prodcuts.',
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onbordData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnbordingContent(
                    title: _onbordData[index].title,
                    description: _onbordData[index].description,
                    image: (Theme.of(context).brightness == Brightness.dark &&
                            _onbordData[index].imageDarkTheme != null)
                        ? _onbordData[index].imageDarkTheme!
                        : _onbordData[index].image,
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onbordData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                          right: AppConstants.defaultPadding / 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex < _onbordData.length - 1) {
                          _pageController.nextPage(
                              curve: Curves.ease,
                              duration: AppConstants.defaultDuration);
                        } else {
                          ref
                              .read(appStateNotifierProvider.notifier)
                              .completeOnboarding();
                          context.go('/home');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/arrow_right.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}

class Onbord {
  final String image, title, description;
  final String? imageDarkTheme;

  Onbord({
    required this.image,
    required this.title,
    this.description = '',
    this.imageDarkTheme,
  });
}
