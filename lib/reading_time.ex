defmodule ReadingTime do
  @moduledoc """
  Documentation for ReadingTime.
  """

  @split_pattern [" ", "\n", "\r", "\t"]
  @words_per_minute 200

  @spec time(String.t()) :: number
  @doc """
  Returns the time in minutes for a given string.

  ## Examples

      iex> ReadingTime.time("this is a random text")
      1

  """
  def time(string) do
    words =
      string
      |> String.split(@split_pattern, trim: true)
      |> length

    minutes =
      (words / @words_per_minute)
      |> ceil

    minutes
  end
end
