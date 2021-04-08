import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_favorites_youtube/blocs/favorite_bloc.dart';
import 'package:flutter_favorites_youtube/models/video_model.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(video.thumb, fit: BoxFit.cover,),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: bloc.outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                    return IconButton(
                      //caso o video esta na lista, coloco a estrela preenchida, caso não, coloco a estrela com borda
                      icon: Icon(snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: (){
                        bloc.toggleFavorite(video);
                      },
                  );
                  else
                    return CircularProgressIndicator();
                }
              )
            ],
          )
        ],
      ),
    );
  }
}
