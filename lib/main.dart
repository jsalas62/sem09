import 'package:flutter/material.dart';
import 'models/categoria.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ListaConCategorias(),
        '/detalle': (context) => DetalleProducto(),  // Ruta para la nueva pantalla
      },
    );
  }
}

class ListaConCategorias extends StatelessWidget {
  final List<Categoria> categorias = [
    Categoria(nombre: 'Pizza', categoria: 'Alimentos', imageUrl: 'assets/images/pizza.png'),
    Categoria(nombre: 'Gato', categoria: 'Animales', imageUrl: 'assets/images/gato.png'),
    Categoria(nombre: 'Paris', categoria: 'Lugares', imageUrl: 'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/474000/474240-Left-Bank-Paris.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista con Categorías')),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];

          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: !categoria.imageUrl.startsWith('http')
                  ? Image.asset(categoria.imageUrl, fit: BoxFit.cover)
                  : Image.network(categoria.imageUrl, fit: BoxFit.cover),
            ),
            title: Text(
              categoria.nombre,
              style: TextStyle(
                fontFamily: getFontFamily(categoria.categoria),
                fontSize: 18,
              ),
            ),
            onTap: () {
              // Navegar a la pantalla de detalles del producto
              Navigator.pushNamed(context, '/detalle', arguments: categoria);
            },
          );
        },
      ),
    );
  }

  String getFontFamily(String categoria) {
    switch (categoria) {
      case 'Alimentos':
        return 'OpenSans';
      case 'Animales':
        return 'Lato';
      case 'Lugares':
        return 'Ubuntu';
      default:
        return 'Roboto';
    }
  }
}

class DetalleProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recibimos el producto a través de los argumentos
    final Categoria categoria = ModalRoute.of(context)!.settings.arguments as Categoria;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoria.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Center(
              child: !categoria.imageUrl.startsWith('http')
                  ? Image.asset(categoria.imageUrl, height: 200, fit: BoxFit.cover)
                  : Image.network(categoria.imageUrl, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            // Nombre del producto con fuente Montserrat
            Text(
              categoria.nombre,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Precio del producto con fuente Roboto
            Text(
              '\$99.99', // Aquí puedes cambiar por el precio real si lo tienes en los datos de la categoría
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            // Descripción del producto con fuente Nunito
            Text(
              'Descripción del producto: Este es un ejemplo de producto increíble. Está hecho con materiales de alta calidad y tiene un diseño único.',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
