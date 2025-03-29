-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS tickets_app;

USE tickets_app;

-- Tabla para almacenar tickets
CREATE TABLE IF NOT EXISTS tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla para almacenar artículos de cada ticket
CREATE TABLE IF NOT EXISTS articulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    codigo VARCHAR(50),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    precio_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
);

-- Índices para mejorar rendimiento
CREATE INDEX idx_ticket_fecha ON tickets(fecha);
CREATE INDEX idx_articulos_ticket ON articulos(ticket_id);