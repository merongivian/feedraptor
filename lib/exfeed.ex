defmodule Exfeed do
  defmodule Entry do
    defstruct []
  end

  defmodule Image do
    defstruct [
      :url,
      :title,
      :link,
      :width,
      :height,
      :description
    ]
  end
end
