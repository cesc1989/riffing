#!/usr/bin/env ruby
#
# Kindle Clippings Cleaner - Procesa archivos de resaltados de Kindle
#
# Uso:
#   ruby kindle_clippings_cleaner.rb <archivo_entrada> <archivo_salida>

def limpiar_clippings(archivo_entrada, archivo_salida)
  contenido = File.read(archivo_entrada, encoding: 'utf-8')

  # Separar cada clip por los separadores
  clips = contenido.strip.split('==========')

  solo_highlights = []

  clips.each do |clip|
    lineas = clip.strip.split("\n")

    # Un clip válido debe tener al menos 2 líneas de metadatos
    next if lineas.size < 2

    # Las primeras dos líneas son metadatos
    metadata1 = lineas[0]
    metadata2 = lineas[1]

    # Buscar contenido real (ignorar líneas vacías después de metadatos)
    contenido_texto = nil
    lineas[2..-1].each do |linea|
      unless linea.strip.empty?
        contenido_texto = linea.strip
        break
      end
    end

    # Verificamos que el contenido no esté vacío y tenga sentido
    # Filtramos líneas muy cortas (notas como "k", "enshi", etc.)
    next unless contenido_texto && contenido_texto.length > 3

    # Reconstruimos el clip
    clip_limpio = "#{metadata1}\n#{metadata2}\n#{contenido_texto}\n=========="
    solo_highlights << clip_limpio
  end

  # Escribir el archivo de salida
  File.write(archivo_salida, solo_highlights.join("\n"), encoding: 'utf-8')

  puts "✅ Procesado: #{archivo_entrada}"
  puts "📊 Resaltados encontrados: #{solo_highlights.size}"
  puts "💾 Guardado en: #{archivo_salida}"
end

if __FILE__ == $0
  if ARGV.size < 2
    puts 'Uso: ruby kindle_clippings_cleaner.rb <archivo_entrada> <archivo_salida>'
    exit 1
  end

  archivo_origen = ARGV[0]
  archivo_destino = ARGV[1]

  limpiar_clippings(archivo_origen, archivo_destino)
end
