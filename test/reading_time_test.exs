defmodule ReadingTimeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties
  doctest ReadingTime

  @split_pattern [" ", "\n", "\r", "\t"]
  @split_patterns [[" ", "\n", "\r", "\t"], ["#", "$", "%"]]

  @words_per_minute 200

  property "the time/1 function grows linearly" do
    check all(
            short_text_multiplier <- StreamData.integer(1..5),
            long_text_multiplier <- StreamData.integer(2..100),
            splitter <- StreamData.member_of(@split_pattern)
          ) do
      text_length = @words_per_minute * short_text_multiplier

      short_text = String.duplicate("abcd#{splitter}", text_length)
      long_text = String.duplicate("abcd#{splitter}", text_length * long_text_multiplier)

      assert ReadingTime.time(long_text) == ReadingTime.time(short_text) * long_text_multiplier
    end
  end

  property "the time/1 function grows linearly with custom params" do
    check all(
            short_text_multiplier <- StreamData.integer(1..5),
            long_text_multiplier <- StreamData.integer(2..100),
            split_pattern <- StreamData.member_of(@split_patterns),
            splitter <- StreamData.member_of(split_pattern),
            words_per_minute <- StreamData.integer(10..100)
          ) do
      text_length = words_per_minute * short_text_multiplier

      short_text = String.duplicate("abcd#{splitter}", text_length)
      long_text = String.duplicate("abcd#{splitter}", text_length * long_text_multiplier)

      assert ReadingTime.time(long_text,
               split_pattern: split_pattern,
               words_per_minute: words_per_minute
             ) ==
               ReadingTime.time(short_text,
                 words_per_minute: words_per_minute,
                 split_pattern: split_pattern
               ) * long_text_multiplier
    end
  end

  property "Markdown formatters get ignored" do
    text = "
    # This is a header1.

    ## This is a header2.

    This is also a header1.
    ==

    This is also a header2.
    --

    > This is a blockquote
    >> This is a nested blockquote
    >> # This is a header1 inside a blockquote

    ---

    - List1
    + List2
    * List3

    ***

    ___

    "
    actual_words = 37
    assert ReadingTime.time(text, words_per_minute: 1, text_format: :markdown) == actual_words
  end

end
