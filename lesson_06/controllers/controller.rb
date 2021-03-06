class Controller

  def show_actions
    puts 'Введите номер нужного действия: '
    puts '1 -> Создать станцию'
    puts '2 -> Создать поезд'
    puts '3 -> Добавить вагон'
    puts '4 -> Отцепить вагон'
    puts '5 -> Добавить поезд на станцию'
    puts '6 -> Список станций'
    puts '7 -> Список поездов на станции'
    puts 'Выход: exit'
  end

  def run_action(action)
    case action
    when "1"
      run(:create_station, true)
    when "2"
      run(:create_train, true)
    when "3"
      run(:attach_wagon)
    when "4"
      run(:detach_wagon)
    when "5"
      run(:go_to_station)
    when "6"
      run(:list_stations)
    when "7"
      run(:list_trains_on_station)
    else
      puts 'Неизвестная команда!'
    end
  end

  private

  def run(method, need_retry = false)
    self.send(method)
  rescue RuntimeError => e
    puts e.message
    retry if need_retry
  end

  # #1
  def create_station
    print "Укажите название станции: "
    name = gets.chomp
    create_station!(name)
  end

  # #2
  def create_train
    print "Укажите тип поезда ([1] > грузовой, [2] > пассажирский): "
    type = gets.chomp.to_i
    print "Введите номер поезда (XXX-XX или XXXXX): "
    number = gets.chomp
    create_train!(type, number)
  end

  # #3
  def attach_wagon
    train = select_train
    wagon_count = attach_wagon!(train)
    puts "Вагон добавлен. Всего вагонов: #{train.wagons_count}."
  end

  # #4
  def detach_wagon
    train = select_train
    detach_wagon!(train)
    puts "Вагон отцеплен. Всего вагонов: #{train.wagons_count}."
  end

  # #5
  def go_to_station
    train = select_train
    station = select_station
    relocation = train.teleport!(station)
    puts "Поезд отправился со станции «#{relocation[:from]}»." if !relocation[:from].nil?
    puts "Поезд прибыл на станцию «#{relocation[:to]}»."
  end

  # #6
  def list_stations
    if Station.instances.zero?
      puts "В системе нет ни одной станции!"
    else
      puts "Станции в системе (#{Station.instances} шт.):"
      puts Station.all.keys
    end
  end

  # #7
  def list_trains_on_station
    station = select_station
    if station.trains.empty?
      puts "На станции «#{station}» поездов нет."
    else
      puts "На станции «#{station}» находятся поезда:"
      puts station.trains
    end
  end

  def select_train
    raise "Сначала создайте хотя бы один поезд!" if Train.list.empty?
    print "Введите номер поезда [#{Train.list.keys.join(', ')}]: "
    number = gets.chomp
    selected_train = Train.find(number)
    raise "Поезда с таким номером нет!" if selected_train.nil?
    selected_train
  end

  def select_station
    raise "В системе нет ни одной станции!" if Station.all.empty?
    print "Введите название станции [#{Station.all.keys.join(', ')}]: "
    name = gets.chomp
    selected_station = Station.find(name)
    raise "Станция с таким названием не найдена!" if selected_station.nil?
    selected_station
  end

  def create_train!(type, number)
    raise "Некорректный тип поезда!" if ![1, 2].include?(type)
    train = type == 1 ? CargoTrain.new(number) : PassengerTrain.new(number)
    puts "#{train} создан."
    puts "#{train.info}"
  end

  def create_station!(name)
    station = Station.new(name)
    puts "Станция «#{station}» создана."
  end

  def attach_wagon!(train)
    wagon = train.type == :cargo ? CargoWagon.new() : PassengerWagon.new()
    train.attach_wagon(wagon)
  end

  def detach_wagon!(train)
    train.detach_wagon
  end
  
end