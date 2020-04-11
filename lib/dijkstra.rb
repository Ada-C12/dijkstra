# Find the unvisited node with the shortest distance
def find_next_node(added, shortest_distances)
  distance = Float::INFINITY
  next_node = nil

  added.each_with_index do |node, index|
    if !node && shortest_distances[index] < distance
      distance = shortest_distances[index]
      next_node = index
    end
  end

  return next_node
end

# Time: O(n^2 * e)
# Space: O(n)
def dijkstra(adjacency_matrix, start_node) 
  num_nodes = adjacency_matrix.length

  # Holds the shortest distances from start_node to node. Each one starts with infinity.
  shortest_distances = Array.new(num_nodes, Float::INFINITY)

  # Records if a path to that node has already been discovered. Each one starts as false.
  added = Array.new(num_nodes, false)

  # Holds the previous node for each node. Each one starts as nil.
  parent_list = Array.new(num_nodes)

  # Set the shortest_distance for start_node to 0 so it is picked first.
  shortest_distances[start_node] = 0

  answer = { start_node: start_node, parent_list: parent_list, shortest_distances: shortest_distances }

  # Loop the number of nodes - 1 times
  (num_nodes - 1).times do 
    current_node = find_next_node(added, shortest_distances)

    # Check if graph is unconnected
    if current_node.nil?
      return answer
    end

    # Set current_node in added to true
    added[current_node] = true

    # Update all the values in shortest_distances for the neighbors of current_node 
    # with the minimum of their current value and the distance to the current_node and the weight of the edge connecting them with current_node
    adjacency_matrix[current_node].each_with_index do |distance, index|
      if distance > 0
        if parent_list[current_node]
          distance += shortest_distances[current_node]
        end

        if distance < shortest_distances[index]
          shortest_distances[index] = distance
          parent_list[index] = current_node
        end
      end
    end
  end
  return answer
end
