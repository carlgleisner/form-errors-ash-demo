defmodule DemoWeb.DemoLive do
  use DemoWeb, :live_view
  @impl true
  def render(assigns) do
    ~H"""
    <div class="border-l-4 border-blue-400 bg-blue-50 p-4">
      <div class="flex">
        <div class="flex-shrink-0">
          <.icon name="hero-information-circle-mini" class="h-5 w-5 text-blue-400" />
        </div>
        <div class="ml-3 space-y-3">
          <p class="text-sm">
            First test submitting the form without filling it out. This should work as expected with both fields showing errors.
          </p>
          <p class="text-sm">
            Then reload the page and test filling out only the Food field and then submitting. This leaves the Name field <span class="font-mono">_unused</span>, thus not rendering the validation error leaving it blank creates.
          </p>
          <p class="text-sm">
            Obviously, the radio group is not expected to ever hide the errors since that component does not check for <span class="font-mono">used_input?/1</span>.
          </p>
        </div>
      </div>
    </div>
    <.simple_form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:name]} label="Name" phx-debounce={400} autofocus data-1p-ignore />
      <.radio_group field={@form[:food]} label="Food">
        <:radio value="pizza">Pizza</:radio>
        <:radio value="taco">Taco</:radio>
        <:radio value="glue">Glue (illegal)</:radio>
      </.radio_group>
      <:actions>
        <.button>Place order</.button>
      </:actions>
    </.simple_form>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    form =
      Demo.Survey.Form
      |> AshPhoenix.Form.for_create(:create,
        # domain: Demo.Food,
        as: "order",
        forms: [auto?: true]
      )

    {:ok, assign(socket, form: to_form(form))}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, :page_title, "Demo")}
  end

  @impl true
  def handle_event("validate", %{"order" => order_params}, socket) do
    {:noreply,
     assign(socket, :form, AshPhoenix.Form.validate(socket.assigns.form, order_params) |> dbg())}
  end

  def handle_event("save", %{"order" => order_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: order_params) do
      {:ok, order} ->
        {:noreply,
         socket
         |> put_flash(:info, "Received order for #{order.name}!")
         |> push_navigate(to: ~p"/")}

      {:error, form} ->
        {:noreply, assign(socket, form: form) |> dbg()}
    end
  end
end
