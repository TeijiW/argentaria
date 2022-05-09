defmodule PrettyJason do
  def encode_to_iodata!(content) do
    Jason.encode_to_iodata!(content,
      pretty: [line_separator: "", indent: "", record_separator: ""]
    )
  end
end
