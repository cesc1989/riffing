params = %{
  "customer" => %{
    "id" => 123,
    "name" => "Willy Wonka Chocolates",
    "bonuses" => %{
      "employees" => %{
        "Oompa 1" => 1_000,
        "Oompa 2" => 2_000,
        "Hillary" => 1_500,
        "Oompa 3" => 500
      },
      "total" => 5_000
    }
  }
}

defmodule NestedBinding do
  def award_bonuses(%{"customer" => %{"bonuses" => %{"total" => bonus_total} = bonuses}} = _params) do
    IO.inspect bonus_total, label: "TOTAL TO VALIDATE"
    IO.inspect bonuses, label: "BONUSES"
    # TODO: validate intended total and employee amounts
    :ok
  end
end

NestedBinding.award_bonuses(params)
#=> TOTAL TO VALIDATE: 5000
#=> BONUSES: %{
#=>   "employees" => %{
#=>     "Hillary" => 1500,
#=>     "Oompa 1" => 1000,
#=>     "Oompa 2" => 2000,
#=>     "Oompa 3" => 500
#=>   },
#=>   "total" => 5000
#=> }
#=> :ok