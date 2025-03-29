-- Script para actualizar la estructura de la base de datos

-- 1. Crear tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    UNIQUE KEY (codigo)
) ENGINE=InnoDB;

-- 2. Migrar datos de artículos a productos (insertar productos únicos)
INSERT IGNORE INTO productos (codigo, nombre)
SELECT DISTINCT codigo, nombre
FROM articulos
WHERE codigo != 'N/A';

-- 3. Añadir campo producto_id a la tabla articulos
ALTER TABLE articulos ADD COLUMN producto_id INT NULL AFTER ticket_id;

-- 4. Actualizar producto_id basado en coincidencia de código
UPDATE articulos a
JOIN productos p ON a.codigo = p.codigo
SET a.producto_id = p.id
WHERE a.codigo != 'N/A';

-- 5. Manejar los artículos sin código válido
-- Para artículos con código 'N/A', crear registros de productos basados en nombre
INSERT INTO productos (codigo, nombre)
SELECT 
    CONCAT('AUTO_', MD5(nombre)), nombre
FROM articulos 
WHERE codigo = 'N/A'
GROUP BY nombre;

-- 6. Actualizar artículos con código 'N/A'
UPDATE articulos a
JOIN productos p ON a.nombre = p.nombre AND p.codigo LIKE 'AUTO_%'
SET a.producto_id = p.id
WHERE a.codigo = 'N/A' AND a.producto_id IS NULL;

-- 7. Crear índice en producto_id para mejorar rendimiento
ALTER TABLE articulos ADD INDEX idx_producto_id (producto_id);
ALTER TABLE articulos ADD FOREIGN KEY (producto_id) REFERENCES productos(id);