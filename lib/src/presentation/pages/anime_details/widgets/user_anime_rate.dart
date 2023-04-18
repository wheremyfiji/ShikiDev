import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shikidev/src/utils/extensions/buildcontext.dart';
import 'package:shikidev/src/utils/utils.dart';

import '../../../../data/data_sources/anime_data_src.dart';
import '../../../../domain/models/anime.dart';
import '../../../../domain/models/animes.dart';
import '../../../../services/secure_storage/secure_storage_service.dart';
import '../../../providers/anime_details_provider.dart';
import '../../../providers/library_tab_page_provider.dart';
import 'anime_userate_dialog.dart';

class UserAnimeRateWidget extends HookConsumerWidget {
  final Animes anime;
  final Anime data;
  final String imageUrl;
  const UserAnimeRateWidget(this.anime, this.data, this.imageUrl, {super.key});

  String getRateStatus(String value) {
    String status;

    const map = {
      'planned': 'В планах',
      'watching': 'Смотрю',
      'rewatching': 'Пересматриваю',
      'completed': 'Просмотрено',
      'on_hold': 'Отложено',
      'dropped': 'Брошено'
    };

    status = map[value] ?? '';

    return status;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    Future<void> incRate() async {
      final rate = await ref.read(animeDataSourceProvider).incrementUserRate(
          token: SecureStorageService.instance.token,
          rateId: data.userRate!.id!);

      if (rate.status != data.userRate!.status) {
        switch (data.userRate!.status) {
          case 'watching':
            {
              ref.read(watchingTabPageProvider).deleteAnime(data.id!);
            }
            break;
          case 'planned':
            {
              ref.read(plannedTabPageProvider).deleteAnime(data.id!);
              break;
            }
          case 'completed':
            {
              ref.read(completedTabPageProvider).deleteAnime(data.id!);
            }
            break;
          case 'rewatching':
            {
              ref.read(rewatchingTabPageProvider).deleteAnime(data.id!);
            }
            break;
          case 'on_hold':
            {
              ref.read(onHoldTabPageProvider).deleteAnime(data.id!);
            }
            break;
          case 'dropped':
            {
              ref.read(droppedTabPageProvider).deleteAnime(data.id!);
            }
            break;
          default:
        }
        switch (rate.status) {
          case 'watching':
            {
              ref.read(watchingTabPageProvider).addAnime(
                    animeId: data.id!,
                    anime: anime,
                    rateId: rate.id!,
                    createdAt: rate.createdAt!,
                    updatedAt: rate.updatedAt!,
                    score: rate.score,
                    episodes: rate.episodes,
                    rewatches: rate.rewatches,
                    status: rate.status,
                  );
            }
            break;
          case 'planned':
            {
              ref.read(plannedTabPageProvider).addAnime(
                    animeId: data.id!,
                    anime: anime,
                    rateId: rate.id!,
                    createdAt: rate.createdAt!,
                    updatedAt: rate.updatedAt!,
                    score: rate.score,
                    episodes: rate.episodes,
                    rewatches: rate.rewatches,
                    status: rate.status,
                  );
              break;
            }
          case 'completed':
            {
              ref.read(completedTabPageProvider).addAnime(
                    animeId: data.id!,
                    anime: anime,
                    rateId: rate.id!,
                    createdAt: rate.createdAt!,
                    updatedAt: rate.updatedAt!,
                    score: rate.score,
                    episodes: rate.episodes,
                    rewatches: rate.rewatches,
                    status: rate.status,
                  );
            }
            break;
          case 'rewatching':
            {
              ref.read(rewatchingTabPageProvider).addAnime(
                    animeId: data.id!,
                    anime: anime,
                    rateId: rate.id!,
                    createdAt: rate.createdAt!,
                    updatedAt: rate.updatedAt!,
                    score: rate.score,
                    episodes: rate.episodes,
                    rewatches: rate.rewatches,
                    status: rate.status,
                  );
            }
            break;
          case 'on_hold':
            {
              ref.read(onHoldTabPageProvider).addAnime(
                    animeId: data.id!,
                    anime: anime,
                    rateId: rate.id!,
                    createdAt: rate.createdAt!,
                    updatedAt: rate.updatedAt!,
                    score: rate.score,
                    episodes: rate.episodes,
                    rewatches: rate.rewatches,
                    status: rate.status,
                  );
            }
            break;
          case 'dropped':
            {
              ref.read(droppedTabPageProvider).addAnime(
                    animeId: data.id!,
                    anime: anime,
                    rateId: rate.id!,
                    createdAt: rate.createdAt!,
                    updatedAt: rate.updatedAt!,
                    score: rate.score,
                    episodes: rate.episodes,
                    rewatches: rate.rewatches,
                    status: rate.status,
                  );
            }
            break;
          default:
        }
        ref.read(titleInfoPageProvider(data.id!)).addRate(
              rateId: rate.id!,
              updatedAt: rate.updatedAt!,
              status: rate.status!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
              text: rate.text,
              textHtml: rate.textHtml,
              createdAt: rate.createdAt,
            );
        return;
      }
      //switch (selectedStatus ?? initStatus) {
      switch (rate.status) {
        case 'watching':
          ref.read(watchingTabPageProvider).updateAnime(
                animeId: data.id!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
              );
          break;
        case 'planned':
          ref.read(plannedTabPageProvider).updateAnime(
                animeId: data.id!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
              );
          break;
        case 'completed':
          ref.read(completedTabPageProvider).updateAnime(
                animeId: data.id!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
              );
          break;
        case 'rewatching':
          ref.read(rewatchingTabPageProvider).updateAnime(
                animeId: data.id!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
              );
          break;
        case 'on_hold':
          ref.read(onHoldTabPageProvider).updateAnime(
                animeId: data.id!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
              );
          break;
        case 'dropped':
          ref.read(droppedTabPageProvider).updateAnime(
                animeId: data.id!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
              );
          break;
        default:
      }
      ref.read(titleInfoPageProvider(data.id!)).addRate(
            rateId: rate.id!,
            updatedAt: rate.updatedAt!,
            status: rate.status!,
            score: rate.score,
            episodes: rate.episodes,
            rewatches: rate.rewatches,
            text: rate.text,
            textHtml: rate.textHtml,
            createdAt: rate.createdAt,
          );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Отслеживание',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundColor: Colors.transparent,
              //backgroundImage: CachedNetworkImageProvider(imageUrl),
              foregroundImage:
                  ExtendedNetworkImageProvider(imageUrl, cache: true),
              radius: 36,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Статус: ${myRate!.status}'),
                data.userRate == null
                    ? const Text(
                        'Статус: Не смотрю',
                        maxLines: 1,
                      )
                    : Text(
                        'Статус: ${getRateStatus(data.userRate!.status!)}',
                        maxLines: 1,
                      ),
                data.userRate == null
                    ? const Text(
                        'Эпизоды: -',
                        maxLines: 1,
                      )
                    : Text(
                        'Эпизоды: ${data.userRate!.episodes.toString()}',
                        maxLines: 1,
                      ),
                data.userRate == null
                    ? const Text(
                        'Оценка: -',
                        maxLines: 1,
                      )
                    : Text(
                        'Оценка: ${data.userRate!.score.toString()}',
                        maxLines: 1,
                      ),
                data.userRate == null
                    ? const Text(
                        'Пересмотрено: -',
                        maxLines: 1,
                      )
                    : Text(
                        'Пересмотрено: ${data.userRate!.rewatches.toString()}',
                        maxLines: 1,
                      ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AnimeUserRateDialog(anime: anime, data: data);
                    },
                  );
                },
                child: data.userRate == null
                    ? const Text('Добавить в список')
                    : const Text('Изменить'),
              ),
            ),
            // if (data.userRate != null) ...[
            //   const SizedBox(
            //     width: 4,
            //   ),
            //   IconButton(
            //     onPressed: isLoading.value
            //         ? null
            //         : () async {
            //             isLoading.value = true;
            //             await incRate();

            //             // await ref
            //             //     .read(animeDataSourceProvider)
            //             //     .incrementUserRate(
            //             //       token: SecureStorageService.instance.token,
            //             //       rateId: data.userRate!.id!,
            //             //     );
            //             //ref.read(titleInfoPageProvider(data.id!)).fetch(true);

            //             isLoading.value = false;
            //           },
            //     icon: const Icon(Icons.exposure_plus_1),
            //   ),
            // ],
          ],
        ),
      ],
    );
  }
}

const List<String> statusList = <String>[
  'Смотрю',
  'В планах',
  'Просмотрено',
  'Пересматриваю',
  'Отложено',
  'Брошено'
];

class AnimeUserRateDialog2 extends ConsumerStatefulWidget {
  final Animes anime;
  final Anime data;
  final String imageUrl;

  const AnimeUserRateDialog2(
      {super.key,
      required this.anime,
      required this.data,
      required this.imageUrl});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimeUserRateDialogState();
}

class _AnimeUserRateDialogState extends ConsumerState<AnimeUserRateDialog2> {
  //String dropdownValue = statusList.first;

  late TextEditingController _controller;

  bool isLoading = false;

  String? statusForUser;
  String? initStatus;
  String? selectedStatus;
  int? currentScore;
  int rewatches = 0;
  int progress = 0;
  int epCount = 0;
  String userRateText = '';

  String? convertStatus(String? value) {
    String? status;

    if (value == null) {
      return null;
    }

    const map = {
      'watching': 'Смотрю',
      'planned': 'В планах',
      'completed': 'Просмотрено',
      'rewatching': 'Пересматриваю',
      'on_hold': 'Отложено',
      'dropped': 'Брошено'
    };

    status = map[value];

    return status;
  }

  String? convertStatusMirror(String? value) {
    String? status;

    const map = {
      'Смотрю': 'watching',
      'В планах': 'planned',
      'Просмотрено': 'completed',
      'Пересматриваю': 'rewatching',
      'Отложено': 'on_hold',
      'Брошено': 'dropped'
    };

    status = map[value];

    return status;
  }

  String getScorePrefix(int? score) {
    String text;

    const map = {
      0: 'Без оценки',
      1: 'Хуже некуда',
      2: 'Ужасно',
      3: 'Очень плохо',
      4: 'Плохо',
      5: 'Более-менее',
      6: 'Нормально',
      7: 'Хорошо',
      8: 'Отлично',
      9: 'Великолепно',
      10: 'Эпик Вин!',
    };

    text = map[score] ?? '';

    return text;
  }

  Future<void> createRate() async {
    setState(() {
      isLoading = true;
    });
    //await Future.delayed(const Duration(seconds: 3));
    final rate = await ref.read(animeDataSourceProvider).createUserRate(
          token: SecureStorageService.instance.token,
          userId: int.parse(SecureStorageService.instance.userId),
          targetId: widget.data.id!,
          status: selectedStatus ?? '',
          score: currentScore ?? 0,
          episodes: progress,
          rewatches: rewatches,
          text: _controller.text,
        );
    switch (rate.status) {
      case 'watching':
        {
          //ref.read(watchingTabPageProvider).deleteAnime(widget.data.id!);
          ref.read(watchingTabPageProvider).addAnime(
                animeId: widget.data.id!,
                anime: widget.anime,
                rateId: rate.id!,
                createdAt: rate.createdAt!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
                status: rate.status,
              );
        }
        break;
      case 'planned':
        {
          ref.read(plannedTabPageProvider).addAnime(
                animeId: widget.data.id!,
                anime: widget.anime,
                rateId: rate.id!,
                createdAt: rate.createdAt!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
                status: rate.status,
              );
          break;
        }
      case 'completed':
        {
          ref.read(completedTabPageProvider).addAnime(
                animeId: widget.data.id!,
                anime: widget.anime,
                rateId: rate.id!,
                createdAt: rate.createdAt!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
                status: rate.status,
              );
        }
        break;
      case 'rewatching':
        {
          ref.read(rewatchingTabPageProvider).addAnime(
                animeId: widget.data.id!,
                anime: widget.anime,
                rateId: rate.id!,
                createdAt: rate.createdAt!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
                status: rate.status,
              );
        }
        break;
      case 'on_hold':
        {
          ref.read(onHoldTabPageProvider).addAnime(
                animeId: widget.data.id!,
                anime: widget.anime,
                rateId: rate.id!,
                createdAt: rate.createdAt!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
                status: rate.status,
              );
        }
        break;
      case 'dropped':
        {
          ref.read(droppedTabPageProvider).addAnime(
                animeId: widget.data.id!,
                anime: widget.anime,
                rateId: rate.id!,
                createdAt: rate.createdAt!,
                updatedAt: rate.updatedAt!,
                score: rate.score,
                episodes: rate.episodes,
                rewatches: rate.rewatches,
                status: rate.status,
              );
        }
        break;
      default:
    }
    ref.read(titleInfoPageProvider(widget.data.id!)).addRate(
          rateId: rate.id!,
          updatedAt: rate.updatedAt!,
          status: rate.status!,
          score: rate.score,
          episodes: rate.episodes,
          rewatches: rate.rewatches,
          text: rate.text,
          textHtml: rate.textHtml,
          createdAt: rate.createdAt,
        );
  }

  Future<void> updateRate() async {
    setState(() {
      isLoading = true;
    });
    //await Future.delayed(const Duration(seconds: 3));
    final rate = await ref.read(animeDataSourceProvider).updateUserRate(
          token: SecureStorageService.instance.token,
          rateId: widget.data.userRate!.id!,
          status: selectedStatus,
          score: currentScore,
          episodes: progress,
          rewatches: rewatches,
          text: _controller.text,
        );
    if (rate.status != initStatus) {
      switch (initStatus) {
        case 'watching':
          {
            ref.read(watchingTabPageProvider).deleteAnime(widget.data.id!);
          }
          break;
        case 'planned':
          {
            ref.read(plannedTabPageProvider).deleteAnime(widget.data.id!);
            break;
          }
        case 'completed':
          {
            ref.read(completedTabPageProvider).deleteAnime(widget.data.id!);
          }
          break;
        case 'rewatching':
          {
            ref.read(rewatchingTabPageProvider).deleteAnime(widget.data.id!);
          }
          break;
        case 'on_hold':
          {
            ref.read(onHoldTabPageProvider).deleteAnime(widget.data.id!);
          }
          break;
        case 'dropped':
          {
            ref.read(droppedTabPageProvider).deleteAnime(widget.data.id!);
          }
          break;
        default:
      }
      switch (rate.status) {
        case 'watching':
          {
            ref.read(watchingTabPageProvider).addAnime(
                  animeId: widget.data.id!,
                  anime: widget.anime,
                  rateId: rate.id!,
                  createdAt: rate.createdAt!,
                  updatedAt: rate.updatedAt!,
                  score: rate.score,
                  episodes: rate.episodes,
                  rewatches: rate.rewatches,
                  status: rate.status,
                );
          }
          break;
        case 'planned':
          {
            ref.read(plannedTabPageProvider).addAnime(
                  animeId: widget.data.id!,
                  anime: widget.anime,
                  rateId: rate.id!,
                  createdAt: rate.createdAt!,
                  updatedAt: rate.updatedAt!,
                  score: rate.score,
                  episodes: rate.episodes,
                  rewatches: rate.rewatches,
                  status: rate.status,
                );
            break;
          }
        case 'completed':
          {
            ref.read(completedTabPageProvider).addAnime(
                  animeId: widget.data.id!,
                  anime: widget.anime,
                  rateId: rate.id!,
                  createdAt: rate.createdAt!,
                  updatedAt: rate.updatedAt!,
                  score: rate.score,
                  episodes: rate.episodes,
                  rewatches: rate.rewatches,
                  status: rate.status,
                );
          }
          break;
        case 'rewatching':
          {
            ref.read(rewatchingTabPageProvider).addAnime(
                  animeId: widget.data.id!,
                  anime: widget.anime,
                  rateId: rate.id!,
                  createdAt: rate.createdAt!,
                  updatedAt: rate.updatedAt!,
                  score: rate.score,
                  episodes: rate.episodes,
                  rewatches: rate.rewatches,
                  status: rate.status,
                );
          }
          break;
        case 'on_hold':
          {
            ref.read(onHoldTabPageProvider).addAnime(
                  animeId: widget.data.id!,
                  anime: widget.anime,
                  rateId: rate.id!,
                  createdAt: rate.createdAt!,
                  updatedAt: rate.updatedAt!,
                  score: rate.score,
                  episodes: rate.episodes,
                  rewatches: rate.rewatches,
                  status: rate.status,
                );
          }
          break;
        case 'dropped':
          {
            ref.read(droppedTabPageProvider).addAnime(
                  animeId: widget.data.id!,
                  anime: widget.anime,
                  rateId: rate.id!,
                  createdAt: rate.createdAt!,
                  updatedAt: rate.updatedAt!,
                  score: rate.score,
                  episodes: rate.episodes,
                  rewatches: rate.rewatches,
                  status: rate.status,
                );
          }
          break;
        default:
      }
      ref.read(titleInfoPageProvider(widget.data.id!)).updateRate(
            rateId: rate.id!,
            updatedAt: rate.updatedAt!,
            status: rate.status!,
            score: rate.score,
            episodes: rate.episodes,
            rewatches: rate.rewatches,
            text: rate.text,
            textHtml: rate.textHtml,
            createdAt: rate.createdAt,
          );
      return;
    }
    //switch (selectedStatus ?? initStatus) {
    switch (rate.status) {
      case 'watching':
        ref.read(watchingTabPageProvider).updateAnime(
              animeId: widget.data.id!,
              updatedAt: rate.updatedAt!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
            );
        break;
      case 'planned':
        ref.read(plannedTabPageProvider).updateAnime(
              animeId: widget.data.id!,
              updatedAt: rate.updatedAt!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
            );
        break;
      case 'completed':
        ref.read(completedTabPageProvider).updateAnime(
              animeId: widget.data.id!,
              updatedAt: rate.updatedAt!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
            );
        break;
      case 'rewatching':
        ref.read(rewatchingTabPageProvider).updateAnime(
              animeId: widget.data.id!,
              updatedAt: rate.updatedAt!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
            );
        break;
      case 'on_hold':
        ref.read(onHoldTabPageProvider).updateAnime(
              animeId: widget.data.id!,
              updatedAt: rate.updatedAt!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
            );
        break;
      case 'dropped':
        ref.read(droppedTabPageProvider).updateAnime(
              animeId: widget.data.id!,
              updatedAt: rate.updatedAt!,
              score: rate.score,
              episodes: rate.episodes,
              rewatches: rate.rewatches,
            );
        break;
      default:
    }
    ref.read(titleInfoPageProvider(widget.data.id!)).updateRate(
          rateId: rate.id!,
          updatedAt: rate.updatedAt!,
          status: rate.status!,
          score: rate.score,
          episodes: rate.episodes,
          rewatches: rate.rewatches,
          text: rate.text,
          textHtml: rate.textHtml,
          createdAt: rate.createdAt,
        );
  }

  Future<bool> deleteRate() async {
    setState(() {
      isLoading = true;
    });
    final resp = await ref.read(animeDataSourceProvider).deleteUserRate(
          token: SecureStorageService.instance.token,
          rateId: widget.data.userRate!.id!,
        );
    switch (selectedStatus ?? initStatus) {
      case 'watching':
        ref.read(watchingTabPageProvider).deleteAnime(widget.data.id!);
        break;
      case 'planned':
        ref.read(plannedTabPageProvider).deleteAnime(widget.data.id!);
        break;
      case 'completed':
        ref.read(completedTabPageProvider).deleteAnime(widget.data.id!);
        break;
      case 'rewatching':
        ref.read(rewatchingTabPageProvider).deleteAnime(widget.data.id!);
        break;
      case 'on_hold':
        ref.read(onHoldTabPageProvider).deleteAnime(widget.data.id!);
        break;
      case 'dropped':
        ref.read(droppedTabPageProvider).deleteAnime(widget.data.id!);
        break;
      default:
    }

    return resp;
  }

  @override
  void initState() {
    statusForUser = convertStatus(widget.data.userRate?.status);
    initStatus = widget.data.userRate?.status;
    selectedStatus = widget.data.userRate?.status;
    currentScore = widget.data.userRate?.score;
    rewatches = widget.data.userRate?.rewatches ?? 0;
    progress = widget.data.userRate?.episodes ?? 0;
    if (widget.data.status == 'released') {
      epCount = widget.data.episodes ?? 0;
    } else {
      epCount = widget.data.episodesAired ?? 0;
    }
    //epCount = widget.data.episodes ?? 0;
    userRateText = widget.data.userRate?.text ?? '';
    _controller = TextEditingController();
    _controller.text = userRateText;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actions: [
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  Navigator.pop(context);
                },
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: isLoading || selectedStatus == null
              ? null
              : () async {
                  if (widget.data.userRate == null) {
                    await createRate();
                  } else {
                    await updateRate();
                  }

                  //ref.read(titleInfoPageProvider(widget.data.id!)).fetch(true);
                  Navigator.pop(context);
                },
          child: const Text('Сохранить'),
        ),
        if (widget.data.userRate != null && widget.data.userRate?.id != null)
          IconButton(
            onPressed: isLoading
                ? null
                : () async {
                    // setState(() {
                    //   isLoading = true;
                    // });
                    // final resp = await ref.read(animeDataSourceProvider).deleteUserRate(
                    //     token: SecureStorageService.instance.token,
                    //     rateId: widget.data.userRate!.id!);
                    final result = await deleteRate();
                    if (result) {
                      // ref
                      //     .read(titleInfoPageProvider(widget.data.id!))
                      //     .fetch(true);

                      // ignore: use_build_context_synchronously
                      ref
                          .read(titleInfoPageProvider(widget.data.id!))
                          .deleteRate();
                      Navigator.pop(context);
                    } else {
                      if (mounted) {
                        Navigator.pop(context);
                        //showSnackBar(context, 'Ошибка удаления');
                        showSnackBar(ctx: context, msg: 'Ошибка удаления');
                      }
                    }
                  },
            icon: const Icon(Icons.delete),
          ),
      ],
      title: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
          minWidth: 500,
        ),
        // CircleAvatar(
        //   foregroundImage: ExtendedNetworkImageProvider(
        //       AppConfig.staticUrl + widget.data.image!.original!,
        //       cache: true),
        // ),
        // const SizedBox(
        //   width: 16,
        // ),
        child: Text(
          widget.data.russian ?? widget.data.name ?? '[Без навзвания]',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          //softWrap: true,
        ),
      ),
      content: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Список:'),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: context.theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          value: statusForUser,
                          icon: const Icon(Icons.arrow_drop_down),
                          hint: const Text('Выбор списка'),
                          iconSize: 36,
                          //elevation: 16,
                          //style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? value) {
                            setState(() {
                              statusForUser = value!;
                              selectedStatus = convertStatusMirror(value);
                              //print(statusForUser);
                              //print(selectedStatus);
                            });
                          },
                          items: statusList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.data.userRate != null) ...[
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shadowColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              const Text('Эпизоды:'),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '$progress/${epCount.toString()}',
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (progress == 0) {
                                    return;
                                  }
                                  setState(() {
                                    progress = progress - 1;
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (progress >= epCount) {
                                    return;
                                  }
                                  setState(() {
                                    progress = progress + 1;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shadowColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              const Text('Повторения:'),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(rewatches.toString()),
                            ],
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (rewatches == 0) {
                                    return;
                                  }
                                  setState(() {
                                    rewatches--;
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    rewatches++;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shadowColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              const Text('Оценка:'),
                              const SizedBox(
                                width: 4,
                              ),
                              Text('${currentScore ?? 0}'),
                              const SizedBox(
                                width: 2,
                              ),
                              if (currentScore != null)
                                Text(
                                  '(${getScorePrefix(currentScore)})',
                                  //style: TextStyle(fontSize: 12),
                                ),
                            ],
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (currentScore == null) {
                                    //currentScore = 1;
                                    return;
                                  }
                                  if (currentScore == 1) {
                                    return;
                                  }
                                  setState(() {
                                    currentScore = currentScore! - 1;
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (currentScore == 10) {
                                    return;
                                  }
                                  setState(() {
                                    if (currentScore == null) {
                                      currentScore = 1;
                                      return;
                                    }
                                    currentScore = currentScore! + 1;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Добавить заметку',
                      //border: InputBorder.none,
                      hintText: 'Добавить заметку',
                    ),
                    maxLines: 3,
                  ),
                ],
              ],
            ),
    );
  }
}
