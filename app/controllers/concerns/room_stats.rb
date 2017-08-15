module RoomStats
  def get_room_stats(input_file)
    room_data = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    return room_data unless input_file
    infile = input_file.read
    file_data = infile.split("\n")
    file_data.each_with_index do |file_row, index|
      if index > 0
        input_data = file_row.split(' ')
        #example { 'room1' : { 'user1': {'I': [20, 90], 'O': [40, 110] }}}
        room_data[input_data[1]][input_data[0]][input_data[2]] = [] if room_data[input_data[1]][input_data[0]][input_data[2]] == {}
        room_data[input_data[1]][input_data[0]][input_data[2]] << input_data[3]
      end
    end
    get_average_room_stats(room_data)
  end

  def get_average_room_stats(room_data)
    result = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    room_data.each do |room, user_data|
      result[room]['sum'] = 0
      result[room]['user_count'] = 0
      result[room]['count'] = 0
      user_data.each do |user, data|
        result[room]['user_count'] += 1
        data['I'].each_with_index do |_user_in_data, index|
          result[room]['count'] += 1
          result[room]['sum'] += data['O'][index].to_i - data['I'][index].to_i
        end
      end
      result[room]['avg'] = (result[room]['sum'].to_f/result[room]['count']).round(2)
    end
    result
  end
end