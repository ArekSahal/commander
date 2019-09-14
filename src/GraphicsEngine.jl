using LinearAlgebra


#=
Useful ANSI escape codes:
http://ascii-table.com/ansi-escape-sequences.php

Start with \x1b[ 
    - 2j    erease display
    - [30 - 37] m   text color
=#

#=
dummy_map = """
###############
#             #
#             #
#             #
#             #
#             #
#             #
###############"""
=#

function dummy_map(height, width)
    dummy_map = ""
        for i in 1:(height-2)
            dummy_map = dummy_map * "#" * (" "^(width-2)) * "#\n"
        end
    dummy_map = "#"^width *"\n"* dummy_map * "#"^width
    return dummy_map
    end

#game_width = 50
#game_height = 20

function show(map)
    println("\e[3J")
    println(map)
    println(player_position)
    println(player_angle)
    #display("text/plain", map)
end

function graphics_mapToGraphics(g_map, minimap)
    # This is here because i messed up and this was my fix
    # Do not pay attention to this function as i have forgotten its purpose
    # Just pray you dont get an error here cuz good luck trying to figure out what it is supposed to output
    map = []
    for row in g_map
        append!(map, [split(row,"")])
    end
    map = transpose(map)

    new_map = []
    for row in map
        append!(new_map, [join(row,"")])
    end
    G = ""
    for row in new_map
        G = G*row*"\n"
    end
    return G    
end

function distance_mapToGraphics(dist_map, map)
    close = "#"
    mid = "O"
    far = "'"

    line_of_sight = terminal_width / 5

    closest_distance = minimum(dist_map)
    graphics = []
    for dist in dist_map
        c = "#"
        if dist < line_of_sight
            c = close
        elseif dist < 2*line_of_sight
            c = mid
        else
            c = far
        end

        height = round(Int, game_height*1 / dist)
        height = height - (height % 2)
        leftover = game_height - height
        if height <= 0 
            println("height is negative")
            println(dist_map)
        end
        if leftover <= 0
            println("leftover is negative")
            println(height)
            println(dist_map)
        end
        if game_height != (height + leftover)
            print("Some cols of the graphics are not the same size as the game hight")
        end
        row = " "^(round(Int, leftover/2))*c^(height)*" "^(round(Int, leftover/2))
        graphics = vcat(graphics, [row])
    end
    return graphics_mapToGraphics(graphics, map)
end

function ray_distance(pos, angle, map, fov)

    # Returns an array with the distance each ray has traveled before hitting a #
    map_li = maptoarray(map)
    max_angle = fov/2
    angles = range(-1*(max_angle + angle), stop=(max_angle -angle), length=game_width)
    distance_map = []
    
    for i in angles
        for step in 1:1000  # This should probably not be hard coded
           current_distance = step/10
           ray_position = [ round(Int ,pos[1] + cos(i)*current_distance), round(Int, pos[2] + sin(i)*current_distance)]
           if map_li[ray_position[1]][ray_position[2]] == "#"
            append!(distance_map, current_distance)  #Change to sin(i)*current_distance ??
            break
           end
        end
    end
    return distance_map
    end
