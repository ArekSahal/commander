function dummy_map()
    dummy_map = ""
        for i in 1:(terminal_height-2)
            dummy_map = dummy_map * "#" * (" "^(terminal_width-2)) * "#\n"
        end
    dummy_map = "#"^terminal_width *"\n"* dummy_map * "#"^terminal_width
    return dummy_map
    end
    

function maptoarray(map)
    # NOT TRUE: returns an array of arrays of chars from a array of strings [['hello'], ['world']] -> [['h','e', 'l', 'l', 'o'],['w', 'o', 'r', 'l','d']]
    rows = split(map, "\n")
    li =[]
    for row in rows
        li = vcat(li, [split(row,"")])
    end
    return li
end

function arrayToMap(array)
    # NOT TRUE: inverse of maptoarray  [['h','e', 'l', 'l', 'o'],['w', 'o', 'r', 'l','d']] -> ['hello', 'world'] 
    rows = []
    for row in array
        append!(rows, join(row))
    end
    map = ""
    for row in rows
        map = map*row*"\n"
    end
    return map
end

function transpose(map)
    # Should transpose an array of arrays of chars
    T = []
    for i in 1:size(map[1])[1]
        row = []
        for j in 1:size(map)[1]
            append!(row, map[j][i])
        end
        T = vcat(T, [row])
    end
    return T
end

