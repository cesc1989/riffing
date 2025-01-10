# Prueba crear exceptiones personalizadas y cómo hacerlas interactuar con
# ExceptionLogger

require "amazing_print"

class BitlyErrorException < StandardError
  def initialize(msg = 'Exception de Bitly')
    super(msg)
  end
end

class Sentry
  def self.capture_exception(exception, level: "error", extra: {})
    ap exception
    ap extra
  end
end

class ExceptionLogger
  def self.log(exception, log_message, options = {})
    puts log_message

    Sentry.capture_exception(
      exception,
      extra: options
    )
  end
end

class PruebaException
  def prueba_esta
    raise BitlyErrorException
  rescue => e
    ExceptionLogger.log(e, "Error de PruebaEsta")
  end

  def levanta_exception
    raise BitlyErrorException
  rescue => e
    ExceptionLogger.log(e, "Levanté exception")
  end
end

PruebaException.new.prueba_esta
PruebaException.new.levanta_exception
