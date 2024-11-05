import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/product.dart';
import 'package:untitled1/pages/details2/product_bloc.dart';
import 'package:untitled1/res/app_colors.dart';
import 'package:untitled1/res/app_icons.dart';
import 'package:untitled1/res/app_images.dart';

/// Avec BLoC
class DetailsScreen2 extends StatelessWidget {
  static const double kImageHeight = 300.0;

  const DetailsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => ProductBloc('7622210449283'),
      child: BlocBuilder<ProductBloc, ProductBlocState>(
        builder: (BuildContext context, ProductBlocState state) {
          return switch (state) {
            ProductBlocStateLoading() => const _ProductLoading(),
            ProductBlocStateSuccess() => const _ProductBody(),
            ProductBlocStateError() => const _ProductError(),
          };
        },
      ),
    );
  }
}

class _ProductLoading extends StatelessWidget {
  const _ProductLoading();

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _ProductError extends StatelessWidget {
  const _ProductError();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error'),
    );
  }
}

class _ProductBody extends StatefulWidget {
  const _ProductBody();

  @override
  State<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<_ProductBody> {
  double _currentScrollProgress = 0.0;

  // Quand on scroll, on redraw pour changer la couleur de l'image
  void _onScroll() {
    if (_currentScrollProgress != _scrollProgress(context)) {
      setState(() {
        _currentScrollProgress = _scrollProgress(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController =
        PrimaryScrollController.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        _onScroll();
        return false;
      },
      child: Material(
        child: Stack(children: [
          BlocBuilder<ProductBloc, ProductBlocState>(
            builder: (BuildContext context, ProductBlocState state) {
              return Image.network(
                (state as ProductBlocStateSuccess).product.picture ?? '',
                width: double.infinity,
                height: DetailsScreen2.kImageHeight,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(_currentScrollProgress),
                colorBlendMode: BlendMode.srcATop,
              );
            },
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Scrollbar(
                controller: scrollController,
                trackVisibility: true,
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                    top: DetailsScreen2.kImageHeight - 30.0,
                  ),
                  child: const _Body(),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

double _scrollProgress(BuildContext context) {
  ScrollController? controller = PrimaryScrollController.of(context);
  return !controller.hasClients
      ? 0
      : (controller.position.pixels / DetailsScreen2.kImageHeight).clamp(0, 1);
}

class _HeaderIcon extends StatefulWidget {
  final IconData icon;
  final String? tooltip;
  final VoidCallback? onPressed;

  const _HeaderIcon({
    required this.icon,
    // ignore: unused_element
    this.tooltip,
    // ignore: unused_element
    this.onPressed,
  });

  @override
  State<_HeaderIcon> createState() => _HeaderIconState();
}

class _HeaderIconState extends State<_HeaderIcon> {
  double _opacity = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PrimaryScrollController.of(context).addListener(_onScroll);
  }

  void _onScroll() {
    double newOpacity = _scrollProgress(context);

    if (newOpacity != _opacity) {
      setState(() {
        _opacity = newOpacity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          type: MaterialType.transparency,
          child: Tooltip(
            message: widget.tooltip,
            child: InkWell(
              onTap: widget.onPressed ?? () {},
              customBorder: const CircleBorder(),
              child: Ink(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Theme.of(context).primaryColorLight.withOpacity(_opacity),
                ),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  static const double _kHorizontalPadding = 20.0;
  static const double _kVerticalPadding = 30.0;

  const _Body();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(16.0),
          topEnd: Radius.circular(16.0),
        ),
      ),
      child: ChangeNotifierProvider(
        create: (_) => ColorNotifier(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (context) {
              return TextButton(
                onPressed: () {
                  Provider.of<ColorNotifier>(context, listen: false).blue();
                },
                child: const Text('Changer couleur'),
              );
            }),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _Body._kHorizontalPadding,
                vertical: _Body._kVerticalPadding,
              ),
              child: _Header(),
            ),
            const _Scores(),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _Body._kHorizontalPadding,
                vertical: _Body._kVerticalPadding,
              ),
              child: _Info(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Product product =
        (BlocProvider.of<ProductBloc>(context).state as ProductBlocStateSuccess)
            .product;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.name != null)
          Text(
            product.name!,
            style: textTheme.displayLarge,
          ),
        const SizedBox(
          height: 3.0,
        ),
        if (product.brands != null) ...[
          Text(
            product.brands!.join(", "),
            style: textTheme.displayMedium,
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
        if (product.altName != null)
          Text(
            product.altName!,
            style: textTheme.headlineMedium,
          ),
      ],
    );
  }
}

class _Scores extends StatelessWidget {
  static const double _horizontalPadding = _Body._kHorizontalPadding;
  static const double _verticalPadding = 18.0;

  const _Scores();

  @override
  Widget build(BuildContext context) {
    final Product product =
        (BlocProvider.of<ProductBloc>(context).state as ProductBlocStateSuccess)
            .product;

    return Container(
      color: AppColors.gray1,
      width: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: _verticalPadding,
            horizontal: _horizontalPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 44,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 5.0),
                    child: _Nutriscore(
                      nutriscore: product.nutriScore ?? ProductNutriscore.A,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1.0,
                height: 100.0,
                color: Theme.of(context).dividerColor,
              ),
              Expanded(
                flex: 66,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 25.0),
                    child: _NovaGroup(
                      novaScore: product.novaScore ?? ProductNovaScore.Group1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: _verticalPadding,
            horizontal: _horizontalPadding,
          ),
          child: _EcoScore(
            ecoScore: product.ecoScore ?? ProductEcoScore.D,
          ),
        ),
      ]),
    );
  }
}

class _Nutriscore extends StatelessWidget {
  final ProductNutriscore nutriscore;

  const _Nutriscore({
    required this.nutriscore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutri-Score',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Image.asset(
          _findAssetName(),
          width: 100.0,
        ),
      ],
    );
  }

  String _findAssetName() {
    switch (nutriscore) {
      case ProductNutriscore.A:
        return AppImages.nutriscoreA;
      case ProductNutriscore.B:
        return AppImages.nutriscoreB;
      case ProductNutriscore.C:
        return AppImages.nutriscoreC;
      case ProductNutriscore.D:
        return AppImages.nutriscoreD;
      case ProductNutriscore.E:
        return AppImages.nutriscoreE;
      default:
        throw Exception('Unknown nutriscore value!');
    }
  }
}

class _NovaGroup extends StatelessWidget {
  final ProductNovaScore novaScore;

  const _NovaGroup({
    required this.novaScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Groupe Nova',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 16.0,
              ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          _findLabel(),
          style: const TextStyle(
            color: AppColors.gray2,
          ),
        ),
      ],
    );
  }

  String _findLabel() {
    switch (novaScore) {
      case ProductNovaScore.Group1:
        return 'Aliments non transformés ou transformés minimalement';
      case ProductNovaScore.Group2:
        return 'Ingrédients culinaires transformés';
      case ProductNovaScore.Group3:
        return 'Aliments transformés';
      case ProductNovaScore.Group4:
        return 'Produits alimentaires et boissons ultra-transformés';
      default:
        throw Exception('Unknown nova group!');
    }
  }
}

class _EcoScore extends StatelessWidget {
  final ProductEcoScore ecoScore;

  const _EcoScore({
    required this.ecoScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EcoScore',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Icon(
              _findIcon(),
              color: _findIconColor(),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              _findLabel(),
              style: const TextStyle(
                color: AppColors.gray2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _findIcon() {
    switch (ecoScore) {
      case ProductEcoScore.A:
        return AppIcons.ecoscore_a;
      case ProductEcoScore.B:
        return AppIcons.ecoscore_b;
      case ProductEcoScore.C:
        return AppIcons.ecoscore_c;
      case ProductEcoScore.D:
        return AppIcons.ecoscore_d;
      case ProductEcoScore.E:
        return AppIcons.ecoscore_e;
      default:
        throw Exception('Unknown nova group!');
    }
  }

  Color _findIconColor() {
    switch (ecoScore) {
      case ProductEcoScore.A:
        return AppColors.ecoScoreA;
      case ProductEcoScore.B:
        return AppColors.ecoScoreB;
      case ProductEcoScore.C:
        return AppColors.ecoScoreC;
      case ProductEcoScore.D:
        return AppColors.ecoScoreD;
      case ProductEcoScore.E:
        return AppColors.ecoScoreE;
      default:
        throw Exception('Unknown nova group!');
    }
  }

  String _findLabel() {
    switch (ecoScore) {
      case ProductEcoScore.A:
        return 'Très faible impact environnemental';
      case ProductEcoScore.B:
        return 'Faible impact environnemental';
      case ProductEcoScore.C:
        return 'Impact modéré sur l\'environnement';
      case ProductEcoScore.D:
        return 'Impact environnemental élevé';
      case ProductEcoScore.E:
        return 'Impact environnemental très élevé';
    }
  }
}

class _Info extends StatelessWidget {
  const _Info();

  @override
  Widget build(BuildContext context) {
    final Product product =
        (BlocProvider.of<ProductBloc>(context).state as ProductBlocStateSuccess)
            .product;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ProductItemValue(
          label: 'Quantité',
          value: product.quantity ?? '-',
        ),
        _ProductItemValue(
          label: 'Vendu en',
          value: product.manufacturingCountries?.join(', ') ?? '-',
          includeDivider: false,
        ),
        const SizedBox(
          height: 15.0,
        ),
        const Row(
          children: [
            Expanded(
              flex: 40,
              child: _ProductBubble(
                label: 'Végétalien',
                value: _ProductBubbleValue.on,
              ),
            ),
            Spacer(
              flex: 10,
            ),
            Expanded(
              flex: 40,
              child: _ProductBubble(
                label: 'Végétarien',
                value: _ProductBubbleValue.off,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _ProductItemValue extends StatelessWidget {
  final String label;
  final String value;
  final bool includeDivider;

  const _ProductItemValue({
    required this.label,
    required this.value,
    this.includeDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        if (includeDivider) const Divider(height: 1.0)
      ],
    );
  }
}

class _ProductBubble extends StatelessWidget {
  final String label;
  final _ProductBubbleValue value;

  const _ProductBubble({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorNotifier>(
      builder: (BuildContext context, ColorNotifier colorNotifier, _) {
        return Container(
          decoration: BoxDecoration(
            color: colorNotifier.value,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                value == _ProductBubbleValue.on
                    ? AppIcons.checkmark
                    : AppIcons.close,
                color: AppColors.white,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum _ProductBubbleValue { on, off }

class ProductBubbleColorProvider extends InheritedWidget {
  const ProductBubbleColorProvider({
    super.key,
    required this.color,
    required super.child,
  });

  final Color color;

  static ProductBubbleColorProvider of(BuildContext context) {
    final ProductBubbleColorProvider? result = context
        .dependOnInheritedWidgetOfExactType<ProductBubbleColorProvider>();
    assert(result != null, 'No ProductBubbleColorProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ProductBubbleColorProvider old) {
    return color != old.color;
  }
}

// ChangeNotifier
// ValueNotifier

class ColorNotifier extends ValueNotifier<Color> {
  // Valeur initiale
  ColorNotifier() : super(Colors.red);

  void blue() {
    value = Colors.blue;
  }

  void green() {
    value = Colors.green;
  }
}
