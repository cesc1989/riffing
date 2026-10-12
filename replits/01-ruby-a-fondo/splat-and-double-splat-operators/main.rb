def splatter(required, *splat_arr, **splat_hash)
  p [required, splat_arr, splat_hash]
end

def simple_splatter(one, two, three)
  p "#{one} - #{two} - #{three}"
end

# Prueba del action de Hanami que usa un splat anonimo.
def handle(*, response)
  puts(response)
end

# ['required', [], {}]
splatter('required')

# ["required", [1, 2, 3], {}]
splatter('required', *1..3, {})

# ["required", [1, 2, 3], {:a=>nil, :b=>nil}]
splatter('required', *1..3, a: nil, b: nil)

# ["required", [1, 2, 3], {:a=>[10, 11, 12], :b=>{:id=>1, :value=>2}}]
splatter('required', *1..3, a: [*10..12], b: { id: 1, value: 2})

simple_splatter(*1..3)

handle(response: "hola")
# {response: "hola"}

handle(request: "que", response: "mundo")
# {request: "que", response: "mundo"}

handle("que", "mundo")
# mundo
