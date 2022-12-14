defmodule Handin2.Commitments do
  @moduledoc """
  The Commitments module is responsible for handling the commitments of the dice game.
  """
  use TypeCheck
  require Logger

  alias Handin2.Utils

  @doc """
  Creates a commitment to a message.
  Generates a random bitstring of length 256 and hashes it with the message.
  Returns the random bitstring and the hash.
  """
  @spec! create(binary(), any()) :: {binary(), binary()}
  def create(bitstring, msg) do
    {bitstring, Utils.hash(bitstring <> Kernel.to_string(msg))}
  end

  @spec! create(any()) :: {binary(), binary()}
  def create(msg) do
    create(Utils.gen_bitstring(), Kernel.to_string(msg))
  end

  @doc """
  Verifies a commitment.
  Hashes the random bitstring with the message and compares it to the hash.
  Returns :ok if the hashes match, :error otherwise.
  """
  @spec! verify(String.t(), String.t()) :: :ok | :error
  def verify(hash, rmsg) do
    if hash == Utils.hash(rmsg),
      do: :ok,
      else: :error
  end

  @spec! verify(binary(), binary(), binary()) :: :ok | :error
  def verify(hash, bitstring, msg) do
    verify(hash, bitstring <> msg)
  end
end
