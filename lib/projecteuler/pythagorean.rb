require 'bigdecimal'
require 'prime'

module Pythagorean

  Matrices1 = [[[1,-2,2],[2,-1,2],[2,-2,3]],
                [[1,2,2],[2,1,2],[2,2,3]],
                [[-1,2,2],[-2,1,2],[-2,2,3]]]
  Matrices2 = [[[2,1,-1],[-2,2,2],[-2,1,3]],
                [[2,1,1],[2,-2,2],[2,-1,3]],
                [[2,-1,2],[2,2,2],[2,1,3]]]

  # returns an enumerator over all primitive pythagorean triples
  def primitive_tree(matrices: Matrices1,
                     short_leg_max_length: BigDecimal('Infinity'),
                     long_leg_max_length: BigDecimal('Infinity'))
    Enumerator.new do |y|
      queue = [[3, 4, 5]]

      loop do
        break if queue.empty?

        triple = queue.shift

        y << triple
        matrices.each do |matrix|
          next_triple = matrix.map { |row| dot_product(row, triple) }.sort

          queue << next_triple unless next_triple[0] > short_leg_max_length ||
                                      next_triple[1] > long_leg_max_length
        end
      end
    end
  end

  private

  def dot_product(a, b)
    raise unless a.count == b.count

    (0...(a.count)).inject(0) {|acc, val| acc + a[val] * b[val]}
  end
end
