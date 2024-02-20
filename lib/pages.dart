import 'package:contact_bloc/bloc_pattern/bloc/appstate/appstate_bloc.dart';
import 'package:contact_bloc/bloc_pattern/bloc/contact/contact_bloc.dart';
import 'package:contact_bloc/bloc_pattern/cubit/pageview/pageview_cubit.dart';
import 'package:contact_bloc/constant.dart';
import 'package:contact_bloc/database/db.dart';
import 'package:contact_bloc/model/user_model.dart';
import 'package:contact_bloc/screen/favourite/favourite.dart';
import 'package:contact_bloc/screen/home/home.dart';
import 'package:contact_bloc/screen/home/widgets/button_tile.dart';
import 'package:contact_bloc/screen/home/widgets/search_contact_field.dart';
import 'package:contact_bloc/screen/home/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pages extends StatefulWidget {
  const Pages({super.key, required this.db});

  final Db db;

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int indexPage = 0;
  final PageController pageController = PageController();
  bool _searchOn = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  void searchingMode() {
    _searchOn = true;
    context.read<PageViewCubit>().changePage(indexPage, _searchOn);

  }

  void closeSearch() {
    _focusNode.unfocus();
    _searchOn = false;
    context.read<PageViewCubit>().changePage(indexPage, _searchOn);
    _searchOn == false ? searchController.text = "" : null;

  }

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        searchingMode();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
        actions: [
          IconButton.filledTonal(
            onPressed: () {
              context.read<AppStateBloc>().add(LoadUserEvent());
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocConsumer<AppStateBloc, AppstateState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            final List<UserModel> users = state.users;
            widget.db.initializeContact(users);
            Future.delayed(const Duration(seconds: 1), () {
              context.read<AppStateBloc>().add(LoadUserSuccess());
              ScaffoldMessenger.of(context).showSnackBar(popSnackBar(
                  " A total of ${users.length} users has been loaded!"));
            });
          }
        },
        builder: (context, state) {
          if (state is UserSuccessfullyInitialised) {
            context.read<ContactBloc>().add(RenderContact());
            return BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                if (state is ContactDatabaseLoaded) {
                  final favContact = state.users
                      .where((element) => element.favorite == 1)
                      .toList();
                  final allContact = state.users;

                  return BlocBuilder<PageViewCubit, PageviewState>(
                    builder: (context, state) {
                      if (state is PageviewLoader) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchContactField(
                              focusNode: _focusNode,
                              searchController: searchController,
                              searchOn: state.isSearch,
                              closeSearch: closeSearch,
                            ),
                            state.isSearch
                                ? Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color(0xFFf4f4f4)
                                            .withOpacity(0.5),
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      child: const SearchResult(
                                         ),
                                    ),
                                  )
                                : Container(),
                            state.isSearch
                                ? Container()
                                : SizedBox(
                                    width: size.height * 1,
                                    height: 35,
                                    child: Row(
                                      children: [
                                        ButtonTile(
                                          title: "All",
                                          pagePosition: 0,
                                          indexPage: state.index,
                                          pageController: pageController,
                                        ),
                                        ButtonTile(
                                          title: "Favourite",
                                          pagePosition: 1,
                                          indexPage: state.index,
                                          pageController: pageController,
                                        )
                                      ],
                                    ),
                                  ),
                            state.isSearch
                                ? Container()
                                : Expanded(
                                    child: PageView(
                                      controller: pageController,
                                      onPageChanged: (index) => context
                                          .read<PageViewCubit>()
                                          .changePage(index, state.isSearch),
                                      children: [
                                        Home(contact: allContact),
                                        Favourite(contact: favContact),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            );
          } else if (state is UserLoadedState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).colorScheme.primary,
                strokeWidth: 6,
              ),
            );
          } else if (state is UserErrorState) {
            //make new web cubit to check what's wrong
            return Text(state.error);
          } else {
            return Center(
              child: Text(
                "No contact list available. Please refresh the button.",
                textAlign: TextAlign.center,
                style: textStyle30,
              ),
            );
          }
        },
      ),
    );
  }
}
