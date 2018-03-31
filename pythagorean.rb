require 'prime'
require 'pry-byebug'

module Pythagorean
  # returns an enumerator over all primitive pythagorean triples
  def primitive_tree
    m1 = [[1,-2,2],[2,-1,2],[2,-2,3]]
    m2 = [[1,2,2],[2,1,2],[2,2,3]]
    m3 = [[-1,2,2],[-2,1,2],[-2,2,3]]

    Enumerator.new do |y|
      queue = [[3, 4, 5]]

      loop do
        triple = queue.pop

        y << triple
        [m1, m2, m3].each do |m|
          queue << m.map {|row| dot_product(row, triple)}
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
