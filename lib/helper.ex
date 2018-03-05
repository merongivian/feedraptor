defmodule Feedraptor.Helper do
  def update_date_fields(fields, opts \\ []) do
    keys = opts[:keys] || [:published, :updated]

    new_dates = Enum.reduce keys, %{}, fn(date_key, date_fields) ->
                  Map.merge(
                    date_fields,
                    %{date_key => to_date_time(fields[date_key])}
                  )
                end

    Map.merge(fields, new_dates)
  end

  def to_date_time(nil), do: nil
  def to_date_time(date_time_string) do
    to_rfs1123 = fn(string) ->
      case Timex.parse(date_time_string, "{RFC1123}") do
        {:ok, date_time} -> date_time
        {:error, _}      -> date_time_string
      end
    end

    case DateTime.from_iso8601(date_time_string) do
      {:ok, date_time, _} -> date_time
      {:error, _}         -> to_rfs1123.(date_time_string)
    end
  end
end
