defmodule Feedraptor.Helper do
  def update_date_fields(fields, opts \\ []) do
    keys   = opts[:keys] || [:published, :updated]
    format = opts[:format] || "ISO_8601"

    new_dates = Enum.reduce keys, %{}, fn(date_key, date_fields) ->
                  Map.merge(
                    date_fields,
                    %{date_key => to_date_time(fields[date_key], format)}
                  )
                end

    Map.merge(fields, new_dates)
  end

  def to_date_time(nil, _), do: nil
  def to_date_time(date_time_string), do: to_date_time(date_time_string, "RFC_1123")
  def to_date_time(date_time_string, format) do
    case format do
      "ISO_8601" ->
        {:ok, date_time, _} = DateTime.from_iso8601(date_time_string)
        date_time
      "RFC_1123" ->
        {:ok, date_time} = Timex.parse(date_time_string, "{RFC1123}")
        date_time
    end
  end
end
