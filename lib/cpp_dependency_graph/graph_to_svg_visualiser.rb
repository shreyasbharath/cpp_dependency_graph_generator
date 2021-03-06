# frozen_string_literal: true

require 'ruby-graphviz'

# Outputs a `dot` language representation of a dependency graph
class GraphToSvgVisualiser
  def generate(deps, file)
    @g = GraphViz.new('dependency_graph')
    create_nodes(deps)
    connect_nodes(deps)
    @g.output(svg: file)
  end

  private

  def create_nodes(deps)
    node_names = deps.flat_map do |_, links|
      links.map { |link| [link.source, link.target] }.flatten
    end.uniq
    node_names.each do |name|
      add_node(name)
    end
  end

  def add_node(name)
    @g.add_node(name, shape: 'box3d')
  end

  def connect_nodes(deps)
    deps.each do |source, links|
      links.each do |link|
        if link.cyclic?
          @g.add_edges(source, link.target, color: 'red')
        else
          @g.add_edges(source, link.target)
        end
      end
    end
  end
end
