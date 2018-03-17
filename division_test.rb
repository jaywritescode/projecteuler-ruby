require 'minitest/autorun'
require 'set'
require_relative 'division'

class TestDivision < Minitest::Test

  def test_gcd_multiple_parameters
    extend Division
    assert_equal 34, gcd(1530, 1054, 2346)
  end

  def test_gcd_single_parameter
    extend Division
    assert_equal 5678, gcd(5678)
  end

  def test_gcd_zero_parameters
    extend Division
    assert_raises ArgumentError do
      gcd
    end
  end

  def test_divisors
    extend Division

    assert_equal Set[1, 2, 3, 4, 6, 8, 12, 16, 24, 48], divisors(48)
  end

  def test_phi
    extend Division

    k = 983                                    # k is prime
    assert_equal(k - 1, phi(k))

    k = (p = 193) ** (n = 5)                   # k is a power of a prime
    assert_equal(p ** n - p ** (n - 1), phi(k))

    k = (p0 = 241) * (p1 = 71)                 # k is a product of two primes
    assert_equal(phi(p0) * phi(p1), phi(k))

    k = (p0 = 197) ** 1 * (p1 = 7) ** 4 * (p2 = 59) ** 2    # k is composite
    assert_equal(k * (1 - Rational(1, p0)) * (1 - Rational(1, p1)) * (1 - Rational(1, p2)), phi(k))
  end
end
