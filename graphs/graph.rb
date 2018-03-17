class Graph

  attr_reader :vertices

  # True iff there is an edge in the graph from x to y.
  #
  # @param [Vertex] x
  # @param [Vertex] y
  # @return [Boolean]
  def adjacent(x, y)
    raise
  end

  # Get the neighbors of vertex x.
  #
  # @param [Vertex] x
  # @return Set<Vertex>
  def neighbors(x)
    raise
  end

  # Add a vertex to this graph.
  #
  # @param [Vertex] x
  # @return void
  def add_vertex(x)
    raise
  end

  # Remove a vertex from this graph.
  #
  # @param [Vertex] x
  # @return void
  def remove_vertex(x)
    raise
  end

  # Add a directed edge to this graph from x to y.
  #
  # @param [Vertex] x
  # @param [Vertex] y
  # @param [Numeric] cost - the weight of the edge from x to y
  # @return void
  def add_edge(x, y, cost: 1)
    raise
  end

  def add_undirected_edge(x, y, cost: 1)
    add_edge(x, y, cost: cost)
    add_edge(y, x, cost: cost)
  end

  # Remove the edge from x to y from the graph.
  #
  # @param [Vertex] x
  # @param [Vertex] y
  # @return void
  def remove_edge(x, y)
    raise
  end

  # Get the data associated with a vertex
  #
  # @param [Vertex] x
  # @return the vertex's data
  def get_vertex_value(x)
    raise
  end

  # Set the data associated with a vertex
  #
  # @param [Vertex] x
  # @param v - the vertex's data
  # @return void
  def set_vertex_value(x, v)
    raise
  end

  # Get the cost of the edge from x to y.
  #
  # @param [Vertex] x
  # @param [Vertex] y
  # @return [Numeric] the edge's cost
  def get_edge_value(x, y)
    raise
  end

  # Set the cost of the edge from x to y.
  #
  # @param [Vertex] x
  # @param [Vertex] y
  # @param [Numeric] v - the edge's cost
  # @return void
  def set_edge_value(x, y, v)
    raise
  end
end
