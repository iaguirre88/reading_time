defmodule ReadingTime do
  @moduledoc """
  Documentation for ReadingTime.
  """

  @split_pattern [" ", "\n", "\r", "\t"]
  @words_per_minute 200
  @markdown_words [
    # ignore headers
    ~r/#+/,
    ~r/(==)+/,
    ~r/(--)+/,
    # ingore boxed text
    ~r/>+/,
    # ignore unordered lists
    ~r/(-)+/,
    ~r/(\*)+/,
    ~r/(\+)+/,
    # ignore horizontal rules
    ~r/----*/,
    ~r/\*\*(\*)+/,
    ~r/___+/,
  ]

  defp markdown_word?(word) do
    Enum.any?(
      @markdown_words,
      fn md_word ->
        Regex.match?(md_word, word)
      end
    )
  end

  defp ignore_format_words(words, :text) do
    words
  end

  defp ignore_format_words(words, :markdown) do
    words
    |> Enum.filter(
      fn word ->
        !markdown_word?(word)
      end
    )
  end

  @spec time(
          String.t(),
          words_per_minute: non_neg_integer(),
          split_pattern: nonempty_list(String.t()),
          format: atom()
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
    text_format = Keyword.get(opts, :text_format, :text)
    words =
      string
      |> String.split(split_pattern, trim: true)
      |> ignore_format_words(text_format)
      |> length

    minutes =
      Float.ceil(words / words_per_minute)
      |> trunc

    minutes
  end
end
