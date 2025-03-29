#!/usr/bin/env python
"""
Script para aplicar cambios a la base de datos desde archivos SQL.
"""

import os
import sys
import mysql.connector
from dotenv import load_dotenv

def connect_db():
    """Establece conexión con la base de datos usando variables de entorno"""
    load_dotenv()  # Cargar variables de entorno desde .env
    
    try:
        conn = mysql.connector.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            user=os.getenv('DB_USER', 'root'),
            password=os.getenv('DB_PASSWORD', ''),
            database=os.getenv('DB_NAME', 'tickets_app')
        )
        print(f"✅ Conexión establecida con la base de datos {os.getenv('DB_NAME', 'tickets_app')}")
        return conn
    except mysql.connector.Error as err:
        print(f"❌ Error al conectar a la base de datos: {err}")
        sys.exit(1)

def apply_sql_file(file_path):
    """
    Ejecuta las sentencias SQL de un archivo.
    
    Args:
        file_path: Ruta al archivo SQL a ejecutar
    """
    if not os.path.exists(file_path):
        print(f"❌ El archivo {file_path} no existe.")
        return False
    
    conn = connect_db()
    cursor = conn.cursor()
    
    try:
        with open(file_path, 'r') as f:
            sql_script = f.read()
        
        # Separar las declaraciones SQL individuales
        statements = sql_script.split(';')
        
        executed = 0
        skipped = 0
        failed = 0
        
        print(f"\n🔄 Aplicando cambios desde {file_path}...\n")
        
        for i, statement in enumerate(statements):
            # Ignorar líneas vacías o comentarios
            statement = statement.strip()
            if not statement or statement.startswith('--'):
                skipped += 1
                continue
            
            try:
                cursor.execute(statement + ';')
                print(f"✓ Ejecutado ({i+1}/{len(statements)}): {statement[:60]}...")
                executed += 1
            except mysql.connector.Error as err:
                print(f"✗ Error ({i+1}/{len(statements)}): {err}")
                failed += 1
                
        conn.commit()
        print(f"\n✅ Cambios aplicados: {executed} ejecutados, {skipped} ignorados, {failed} fallidos.")
        return True
    except Exception as e:
        print(f"❌ Error al aplicar cambios: {str(e)}")
        conn.rollback()
        return False
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    """Aplicar cambios desde un archivo SQL específico"""
    
    # Archivo a aplicar
    if len(sys.argv) > 1:
        file_path = sys.argv[1]
    else:
        file_path = "db_update_comparativa.sql"
    
    if not os.path.exists(file_path):
        print(f"❌ No se encontró el archivo {file_path}")
        sys.exit(1)
    
    # Confirmar con el usuario antes de continuar
    confirm = input(f"⚠️ ¿Desea aplicar los cambios de {file_path} a la base de datos? (s/n): ")
    if confirm.lower() != 's':
        print("Operación cancelada.")
        sys.exit(0)
    
    # Aplicar cambios
    if apply_sql_file(file_path):
        print("✅ Los cambios se aplicaron correctamente.")
    else:
        print("❌ Se encontraron problemas al aplicar los cambios.")
        sys.exit(1)