# **Comentarios de la prueba**


- He utilizado clean architecture en capas para poder desacoplarme mejor de la aplicación, he utilizado la capa datasource para poder tener la carpeta remote o incluso también una carpeta local para guardar cosas en la base de datos y poder mostrar al usuario si no tiene conexión a internet.

- En los table view he creado unos adaptadores para poder desacoplar lógica del controlador, he utilizado combine para las llamadas a la api ya que no necesitamos ningún framework externo para poder hacer esas peticiones.

- Las rutas he decidido utilizar una clase builder para crear la inyección de dependencias para tenerlo todo mas desacoplado.

- No he utilizado el localizable para la traducción de la app ya que es una prueba, en un entorno de producción se lo utilizaría.