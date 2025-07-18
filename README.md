# Howgarts Compendium

**Howgarts Compendium** es una aplicación diseñada para fans del universo de *Harry Potter*, que permite explorar información detallada y precisa sobre el mundo mágico creado por J.K. Rowling. Esta aplicación se conecta directamente con la API [PotterDB](https://potterdb.com/), lo que garantiza el acceso a una base de datos que recolecta personajes, casas, hechizos, criaturas y mucho más de este basto universo.

## Funcionalidades principales

- **Búsqueda específica**: Encuentra personajes, hechizos, casas y criaturas mediante un sistema de búsqueda rápida y eficiente.
- **Información detallada**: Accede a fichas completas con datos relevantes extraídos directamente desde la API PotterDB.
- **Personalización por preferencias**: Personaliza tu experiencia según tu casa, hechizos, pociones y películas favoritas.
- **Persistencia de datos**: Toda la información de los usuarios se guardará en sus dispositivos para mantener sus elementos preferidos.

## Casos de uso
- Al iniciar por primera vez la aplicación, el usuario puede seleccionar su nombre y casa de Hogwarts. Esta información se guarda localmente para ofrecer una experiencia temática personalizada en base a su casa elegida.
- Un usuario desea saber más sobre el hechizo Alohomora. Abre la app, accede al compendio, y utiliza el buscador para obtener una ficha completa con su descripción, efectos y clasificación mágica.
- El usuario accede al listado de personajes y marca a Hermione Granger como favorita. Esta información se guarda en sus preferencias, y luego puede ser consultada desde su perfil.
- Si no hay conexión a internet, el usuario es notificado mediante un mensaje, y se desactivan temporalmente las funcionalidades dependientes de la API, como acceder al compendio o actualizar datos.
- En una sesión posterior, el usuario desea cambiar su casa. Desde la sección "Perfil", accede a la opción de editar su preferencia y elige otra casa, lo cual actualiza tanto el estado de la aplicación como su temática visual.
- Desde el compendio, el usuario puede consultar libros o películas específicas, revisando datos como fechas de estreno, directores, y conexiones entre personajes y eventos.

# Estructura del Proyecto

- lib/
  - pages/ Contiene las diferentes pantallas de la aplicación (Home, Perfil, Detalles, etc.)
  - services/ Maneja la lógica de conexión con APIs, como las solicitudes a PotterDB
  - provider/ Almacena la lógica de estado y gestión de datos mediante Provider
  - models/ Contiene todas las clases del proyecto que permiten la modularidad y recibimiento de la información desde la API.
  - utils/ Maneja archivos dedicados a utilidades extra de la aplicación.

# Anexos
- [Wireframe del proyecto](https://drive.google.com/file/d/1FbzjnW2xx8KoXnVahpZ2RUmN0pvkAgFP/view?usp=sharing)
- Video-presentación del proyecto: https://youtu.be/s_xzYMJaJaA
- [APK] (app-debug.apk)
