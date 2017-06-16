# Confsul
Configure your Elixir apps using [Consul](https://github.com/hashicorp/consul)

## Installation

Add `:confsul` to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:confsul, "~> 0.1.2"}]
end
```

## Configuration
Set your Consul client configuration in the config.exs
```elixir
config :consul,
  host: "consul",
  port: 8500
```

Set the Consul folder where your keys are in the config.exs
```elixir
config: :app_name,
  config_folder: "/path/"
```

## Use
Load the config process using your app name
```elixir
Confsul.Config.start(:app_name)
```
