def acepto_un_bloque
  puts "Antes del bloque"

  yield

  puts "Después del bloque"
end

class DS
  def self.pass_a_block(&block)
    if primera_condition?
      acepto_un_bloque do
        yield if segunda_condition?
      end
    else
      yield
    end
  end

  def self.primera_condition?
    true
  end

  def self.segunda_condition?
    true
  end
end

DS.pass_a_block do
  puts "Estoy ejecutandome desde el bloque"
end
