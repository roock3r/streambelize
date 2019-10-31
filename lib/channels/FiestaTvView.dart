import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class FiestaTv extends StatefulWidget {
  FiestaTv({Key key, this.title, this.url,this.color}) : super(key: key);

  final String title;
  final String url;
  final color;
  @override

  _FiestaTvState createState() => _FiestaTvState();
}

class _FiestaTvState extends State<FiestaTv> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {

    _controller = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose(){

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: () {
              fullScreen(context);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){

            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,

              child: VideoPlayer(_controller),
            );
          }else{

            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  void fullScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(

      builder: (BuildContext context) {
        return
          Container(
            child: _controller.value.initialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : CircularProgressIndicator(),
          );
      },
    ),
    );
  }

}
