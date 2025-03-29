# Gestor de Tickets y Comparador de Precios

Aplicación de escritorio para procesar tickets de compra mediante OCR, análisis con IA y comparación de precios entre supermercados.

![Gestor de Tickets](/docs/screenshot.png)

## Características principales

- 🧾 **Procesamiento de tickets** mediante OCR y análisis con IA
- 📊 **Comparación de precios** entre diferentes supermercados
- 🔍 **Búsqueda de productos** y visualización de imágenes
- 📉 **Historial de precios** para análisis de tendencias
- ✏️ **Edición directa** de productos y cantidades
- 🔄 **Asociación automática** de productos equivalentes entre tiendas

## Requisitos previos

1. Python 3.7 o superior
2. MySQL Server instalado
3. Tesseract OCR instalado
4. API Key de OpenAI (opcional para análisis avanzado)

## Instalación

1. Clona este repositorio:
   ```bash
   git clone https://github.com/FeloSP8/gestor-tickets.git
   cd gestor-tickets
   ```

2. Instala las dependencias:
   ```bash
   pip install -r requirements.txt
   ```

3. Instala Tesseract OCR:
   - Windows: [Descarga el instalador](https://github.com/UB-Mannheim/tesseract/wiki)
   - Linux: `sudo apt-get install tesseract-ocr`
   - macOS: `brew install tesseract`

4. Configura la base de datos:
   - Crea la base de datos ejecutando el script `schema.sql` en tu servidor MySQL:
   ```bash
   mysql -u tu_usuario -p < schema.sql
   ```
   - Actualiza la estructura (si es una instalación nueva, ejecuta estos scripts en orden):
   ```bash
   mysql -u tu_usuario -p < db_update.sql
   mysql -u tu_usuario -p < db_update_comparativa.sql
   ```

5. Configura las variables de entorno:
   - Copia el archivo `.env-example` a `.env`
   - Completa las variables con tus datos:
     ```
     # Configuración de la base de datos
     DB_HOST=localhost
     DB_USER=tu_usuario
     DB_PASSWORD=tu_contraseña
     DB_NAME=tickets_app

     # Ruta a Tesseract OCR
     TESSERACT_PATH=ruta_a_tesseract

     # API Key de OpenAI (opcional)
     OPENAI_API_KEY=tu_api_key
     ```

## Uso

1. Ejecuta la aplicación:
   ```bash
   python main.py
   ```

2. La interfaz muestra tres pestañas principales:
   - **Procesar Tickets**: Para cargar y analizar nuevos tickets
   - **Ver Tickets**: Para revisar tickets procesados y comparar precios
   - **Productos**: Para gestionar el catálogo de productos

### Procesamiento de tickets

1. Selecciona la imagen del ticket
2. Haz clic en "Procesar ticket"
3. El sistema realizará:
   - OCR para extraer el texto
   - Análisis con IA para extraer productos, precios y cantidades
   - Almacenamiento en la base de datos

### Comparación de precios

1. Selecciona un ticket del listado
2. Haz clic en "Comparar precios online"
3. La aplicación buscará precios equivalentes en otros supermercados
4. Se mostrarán:
   - Diferencias de precio (en € y %)
   - Potencial ahorro total
   - Imágenes de productos para facilitar la identificación

### Edición de productos

- Haz doble clic en cualquier campo editable para modificarlo
- Los cambios se guardarán al hacer clic en "Guardar cambios"
- Puedes asociar productos entre diferentes supermercados

## Estructura del proyecto

- `main.py`: Aplicación principal con interfaz gráfica
- `schema.sql`: Estructura inicial de la base de datos
- `db_update.sql`: Actualización para gestión de productos
- `db_update_comparativa.sql`: Actualización para comparativa de precios
- `apply_db_changes.py`: Script para aplicar cambios a la base de datos
- `requirements.txt`: Dependencias de Python

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue para discutir cambios importantes antes de enviar un pull request.

## Licencia

[MIT License](LICENSE)