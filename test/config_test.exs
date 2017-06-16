defmodule Confsul.ConfigTest do
  use ExUnit.Case

  import Mock
  import Confsul.Config, only: [
    start: 1,
    load: 1,
    parse: 1
  ]
  
  setup do
    [
      keys: {
        :ok,
        %{body: [
          "test/config1",
          "test/config2",
          "test/config3"]
        }
      },
      fetch: {
        :ok,
        %{body: [%{"Value" => "1"}]
        }
      }
    ]
  end

  test "Should set config with start", data do
    app = :confsul
    Application.put_env(app, :config_folder, "test")

    with_mock(
        Consul.Kv,
        [],
        [
          keys: fn(_) -> data.keys end,
          fetch: fn(_) -> data.fetch end
        ]
    ) do
      start(app)
      assert Application.get_env(app, :config1) == 1
      assert Application.get_env(app, :config2) == 1
      assert Application.get_env(app, :config3) == 1
    end 
  end

  test "Should return an empty map if Consul returns error" do
    app = :confsul
    Application.put_env(app, :config_folder, "test")

    with_mock(
        Consul.Kv,
        [],
        [
          keys: fn(_) -> {:error, ""} end
        ]
    ) do
      assert load(app) == %{}
    end
  end

  test "Should return an empty map if the config_folder is not setted" do
    assert load(:thisapphasnofolder)
  end

  test "Should parse correctly to the specified value" do
    assert parse("true") == true
    assert parse("1") == 1
    assert parse("10.52") == 10.52
    assert parse("string") == "string"
  end
end
