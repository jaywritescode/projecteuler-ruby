require 'prime'
require 'singleton'

module Partitions
  class PartitionFunction
    include Singleton

    def initialize
      @known_values = Hash.new
    end

    # partition function - counts the ways to write a positive integer n
    # as the sum of smaller positive integers
    def _p(n)
      return @known_values[n] if @known_values.has_key?(n)

      return 0 if n < 0
      return 1 if n == 0

      generalized_pentagonal_numbers = Enumerator.new do |y|
        k = 1
        loop do
          y.yield [k, k * (3 * k - 1) / 2]
          y.yield [-k, k * (3 * k + 1) / 2]
          k += 1
        end
      end

      total = 0
      loop do
        m, gn = generalized_pentagonal_numbers.next
        return @known_values[n] = total if gn > n

        total += (-1) ** (m.abs - 1) * _p(n - gn)
      end
    end
  end

  class PrimePartitionFunction
    include Singleton

    def initialize
      @known_values = Hash.new
    end

    def _p(n)
      return @known_values[n] if @known_values.has_key?(n)

      return 0 if n == 1

      summation = (1..(n - 1)).sum {|j| sum_of_prime_factors(j) * _p(n - j)}
      @known_values[n] = (summation + sum_of_prime_factors(n)) / n
    end

    private

    def sum_of_prime_factors(n)
      Prime.each.take_while {|p| p <= n}.select {|p| n % p == 0}.reduce(0, :+)
    end
  end

  def p(n)
    PartitionFunction::instance._p(n)
  end

  def prime_partitions(n)
    PrimePartitionFunction::instance._p(n)
  end
end
