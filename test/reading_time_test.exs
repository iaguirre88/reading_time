defmodule ReadingTimeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties
  doctest ReadingTime

  property "the time/2 function grows linearly" do
    check all(
            initial_value <-
              StreamData.scale(StreamData.positive_integer(), fn size -> size * 10 end),
            multiplier <- StreamData.integer(2..100)
          ) do
      text_length = initial_value + 200
      short_text = String.duplicate("abcd ", text_length)
      long_text = String.duplicate("abcd ", text_length * multiplier)

      assert_in_delta ReadingTime.time(long_text),
                      ReadingTime.time(short_text) * multiplier,
                      multiplier
    end
  end
end
