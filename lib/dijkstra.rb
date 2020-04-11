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

def dijkstra(adjacency_matrix, start_node) 
  #int nVertices = adjacencyMatrix[0].length; 
  num_nodes = adjacency_matrix.length

  # shortest_distances will hold the shortest distances from start_node to i
  # it starts with infinity as the value
  shortest_distances = Array.new(num_nodes, Float::INFINITY)

  # Create a list of nodes called added which will record if a path to that node has already been discovered and set every entry to false
  added = Array.new(num_nodes, false)

  # Create an array called parents which will record the previous of any particular node on the path from the origin.
  parent_list = Array.new(num_nodes)

  # Assign shortest_distances[origin_node] to 0, so that it is picked first
  shortest_distances[start_node] = 0

  answer = { start_node: start_node, parent_list: parent_list, shortest_distances: shortest_distances }


  # Loop the number of nodes - 1 times
  (num_nodes - 1).times do 

    # Select a node which is not in added and has a the smallest distance value called current_node.
    current_node = find_next_node(added, shortest_distances)

    if current_node.nil?
      return answer
    end

    # Set current_node in added to true
    added[current_node] = true

    # Update all the values in distance for the neighbors of current_node with the minimum of 
    # their current value and the distance to the current_node and the weight of the edge connecting them with current_node
    adjacency_matrix[current_node].each_with_index do |distance, index|

      if distance > 0
        if parent_list[current_node]
          distance += shortest_distances[current_node]
        end

        if shortest_distances[index] && (distance < shortest_distances[index])
          shortest_distances[index] = distance
          parent_list[index] = current_node
        end
      end
    end
  end
  return answer
end
