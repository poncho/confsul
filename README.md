# Confsul
Configure your Elixir apps using Consul

## Configuration
Set your Consul client configuration in the config.exs
```
config :consul,
  host: "consul",
  port: 8500
```

Set the Consul folder where your keys are in the config.exs
```
config: :app_name,
  consul_folder: "/path/"
```

## Use
Load the config process using your app name
```
Confsul.Config.start(:app_name)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `confsul` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:confsul, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/confsul](https://hexdocs.pm/confsul).

