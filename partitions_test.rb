require 'minitest/autorun'
require_relative 'partitions'

class TestPartitions < Minitest::Test

  def test_partitions
    extend Partitions
    assert_equal 190569292, p(100)
  end

  def test_prime_partitions
    extend Partitions
    assert_equal 5007, prime_partitions(71)
  end
end
