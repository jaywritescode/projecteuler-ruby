require 'minitest/autorun'
require 'pry-byebug'

require_relative 'adjacency_list_graph'
require_relative 'dijkstra'

describe Dijkstra do

  subject { @graph ||= AdjacencyListGraph.new }

  before do
    @a = AdjacencyListGraph::Vertex.new(:a)
    @b = AdjacencyListGraph::Vertex.new(:b)
    @c = AdjacencyListGraph::Vertex.new(:c)
    @d = AdjacencyListGraph::Vertex.new(:d)
    @e = AdjacencyListGraph::Vertex.new(:e)
    @f = AdjacencyListGraph::Vertex.new(:f)

    [@a, @b, @c, @d, @e, @f].each do |v|
      subject.add_vertex(v)
    end

    subject.add_undirected_edge(@a, @b, cost: 7)
    subject.add_undirected_edge(@a, @c, cost: 14)
    subject.add_undirected_edge(@a, @d, cost: 9)
    subject.add_undirected_edge(@b, @d, cost: 10)
    subject.add_undirected_edge(@b, @e, cost: 15)
    subject.add_undirected_edge(@c, @d, cost: 2)
    subject.add_undirected_edge(@c, @f, cost: 9)
    subject.add_undirected_edge(@d, @e, cost: 11)
    subject.add_undirected_edge(@e, @f, cost: 6)
  end

  it "finds the shortest path between two nodes" do
    _(Dijkstra.new(subject).shortest_path_between_nodes(@a, @f)).must_equal [@a, @d, @c, @f]
  end

  it "finds the shortest distance between two nodes" do
    _(Dijkstra.new(subject).shortest_distance_between_nodes(@a, @f)).must_equal 20
  end

  describe "finds the shortest path and distance to all the nodes" do
    it "finds the shortest path to all the nodes" do

    end

    it "finds the shortest distance to all the nodes" do
      _(Dijkstra.new(subject).shortest_distance_to_all_nodes(@a)).must_equal({
        @a => 0,
        @b => 7,
        @c => 11,
        @d => 9,
        @e => 20,
        @f => 20
      })
    end


    # Dijkstra.new(subject).
    #
    # expected = {
    #   @a => {distance: 0, prev: nil},
    #   @b => {distance: 7, prev: @a},
    #   @c => {distance: 11, prev: @d},
    #   @d => {distance: 9, prev: @a},
    #   @e => {distance: 20, prev: @d},
    #   @f => {distance: 20, prev: @c}
    # }
    # expected.each_pair do |key, value|
    #   _(key.distance).must_equal expected[key][:distance]
    #   _(key.prev).must_be_same_as expected[key][:prev]
    # end
  end
end
