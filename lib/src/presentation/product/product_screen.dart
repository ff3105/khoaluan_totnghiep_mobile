import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../utils/utils.dart';
import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../base/base.dart';
import '../presentation.dart';
import 'product.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  const ProductScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetAppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: CartScreen(),
                );
              }),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: BaseWidget<ProductViewModel>(
          viewModel: ProductViewModel(productResponse: ProductResponse()),
          onViewModelReady: (vm) async {
            await vm.init(id);
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetImageCarousel(images: vm.product.data.images),
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              Padding(
                                padding: AppStyles.paddingBody,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                vm.product.data.name,
                                                style: GoogleFonts.notoSans(
                                                  color: AppColors.dark,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'bed frame, birch/Luroy, Queen',
                                                style: GoogleFonts.inter(
                                                  color: AppColors.dark,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          Formats.money(vm.product.data.price),
                                          style: GoogleFonts.inter(
                                            color: AppColors.dark,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        WidgetRatingBar(
                                          stars: double.parse(vm
                                              .product.data.ratingAveraged
                                              .toString()),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(vm.product.data.ratingAveraged
                                            .toString()),
                                        Container(
                                          width: 1,
                                          height: 14,
                                          color:
                                              AppColors.dark.withAlpha(140),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                        Text('Sold: ${vm.product.data.bought}'),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(vm.product.data.desc),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                title: const Text(
                                  'Comments',
                                  style: TextStyle(fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return CommentDialog(
                                          productId: vm.product.data.id);
                                    }),
                                  );
                                },
                                trailing:
                                    const Icon(Icons.arrow_forward_ios_outlined),
                              ),
                              ListTile(
                                title: Text(
                                  'Rating (${vm.product.data.rating} Ratings)',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return RatingDialog(
                                          productId: vm.product.data.id);
                                    }),
                                  );
                                },
                                trailing:
                                    const Icon(Icons.arrow_forward_ios_outlined),
                              ),
                              const ExpansionTile(
                                collapsedBackgroundColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                title: Text(
                                  'Attributes',
                                  style: TextStyle(fontSize: 14),
                                ),
                                expandedAlignment: Alignment.topLeft,
                                childrenPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                children: [
                                  Text('desc 1 : 10kg'),
                                  Text('desc 1 : 10kg'),
                                  Text('desc 1 : 10kg'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.favorite_outline,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () => vm.addToCart(1,vm.product.data),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class WidgetImageCarousel extends StatefulWidget {
  final List<ProductImage> images;

  const WidgetImageCarousel({Key key, this.images}) : super(key: key);

  @override
  _WidgetImageCarouselState createState() => _WidgetImageCarouselState();
}

class _WidgetImageCarouselState extends State<WidgetImageCarousel> {
  CarouselController _carouselController;
  int _current = 1;

  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.images.isEmpty)
          Image.asset(
            'assets/images/placeholder.jpg',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        else
          CarouselSlider(
            carouselController: _carouselController,
            items: widget.images.map((e) {
              return Image.network(
                AppEndpoint.domain + e.image,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true,
                height: 300,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index + 1;
                  });
                }),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.only(bottom: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10)),
            child: widget.images.isEmpty
                ? const Text('0/0')
                : Text('$_current/${widget.images.length}'),
          ),
        ),
      ],
    );
  }
}
