import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../kodik/kodik.dart';
import '../../../../kodik/models/kodik_anime.dart';
import '../../widgets/error_widget.dart';
import 'series_select_page.dart';

class StudioSelectPage extends ConsumerWidget {
  final int shikimoriId;
  final int epWatched;
  final String animeName;
  final String imageUrl;

  const StudioSelectPage({
    super.key,
    required this.shikimoriId,
    required this.epWatched,
    required this.animeName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<KodikAnime> studios = ref.watch(kodikAnimeProvider(shikimoriId));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(kodikAnimeProvider(shikimoriId)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('Студия'),
              //title: Text('$animeName • Студия'),
            ),
            // SliverPinnedHeader(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Card(
            //       shadowColor: Colors.transparent,
            //       child: Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         child: Column(
            //           children: [
            //             Text(animeName),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            studios.when(
              loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator())),
              error: (err, stack) => SliverFillRemaining(
                child: CustomErrorWidget(err.toString(),
                    () => ref.refresh(kodikAnimeProvider(shikimoriId))),
              ),
              data: (data) {
                if (data.total == 0) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('Ничего не найдено')),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // data.studio?.sort((a, b) {
                        //   int adate = a.episodesCount!;
                        //   int bdate = b.episodesCount!;
                        //   return -adate.compareTo(bdate);
                        // });

                        data.studio?.sort(
                          (a, b) {
                            final int sortByCourse =
                                -a.episodesCount!.compareTo(b.episodesCount!);
                            if (sortByCourse == 0) {
                              final int sortByName =
                                  -a.updatedAt!.compareTo(b.updatedAt!);
                              return sortByName;
                            }
                            return sortByCourse;
                          },
                        );

                        final KodikStudio? element = data.studio?[index];
                        final dateTimeString = element?.updatedAt;
                        final formattedDate = DateFormat('dd/MM/yyyy - HH:mm')
                            .format(DateTime.parse(dateTimeString!).toLocal());

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: ListTile(
                              title: Text(
                                element?.name ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  //color: Colors.white,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Обновлено: $formattedDate',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.w300,
                                ),
                              ),
                              trailing: Text(
                                '${element?.episodesCount} эп.',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    settings: const RouteSettings(
                                      name: 'series select page',
                                    ),
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            SeriesSelectPage(
                                      seriesList: element?.kodikSeries,
                                      studioId: element?.studioId ?? 0,
                                      shikimoriId: shikimoriId,
                                      episodeWatched: epWatched,
                                      animeName: animeName,
                                      studioName: element?.name ?? '',
                                      studioType: element?.type ?? '',
                                      imageUrl: imageUrl,
                                    ),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      childCount: data.total,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
