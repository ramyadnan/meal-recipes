import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourite = ref.watch(favouriteMealsProvider).contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: Tween<double>(
                  begin: 0.5,
                  end: 1.0,
                ).animate(animation),
                child: child,
              ),
              child: Icon( 
                isFavourite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavourite),
              ),
            ), 
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleFavouriteMeals(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: Text(
                      wasAdded ? 'Meal added as a favorite.' : 'Meal removed.',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Hero(
                  tag: meal.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      meal.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ingredients',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontFamily: GoogleFonts.borel().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                    ),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (final ingredient in meal.ingredients)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    children: [
                                      if (ingredient.contains(','))
                                        TextSpan(
                                          text: '${ingredient.split(',').first.trim()} ',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                                ,
                                                color: Theme.of(context).colorScheme.surface,
                                              ),
                                        ),
                                      TextSpan(
                                        text: ingredient.contains(',')
                                            ? ingredient.split(',').skip(1).join(',').trim()
                                            : ingredient,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 17,
                                              color: Theme.of(context).colorScheme.surface,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Steps',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontFamily: GoogleFonts.borel().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final entry in meal.steps.asMap().entries)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${entry.key + 1}. ',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.surface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Theme.of(context).colorScheme.surface,
                                            fontSize: 17,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
