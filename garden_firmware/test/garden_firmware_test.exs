defmodule GardenFirmwareTest do
  use ExUnit.Case
  doctest GardenFirmware

  test "greets the world" do
    assert GardenFirmware.hello() == :world
  end
end
