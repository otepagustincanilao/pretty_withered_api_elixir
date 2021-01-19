defmodule PrettyWitheredApi.Contexts.UtilityContext do
  @moduledoc false

  alias PrettyWitheredApi.Repo
  alias PrettyWitheredApi.Endpoint

  import Ecto.Query

  alias Absinthe.Resolution
  alias Ecto.Adapters.SQL
  alias Ecto.Changeset

  defp transform_message(message, key), do: %{"#{key}" => "#{message}"}
  def transform_error_message(changeset, module \\ "") do
    errors = Enum.map(changeset.errors, fn({key, {message, _}}) ->
       transform_message(message, "#{module}#{key}")
    end)

    Enum.reduce(errors, fn(head, tail) ->
      Map.merge(head, tail)
    end)
  end

  def handle_errors(fun) do
    fn source, args, info ->
      case Resolution.call(fun, source, args, info) do
        {:error, %Changeset{} = changeset} -> format_changeset(changeset)
        {:error, field, message} -> {:error, %{message: message, field: field}}
        val -> val
      end
    end
  end

  def format_changeset(changeset) do
    errors =
      changeset
      |> Changeset.traverse_errors(fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)
      |> Enum.map(fn {field, message} ->
        field_name = Inflex.camelize(field, :lower)

        transform_error_message_graphql(field_name, message)
      end)

    {:error, errors}
  end

  def transform_error_message_graphql("pageNumber" = field_name, ["is invalid"] = message),
    do: %{message: "Page number #{message}", field: field_name}

  def transform_error_message_graphql("displayPerPage" = field_name, ["is invalid"] = message),
    do: %{message: "Display per page #{message}", field: field_name}

  def transform_error_message_graphql("code" = field_name, ["Enter"]),
    do: %{message: "Enter code", field: field_name}

  def transform_error_message_graphql(field_name, message),
    do: %{message: "#{message}", field: field_name}

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  def add_duration_to_date(datetime, duration) do
    # string_datetime = 
      datetime
      |> Timex.add(Timex.Duration.from_days(1))
      |> DateTime.to_string()

    # "#{string_datetime} | UTC"
  end

  def to_atom_map(nil), do: []
  def to_atom_map(datas) do
    datas
    |> Enum.into([], &Enum.into(&1, %{}, fn {k, v} -> {String.to_atom(k), v} end))
  end

  def convert_str_to_atom(str) do
    String.to_existing_atom(str)

    rescue
      _ ->
        String.to_atom(str)
  end

  def sorting_and_order_by(query, field, "asc") do
    field = convert_str_to_atom(field)
    query |> order_by([c], asc: field(c, ^field))
  end
  def sorting_and_order_by(query, field, "desc") do
    field = convert_str_to_atom(field)
    query |> order_by([c], desc: field(c, ^field))
  end

end
