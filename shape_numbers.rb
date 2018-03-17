module ShapeNumbers
  [:triangle, :square, :pentagon, :hexagon].each do |shape|

    # Find the nth #{shape} number.
    define_method "#{shape}_number" do |n|
      ShapeNumbers.to_quadratic_equation(coefficients[shape]).call(n).to_i
    end

    # Get an enumerable of #{shape}_number(n), where 0 <= n <= k.
    #
    # #{shape}_numbers(nil) returns an infinite enumerable.
    define_method "#{shape}_numbers" do |k=nil|
      to_enum(shape, iterations: k)
    end

    # Find n where #{shape}_number(n) == k.
    #
    # Returns n if it exists, otherwise nil.
    define_method "#{shape}_inverse" do |k|
      quadratic_positive_integer_solution(coefficients[shape].merge(:n => k))
    end

    # Determine if k is a #{shape}_number.
    define_method "#{shape}_number?" do |k|
      self.send("#{shape}_inverse".to_sym, k) ? true : false
    end
  end

  private

  def coefficients
    @coefficients ||= {
      triangle: {a: 0.5, b: 0.5},
      square: {a: 1.0, b: 0.0},
      pentagon: {a: 1.5, b: -0.5},
      hexagon: {a: 2.0, b: -1.0}
    }
  end

  def to_enum(shape, iterations: nil)
    Enumerator.new do |y|
      count = 0
      loop do
        y.yield self.send("#{shape}_number".to_sym, count)
        count += 1
        break if iterations && count > iterations
      end
    end
  end

  def self.to_quadratic_equation(a:, b:, c: 0)
    Proc.new {|x| a * x ** 2 + b * x + c}
  end

  # Find the real solutions to the equation a * x ** 2 + b * x + c == 0
  # for some values a, b, and c.
  #
  # Returns an array.
  def self.quadratic_formula(a: 1, b: 1, c: 0)
    det = Math.sqrt(b ** 2 - 4.0 * a * c)
    case
    when det.negative?
      []
    when det.zero?
      [-b / 2.0 / a]
    when det.positive?
      [:+, :-].map {|op| (-b).send(op, det) / 2.0 / a}
    end
  end

  # Find the positive integer solution to the equation
  # a * x ** 2 + b * x + c == n, if it exists.
  #
  # Returns the solution if it exists, nil otherwise.
  def quadratic_positive_integer_solution(a: 1, b: 1, c: 0, n: 0)
    sols = ShapeNumbers.quadratic_formula({a: a, b: b, c: c - n}).select do |x|
      x.positive? && true_integer?(x)
    end
    sols.first.to_i unless sols.empty?
  end

  def true_integer?(f)
    f.zero? || (f - f.floor).zero? || (f.floor - f).zero?
  end
end
