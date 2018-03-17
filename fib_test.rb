require 'minitest/autorun'
require_relative 'fib'

class TestFib < Minitest::Test

  def test_fib
    extend FibonacciSequence
    assert_equal [1, 1, 2, 3, 5, 8, 13, 21], fib.first(8)
  end

  def test_nth
    extend FibonacciSequence
    assert_equal 21, nth(7)
  end

  def test_nth_zero
    extend FibonacciSequence
    assert_equal 1, nth(0)
  end

  def test_nth_cached
    extend FibonacciSequence
    nth(20)                     # generate the @cache
    assert_equal 610, nth(14)   # don't call next on the generator
  end

  def test_nth_extends_cache
    extend FibonacciSequence
    nth(8)
    assert_equal 233, nth(12)
  end
end
