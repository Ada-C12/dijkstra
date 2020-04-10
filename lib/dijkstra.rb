##### I'M LEAVING IN MY PRINT STATEMENTS BC IT HELPS ME REMEMBER WHY I DID WHAT I DID...

def dijkstra(adjacency_matrix, start_node) 
  
  puts "==============\nADJACENCY MATRIX"
  adjacency_matrix.each do |r|
    p r
  end
  puts "==============\n\n"
  
  
  #int nVertices = adjacencyMatrix[0].length; 
  num_nodes = adjacency_matrix.length
  
  # shortest_distances will hold the shortest distances from start_node to i
  # it starts with infinity as the value
  shortest_distances = Array.new(num_nodes, Float::INFINITY)
  immedParent = Array.new(num_nodes, nil)
  visited = Array.new(num_nodes, false)
  
  # set up for the starter node
  visited[start_node] = true
  immedParent[start_node] = nil
  shortest_distances[start_node] = 0
  currNode = start_node
  
  processCurrNode(adjacency_matrix[currNode], currNode, shortest_distances, immedParent, visited)
  
  while keepVisiting(visited)
    puts "keep visiting!"
    
    currNode = getNextToVisit(visited, shortest_distances)
    if !currNode 
      # ran out of available next neighbors, but we haven't visited almost everyone (only 1 is allowed to be unvisited) yet!
      break
    end
    
    visited[currNode] = true 
    
    processCurrNode(adjacency_matrix[currNode], currNode, shortest_distances, immedParent, visited)
    
  end
  
  
  puts "GRAND FINALE"
  puts "\tvisited = #{visited.inspect}"
  puts "\timmedParent = #{immedParent.inspect}"
  puts "\tshortestDistances = #{shortest_distances.inspect}\n"
  
  answer = {
    start_node: start_node, 
    parent_list: immedParent, 
    shortest_distances: shortest_distances
  }
  
  return answer
end

def keepVisiting(visited)
  return visited.count(false) != 1
end

def getNextToVisit(visited, shortest_distances)
  shortest = Float::INFINITY
  winner = nil
  
  visited.each_with_index do |visitedStatus, i|
    puts "looking at... visitedStatus=#{visitedStatus} for node #{i}"
    if visitedStatus == false && shortest_distances[i] < shortest
      winner = i 
      shortest = shortest_distances[i]
    end
  end
  
  if winner
    puts "\nNext up is... node #{winner}, it's distance is #{shortest}\n"
    return winner 
  else
    return nil
  end
end

def processCurrNode(currNodesDistances, currNode, shortest_distances, immedParent, visited)
  puts "Processing... #{currNodesDistances.inspect}"
  
  currNodesDistances.each_with_index do |distance, destinationNode|
    puts "looking at #{distance} for nodeIndex #{destinationNode}"
    if visited[destinationNode]
      # puts "already visited this node, including self"
      next
    elsif distance == 0
      # puts "this node is defined as not reachable"
      next
    else 
      # puts "is this new distance shorter?"
      recordedSD = shortest_distances[destinationNode]
      prevLeg = shortest_distances[currNode]
      currDistance = distance + prevLeg
      
      if currDistance < recordedSD
        puts "\tfound a shorter distance!"
        shortest_distances[destinationNode] = currDistance
        immedParent[destinationNode] = currNode
      end
    end
  end
  
  puts "Ended with..."
  puts "\tvisited = #{visited.inspect}"
  puts "\timmedParent = #{immedParent.inspect}"
  puts "\tshortestDistances = #{shortest_distances.inspect}\n"
end