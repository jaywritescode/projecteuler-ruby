require 'minitest/autorun'
require 'set'
require 'pry-byebug'

require_relative 'adjacency_list_graph'

describe AdjacencyListGraph do

  subject { @graph ||= AdjacencyListGraph.new }

  it "initializes to an empty graph" do
    _(subject.vertices).must_be_empty
  end

  it "adds a new vertex to the graph" do
    vertex = AdjacencyListGraph::Vertex.new('foo')
    subject.add_vertex(vertex)

    _(subject.vertices).must_include vertex
  end

  it "adds an edge to the graph" do
    v = AdjacencyListGraph::Vertex.new(:foo)
    w = AdjacencyListGraph::Vertex.new(:bar)

    subject.add_vertex(v)
    subject.add_vertex(w)
    subject.add_edge(v, w)

    _(subject.edges).must_include [v,w]
    _(v.neighbors).must_include w
  end

  describe "graph with multiple vertices" do
    before do
      @foo, @bar, @baz, @quux = [
        AdjacencyListGraph::Vertex.new(:foo),
        AdjacencyListGraph::Vertex.new(:bar),
        AdjacencyListGraph::Vertex.new(:baz),
        AdjacencyListGraph::Vertex.new(:quux),
      ].each {|v| subject.add_vertex(v)}

      @foobar  = subject.add_edge(@foo, @bar)
      @fooquux = subject.add_edge(@foo, @quux)
      @barquux = subject.add_edge(@bar, @quux)
      @bazfoo  = subject.add_edge(@baz, @foo)
      @bazbar  = subject.add_edge(@baz, @bar)
      @quuxbaz = subject.add_edge(@quux, @baz)
    end

    describe "remove vertex" do
      it "removes the vertex from the graph" do
        subject.remove_vertex @foo

        _(subject.vertices).wont_include @foo
      end

      it "removes the vertex from its predecessors' sets of neighbors" do
        subject.remove_vertex @bar

        _(@baz.neighbors).wont_include @bar
        _(@foo.neighbors).wont_include @bar
      end

      describe "remove edge" do
        it "removes the edge from the graph" do
          subject.remove_edge @foo, @quux

          _(subject.edges).wont_include @fooquux
        end

        it "removes the adjacency relationship from the nodes" do
          subject.remove_edge @baz, @bar

          _(@baz.neighbors).wont_include @bar
        end
      end
    end

    describe "neighbors" do
      it "gets a node's neighbors" do
        _(subject.neighbors(@foo)).must_equal Set[@bar, @quux]
      end

      it "determines if node x is adjacent to node y" do
        _(subject.adjacent(@baz, @foo)).must_be :&, true
        _(subject.adjacent(@foo, @baz)).wont_be :&, true
      end
    end
  end
end
