require_relative 'graph'

require 'set'

# Adjacency list representation of a finite graph.
class AdjacencyListGraph < Graph

  class Vertex
    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def ~(x)
      neighbors.include?(x)
    end

    def add_neighbor!(x)
      neighbors << x
    end

    def remove_neighbor!(x)
      neighbors.delete(x)
    end

    def neighbors
      @neighbors ||= Set.new
    end
  end

  attr_reader :edges

  def initialize
    @vertices = Set.new
    @edges = Hash.new
  end

  def adjacent(x, y)
    x.~ y
  end

  def neighbors(x)
    x.neighbors
  end

  def add_vertex(x)
    vertices << x
  end

  def remove_vertex(x)
    vertices.each do |v|
      v.remove_neighbor!(x)
    end
    vertices.delete(x)
  end

  def add_edge(x, y, cost: 1)
    raise unless vertices.include?(x) && vertices.include?(y)

    edges.merge! [x, y] => cost
    x.add_neighbor!(y)
  end

  def remove_edge(x, y)
    unless edges.delete([x,y]).nil?
      x.remove_neighbor!(y)
    end
  end

  def get_vertex_value(x)
    x.data
  end

  def set_vertex_value(x, v)
    x.data = v
  end

  def get_edge_value(x, y)
    edges.fetch [x, y]
  end

  def set_edge_value(x, y, v)
    if edges.has_key? [x, y]
      edges.update [x, y] => v
    end
  end
end
