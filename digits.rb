require 'set'

module Digits
  # Two integers are congruent if they are anagrams of each other.
  def congruent?(*args)
    return true if args.count < 2

    counter = to_counter(args.shift.to_s)
    args.all? { |e| counter == to_counter(e.to_s) }
  end

  # Get an array of the digits in integer *number*.
  def digits(number)
    return [0] if number.zero?

    number = number.abs
    digits = []
    loop do
      digits.unshift(number % 10)
      number = number.div(10)
      return digits if number.zero?
    end
  end

  # Count the digits in integer *number*.
  def length(number)
    count = 0

    number = number.abs
    loop do
      count += 1
      number = number.div(10)
      return count if number.zero?
    end
  end

  private

  def to_counter(str)
    str.each_char.each_with_object(Hash.new) do |char, hash|
      hash[char] = str.count(char) unless hash.has_key?(char)
    end
  end
end
