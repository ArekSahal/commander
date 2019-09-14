using LinearAlgebra
include("helpers.jl")
include("control.jl")
include("GraphicsEngine.jl")

game_width = 70
game_height = 50

terminal_width = 20 # Amount of cols
terminal_height = 10 # Amount of rows
#print("\x1b[8;" * string(terminal_width + 50) * ";" * string(terminal_height + 50) * "t")

adv_dummy_map = """
                    ####################
                    #                  #
                    #     ##           #
                    #     ##           #
                    #                  #
                    #                  #
                    #                  #
                    #                  #
                    #                  #
                    ####################
                    """

map = adv_dummy_map

#show(map)

global FOV = 3.14/3        # Field of view
global player_position = [terminal_height/2, terminal_width/2] #y, x
global player_angle = 0      # angle from pointing straight up, going counter clockwise

function game_loop()

    while true 
        #Check for player inputs

        #global player_angle += 0.1


        distance = ray_distance(player_position, player_angle, map, FOV)
        graphics = distance_mapToGraphics(distance, map)
        show(graphics)
        sleep(0.01)
    end

end

game_loop()
