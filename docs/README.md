# Documentación del Gestor de Tickets

Esta carpeta contiene documentación adicional sobre el proyecto.

## Estructura de la base de datos

![Diagrama ER](/docs/database_schema.png)

## Flujo de trabajo

1. **Procesamiento de tickets**
   - Carga de imagen
   - Análisis OCR
   - Extracción de datos
   - Almacenamiento en base de datos

2. **Comparación de precios**
   - Búsqueda de productos
   - Normalización de nombres
   - Cálculo de diferencias
   - Presentación visual

## Formato de datos

La aplicación utiliza XML para estructurar los datos extraídos de los tickets:

```xml
<ticket>
  <empresa>
    <nombre>Nombre de la Empresa</nombre>
  </empresa>
  <detalles>
    <fecha>YYYY-MM-DD</fecha>
    <total>99.99</total>
  </detalles>
  <articulos>
    <articulo>
      <nombre>Nombre del producto</nombre>
      <codigo>ABC123</codigo>
      <cantidad>1</cantidad>
      <precio_unitario>9.99</precio_unitario>
      <precio_total>9.99</precio_total>
    </articulo>
  </articulos>
</ticket>
```