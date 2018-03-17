require 'forwardable'

class Dijkstra

  module Vertex
    attr_accessor :distance, :prev

    def distance
      @distance ||= 1.0 / 0
    end

    def path
      prev.nil? ? [self] : prev.path << self
    end
  end

  attr_reader :graph

  def initialize(graph)
    @graph = graph
    @graph.vertices.each do |v|
      v.extend(Dijkstra::Vertex)
    end
  end

  # Perform Dijkstra's algorithm to find the shortest path between the initial
  # node and a destination node in the graph.
  #
  # @param [Vertex] initial - the starting vertex
  # @param [Vertex] destination - the destination vertex
  # @return [Array<Dijkstra::Vertex>] the path to the destination vertex
  def shortest_path_between_nodes(initial, destination)
    initial.distance = 0

    current = initial
    loop do
      # at the destination node, stop calculating
      break if current == destination

      unvisited.delete(current)

      calculate_neighbor_shortest_distances(current)

      return nil if no_reachable_nodes

      current = unvisited.min_by(&:distance)
    end

    destination.path
  end

  # Perform Dijkstra's algorithm to find the length of the shortest path between
  # the starting and destination nodes in the graph.
  #
  # @param [Vertex] initial - the starting vertex
  # @param [Vertex] destination - the destination vertex
  # @return [Numeric] the distance to the destination vertex
  def shortest_distance_between_nodes(initial, destination)
    shortest_path_between_nodes(initial, destination).last.distance
  end

  # Perform Dijkstra's algorithm to find the shortest path from a starting
  # node to all the other nodes in the graph.
  #
  # @param [Vertex] initial - the starting vertex
  # @return [Array<Dijkstra::Vertex>] all the vertices in the graph with their shortest paths calculated
  def shortest_path_to_all_nodes(initial)
    initial.distance = 0

    current = initial
    loop do
      unvisited.delete(current)

      calculate_neighbor_shortest_distances(current)

      return graph.vertices if no_reachable_nodes

      current = unvisited.min_by(&:distance)
    end
  end

  # Perform Dijkstra's algorithm to find the length of the shortest path from a
  # starting node to all the other nodes in the graph.
  #
  # @param [Vertex] initial - the starting vertex
  # @return [Hash<Dijkstra::Vertex, Numeric>] mapping of nodes to their shortest distances from the start
  def shortest_distance_to_all_nodes(initial)
    Hash[shortest_path_to_all_nodes(initial).map {|n| [n, n.distance]}]
  end

  private

  def unvisited
    @unvisited ||= graph.vertices.dup
  end

  def calculate_neighbor_shortest_distances(current)
    current.neighbors.select {|n| unvisited.include? n}.each do |neighbor|
      tentative_distance = current.distance + graph.get_edge_value(current, neighbor)

      if tentative_distance < neighbor.distance
        neighbor.distance = tentative_distance
        neighbor.prev = current
      end
    end
  end

  def no_reachable_nodes
    unvisited.all? {|e| e.distance == 1.0 / 0}
  end
end
