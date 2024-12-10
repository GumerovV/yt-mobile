import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/screens/channel/cubit/channel_screen_cubit.dart';
import 'package:flutter_yt_v2/screens/channel/cubit/channel_screen_state.dart';
import 'package:flutter_yt_v2/utils/format_number.dart';
import 'package:flutter_yt_v2/widgets/subscribe_button/subscribe_button_provider.dart';
import 'package:flutter_yt_v2/widgets/user_avatar.dart';
import 'package:flutter_yt_v2/widgets/video/video_list.dart';

@RoutePage()
class ChannelScreen extends StatefulWidget implements AutoRouteWrapper{
  final int userId;
  const ChannelScreen({super.key, @PathParam("id") required this.userId});
  
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: ChannelScreenCubit(),
      child: this,
    );
  }

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener); // Отслеживаем изменение прокрутки
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Если позиция скролла больше 200, отображаем заголовок
    if (_scrollController.offset > 100 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    }
    // Если позиция скролла меньше 200, убираем заголовок
    else if (_scrollController.offset <= 100 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChannelScreenCubit>().getUserById(widget.userId.toString());

    return Scaffold(
      body: BlocBuilder<ChannelScreenCubit, ChannelScreenState>(
        builder: (context, state) {
          if (state is ChannelLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChannelLoadedState){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    snap: true,
                    automaticallyImplyLeading: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                        title: _isScrolled ? Text("${state.user.name!.isNotEmpty ? state.user.name :  state.user.email}", style: const TextStyle(color: Colors.white),) : null,
                        centerTitle: true,
                        background: Container(
                          color: const Color.fromARGB(255, 31, 29, 43),
                        ),
                    ),
                    pinned: false,
                    floating: true, // Позволяет AppBar плавно появляться и исчезать
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              UserAvatar(user: state.user, width: 70, height: 70,),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${state.user.name}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,)),
                                    Text("${state.user.email}", style: const TextStyle(color: Colors.white30)),
                                    Text("${formatNumber(state.user.subscribersCount ?? 0)} subscribers", style: const TextStyle(color: Colors.white30)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SubscribeButtonProvider(userId: widget.userId),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Align(alignment: Alignment.centerLeft, child: Text("Видео >", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  VideoList(videos: state.user.videos!, withoutUser: true,),
                ],
              ),
            );
          }
          if (state is ChannelErrorState){
            return Center(child: Text("${state.err}"),);
          }
      
          return const SizedBox();
        },
      ),
    );
  }
}