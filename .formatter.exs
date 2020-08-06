[
  import_deps: [:ecto, :phoenix],
  inputs: ["*.{ex,exs}", "{mix,.formatter}.exs", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 120,
  subdirectories: ["priv/*/migrations"]
]
