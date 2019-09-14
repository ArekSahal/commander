using Gtk

function on_press(key)
  if key == 100
    global player_angle -= 0.05
  end
  if key == 97
    global player_angle += 0.05
  end
  if key == 119
    #check if valid move, not inside a wall, unit circle around player must be free
    distance = 0.5
    global player_position = [player_position[1] + cos(player_angle)*distance , player_position[2] - sin(player_angle)*distance]
  end
  if key == 115
    distance = 0.5
    global player_position = [player_position[1] - cos(player_angle)*distance , player_position[2] + sin(player_angle)*distance]
  end
end


win = GtkWindow("Key Press Example")

signal_connect(win, "key-press-event") do widget, event
  #println("You pressed key ", event.keyval)
  on_press(event.keyval)
end