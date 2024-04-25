# Prueba crear exceptiones personalizadas y cómo hacerlas interactuar con
# ExceptionLogger

class ExceptionLogger
  def self.log(exception, log_message)
    puts log_message

    begin
      raise exception, "✅ #{exception.message}", exception.backtrace
    rescue exception.class => e
      puts "Hola error"
    end
  end
end

class BitlyErrorException < StandardError
  def initialize(msg = 'soy una exception')
    super(msg)
  end
end

class PruebaException
  def prueba_esta
    ExceptionLogger.log(BitlyErrorException.new, 'soy un mensaje de error')
  end
end

PruebaException.new.prueba_esta
