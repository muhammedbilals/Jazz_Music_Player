import 'package:flutter/material.dart';

class AlertDialogs extends StatelessWidget {
  const AlertDialogs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AlertDialog Sample')),
        body: const Center(
          child: DialogExample(),
        ),
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Column(
            
            children: [
           TextButton.icon(onPressed: (){}, icon: Icon(Icons.favorite), label: Text('Add to Favourites')),
           TextButton.icon(onPressed: (){}, icon: Icon(Icons.playlist_add), label: Text('Add to Playlist')),
           TextButton.icon(onPressed: (){}, icon: Icon(Icons.share), label: Text('Share')),
           TextButton.icon(onPressed: (){}, icon: Icon(Icons.shuffle), label: Text('Shuffle')),
           TextButton.icon(onPressed: (){}, icon: Icon(Icons.repeat), label: Text('Repeat'))
              
            ],
          ),
          
          
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
