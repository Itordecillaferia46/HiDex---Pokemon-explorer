# HiDex – Pokémon Explorer

HiDex es una aplicación desarrollada en **Flutter** que explora los primeros Pokémon utilizando la **PokéAPI**.  
El objetivo del proyecto fue construir una app **rápida, clara y visualmente atractiva**, manteniendo una arquitectura sencilla y fácil de escalar.

El diseño visual está inspirado en la paleta de colores de **Hi Beauty**, utilizando tonos rosados vibrantes para crear una interfaz moderna y amigable.

---

# 📱 Características

### 🔎 Catálogo de Pokémon
Visualización de los primeros **20 Pokémon** en un **grid limpio y organizado**.

### ⚡ Buscador en tiempo real
Filtrado dinámico mientras el usuario escribe, sin necesidad de recargar datos.

### 📊 Vista de detalle
Cada Pokémon cuenta con una pantalla dedicada que muestra:

- Tipos
- Estadísticas base
- Altura
- Peso
- Imagen oficial

### 🎨 Diseño visual
La interfaz utiliza una paleta inspirada en **Hi Beauty**, con:

- Rosa principal como color de marca
- Fondo suave para mejorar legibilidad
- Tarjetas limpias con sombras suaves

### 🌐 Manejo de errores
Si ocurre un fallo de conexión:

- Se muestra una pantalla clara de error
- El usuario puede **reintentar la carga con un botón**

Esto evita pantallas vacías y mejora la experiencia.

---

# 🚀 Instalación

## Requisitos

- Flutter SDK **>= 3.0**
- VS Code con extensiones **Flutter y Dart**
- Emulador o dispositivo físico

---

## Clonar el repositorio

```bash
git clone https://github.com/Itordecillaferia46/HiDex---Pokemon-explorer.git
cd HiDex---Pokemon-explorer
````

---

## Instalar dependencias

```bash
flutter pub get
```

---

## Ejecutar la aplicación

```bash
flutter run
```

---

# 🏗️ Estructura del proyecto

La aplicación está organizada por responsabilidades para facilitar mantenimiento y escalabilidad.

```
lib/
│
├── main.dart
│   Configuración inicial de la aplicación y tema global
│
├── router.dart
│   Navegación usando GoRouter
│
├── core/
│   Colores y constantes globales
│
├── models/
│   Modelos de datos utilizados en la aplicación
│
├── services/
│   Conexión con la PokéAPI
│
├── screens/
│   Pantallas principales
│   - HomeScreen
│   - DetailScreen
│
└── widgets/
    Componentes reutilizables
    - PokemonCard
    - TypeBadge
    - StatBar
```

---

# ⚙️ Decisiones técnicas

## Gestión de estado

Se utilizó:

```
setState + FutureBuilder
```

Para una aplicación de este tamaño, usar librerías como:

* Riverpod
* BLoC
* Provider

habría añadido complejidad innecesaria.

El objetivo fue mantener el código **simple, legible y fácil de seguir**.

---

## Navegación

Se utilizó:

```
go_router
```

Ventajas:

* Navegación declarativa
* Manejo limpio de rutas
* Parámetros dinámicos

Ejemplo:

```
/detail/:name
```

---

## Optimización de imágenes

En lugar de:

```
Image.network
```

se utilizó:

```
cached_network_image
```

Esto permite:

* cache automático
* navegación más fluida
* menos descargas repetidas

---

# 🎨 Identidad visual

El diseño está inspirado en la identidad de **Hi Beauty**.

Paleta principal:

```
Primary: #E91E63
Background: #FFF0F6
Card: #FFFFFF
```

Objetivo del diseño:

* interfaz moderna
* contraste suave
* experiencia visual atractiva

---

# 📦 Dependencias principales

```
http
```

Para consumir la PokéAPI.

```
go_router
```

Para navegación entre pantallas.

```
cached_network_image
```

Para optimizar la carga de imágenes.

---

# 💡 Aprendizajes del proyecto

Uno de los puntos más interesantes fue implementar **búsqueda en tiempo real** conectando:

```
TextEditingController
+
setState
+
FutureBuilder
```

Esto permitió filtrar datos de manera eficiente sin volver a hacer solicitudes a la API.

El proyecto también sirvió como práctica para:

* estructuración de proyectos Flutter
* manejo de asincronía
* consumo de APIs REST
* optimización visual en interfaces móviles

---

# 👨‍💻 Autor

**Isaac Tordecilla Feria**

Flutter Developer
Colombia

GitHub
[https://github.com/Itordecillaferia46](https://github.com/Itordecillaferia46)

```

---

💡 **Te recomiendo también cambiar el nombre del repo para que se vea más profesional:**

En lugar de:

```

HiDex---Pok-mon-explorer

```

mejor usa:

```

hidex-pokemon-explorer

```

o incluso:

```

hidex-pokedex-flutter

```

---

Si quieres, también puedo ayudarte a crear **3 cosas que aumentan mucho las probabilidades de que te contraten con este repo**:

1️⃣ un **GIF de la app funcionando para el README**  
2️⃣ una **sección "Screenshots" atractiva**  
3️⃣ optimizar el README para **reclutadores de Flutter**.
```
