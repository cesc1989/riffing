# data = %{name: "Hola", age: 23}
# data = %{name: "Chonca", age: 23}
data = 5

case data do
  %{name: "Hola"} -> IO.puts("Si, hola")
  %{name: name} -> IO.puts("Saludos, #{name}")
  %{age: age} -> IO.puts("aaj #{age}")
  _other -> IO.puts("que paso")
end

deeper = %{
  important_flag: true,
  level_1: %{
    other: "stuff",
    level_2: %{
      value: 123,
      more: "stuff"
    }
  }
}

case deeper do
  %{important_flag: false} -> IO.inspect({:ok, 0})
  %{important_flag: true, level_1: %{level_2: %{value: value}}} -> IO.inspect({:ok, value})
  _other -> IO.inspect({:error, "invalido"})
end