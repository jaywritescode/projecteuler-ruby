module FibonacciSequence
  # Returns the nth element of the Fibonacci sequence starting with F_0 = 1 and
  # F_1 = 1.
  def nth(n)
    @cache ||= []
    return @cache[n] if n < @cache.count

    more = n + 1 - @cache.count
    @cache += more.times.each_with_object([]).collect { fib.next }
    @cache[n]
  end

  # Returns an enumerator over the Fibonacci sequence starting with F_0 = 1 and
  # F_1 = 1.
  def fib(f0: 1, f1: 1)
    Enumerator.new do |y|
      loop do
        y << f0
        f0, f1 = f1, f0 + f1
      end
    end
  end
end
