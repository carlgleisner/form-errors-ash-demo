defmodule Demo.Survey.Form do
  use Ash.Resource,
    data_layer: :embedded,
    validate_domain_inclusion?: false

  attributes do
    attribute :name, :string, public?: true, allow_nil?: false

    attribute :food, :string,
      public?: true,
      allow_nil?: false
  end

  validations do
    validate one_of(:food, [:pizza, :taco]),
      message: "oh yeah, you must have either pizza or taco, sorry about that"
  end
end
