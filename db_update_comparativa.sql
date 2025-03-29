-- Script para añadir comparativa de precios entre supermercados

-- 1. Crear tabla para almacenar supermercados
CREATE TABLE IF NOT EXISTS supermercados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    url VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE,
    UNIQUE KEY (nombre)
) ENGINE=InnoDB;

-- 2. Insertar algunos supermercados comunes
INSERT IGNORE INTO supermercados (nombre, url) VALUES 
('Alcampo', 'https://www.alcampo.es'),
('Mercadona', 'https://www.mercadona.es'),
('Carrefour', 'https://www.carrefour.es'),
('Dia', 'https://www.dia.es'),
('Lidl', 'https://www.lidl.es');

-- 3. Crear tabla para almacenar las relaciones entre productos
CREATE TABLE IF NOT EXISTS productos_equivalentes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    supermercado_id INT NOT NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    url_producto VARCHAR(255),
    imagen_url VARCHAR(255),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    FOREIGN KEY (supermercado_id) REFERENCES supermercados(id) ON DELETE CASCADE,
    UNIQUE KEY (producto_id, supermercado_id)
) ENGINE=InnoDB;

-- 4. Crear tabla para almacenar el historial de precios
CREATE TABLE IF NOT EXISTS precios_supermercados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_equivalente_id INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    en_oferta BOOLEAN DEFAULT FALSE,
    cantidad DECIMAL(10, 3) DEFAULT 1.000,
    unidad VARCHAR(20) DEFAULT 'unidad',
    precio_por_unidad DECIMAL(10, 2) AS (precio / cantidad),
    FOREIGN KEY (producto_equivalente_id) REFERENCES productos_equivalentes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Añadir índices para mejorar rendimiento
CREATE INDEX idx_producto_equiv ON productos_equivalentes(producto_id, supermercado_id);
CREATE INDEX idx_precios_producto ON precios_supermercados(producto_equivalente_id);
CREATE INDEX idx_precios_fecha ON precios_supermercados(fecha_registro);

-- 6. Modificar la tabla de artículos para facilitar la edición
ALTER TABLE articulos MODIFY COLUMN nombre VARCHAR(200) NOT NULL;
ALTER TABLE articulos MODIFY COLUMN cantidad DECIMAL(10, 3) NOT NULL DEFAULT 1.000;
ALTER TABLE articulos MODIFY COLUMN precio_unitario DECIMAL(10, 2) NOT NULL; 
ALTER TABLE articulos MODIFY COLUMN precio_total DECIMAL(10, 2) NOT NULL;