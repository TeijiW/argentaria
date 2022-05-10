defmodule PrettyJason do
  def encode_to_iodata!(content) do
    Jason.encode_to_iodata!(content,
      pretty: [record_separator: "", line_separator: "", indent: "", after_colon: " "]
    )
  end
end
