require 'minitest/autorun'
require 'set'
require_relative 'digits'

class TestDigits < Minitest::Test

  def test_congruent?
    extend Digits

    dist = '1111111122222223333333444566667777888888889999'
    assert(congruent?(5.times.reduce([]) {|acc, _| acc << shuffle_number(dist)}))
  end

  def test_digits
    extend Digits

    assert_equal digits(-34567), [3, 4, 5, 6, 7]
    assert_equal digits(0), [0]
  end

  def test_length
    extend Digits

    assert_equal length(-12345), 5
    assert_equal length(8), 1
  end

  private

  def shuffle_number(n)
    n.to_s.split('').shuffle.join.to_i
  end
end
