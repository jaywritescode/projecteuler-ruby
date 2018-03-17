require 'prime'
require 'set'
require 'singleton'

module Division
  def gcd(*args)
    raise ArgumentError.new('No arguments given.') unless args.count > 0

    case args.count
    when 1
      args[0]
    when 2
      _gcd(*args)
    else
      _gcd(args[0], gcd(*args[1..-1]))
    end
  end

  def phi(k)
    EulerTotient.instance.calculate(k)
  end

  def divisors(n)
    Set::new (1..(Integer::sqrt(n))).select {|x| n % x == 0}.map {|e| [e, n / e]}.flatten
  end

  def proper_divisors(n)
    divisors(n) - [n]
  end

  def sum_of_divisors(n)
    divisors(n).sum
  end

  # the sum of proper divisors of n
  def aliquot_sum(n)
    sum_of_divisors(n) - n
  end

  class EulerTotient
    include Singleton

    def initialize
      @known = { 1 => 1 }
    end

    def calculate(k)
      case
      when @known.has_key?(k)
        @known[k]
      when k.prime?
        @known[k] = k - 1
      else
        # rewrite k = p ^ n * a, where p is a prime, a is some integer,
        # and gcd(p, a) == 1
        p0, n = prime_divisor(k), 1
        a = k / p0

        loop do
          break unless (a % p0).zero?
          a /= p0
          n += 1
        end

        @known[k] = prime_power_phi(p0, n) * calculate(a)
      end
    end

    private

    def prime_divisor(k)
      Prime.each.find {|p| k % p == 0}
    end

    # Calculate phi(p ** k), where p is a prime and k is a positive integer.
    def prime_power_phi(p, k)
      (p ** k * (1 - Rational(1, p))).to_i
    end
  end

  private

  def _gcd(m, n)
    m, n = n, m if m < n
    n == 0 ? m : gcd(n, m % n)
  end
end
