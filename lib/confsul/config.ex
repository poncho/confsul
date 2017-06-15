defmodule Confsul.Config do
  @moduledoc """
  Manages the app config from Consul
  """

  require Consul

  @doc """
  Loads and sets the app configuration from Consul
  """
  @spec start(atom) :: any
  def start(app) do
    app
    |> load
    |> set_config(app)
  end

  @doc """
  Loads the config data from Consul
  """
  @spec load(atom) :: map
  def load(app) do
    folder = Application.get_env(app, :config_folder)
    case Consul.Kv.keys(folder) do
      {:ok, response} ->
        response
        |> Map.get(:body)
        |> Enum.reduce(%{}, fn option, acc ->
          Map.put(acc, key(option), get_value(option))
        end)
      _ ->
        %{}
    end
  end

  @doc """
  Sets the config for the specified application
  """
  @spec set_config(map, atom) :: boolean
  def set_config(config_list, app) do
    for {key, value} <- config_list do
      Application.put_env(app, String.to_atom(key), value)
    end
  end

  # Returns the value from the key
  @spec get_value(String.t) :: String.t
  defp get_value(key) do
    case Consul.Kv.fetch(key) do
      {:ok, response} ->
        response
        |> Map.get(:body)
        |> Enum.at(0)
        |> Map.get("Value")
        |> parse
    end
  end
  

  # Returns the key without the folders
  @spec key(String.t) :: String.t
  defp key(fullkey) do
    result = Regex.run(~r/\/([^\/]+$)/, fullkey)
    result && length(result) > 1 && Enum.at(result, 1) || "nokey"
  end

  # Parses the value
  @spec parse(String.t) :: any
  defp parse(value) do
    fvalue = String.downcase(value)
    # If boolean
    if fvalue == "true" || fvalue == "false" do
      fvalue == "true"
    else
      case Integer.parse(value) do
        {number, ""} -> number # If int
        _ ->
          case Float.parse(value) do
            {number, ""} ->
              number # If float
            {_, _} ->
              value
          end
      end
    end
  end
end
