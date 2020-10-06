defmodule ReadingTime do
  @moduledoc """
  Documentation for ReadingTime.
  """

  @split_pattern [" ", "\n", "\r", "\t"]
  @words_per_minute 200

  @spec time(
          String.t(),
          words_per_minute: non_neg_integer(),
          split_pattern: nonempty_list(String.t())
        ) :: number
  @doc """
  Returns the time in minutes for a given string.

  ## Examples

      iex> ReadingTime.time("this is a random text")
      1

      iex> ReadingTime.time("this_is_a-random-text", words_per_minute: 1, split_pattern: ["_", "-"])
      5

  """
  def time(string, opts \\ []) do
    words_per_minute = Keyword.get(opts, :words_per_minute, @words_per_minute)
    split_pattern = Keyword.get(opts, :split_pattern, @split_pattern)

    # FIXME: test credo
    words =
      string
      |> String.split(split_pattern, trim: true)
      |> length

    minutes =
      Float.ceil(words / words_per_minute)
      |> trunc

    minutes
  end
end
