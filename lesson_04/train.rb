class Train
  TYPE = { cargo: "Грузовые", passenger: "Пассажирские" }

  attr_reader :number, :type, :speed, :route, :current_station, :wagons, :wagons_count

  def initialize(number)
    @number = number
    @wagons = []
    @wagons_count = 0
    @speed = 0
  end

  def set_route(route)
    # уберем с текущей станции, если поезд уже на маршруте
    self.current_station.let_out(self) if self.current_station
    
    @route = route
    self.current_station = route.stations.first
  end

  def prev_station
    self.route.prev(self.current_station)
  end

  def next_station
    self.route.next(self.current_station)
  end

  def attach_wagon(wagon)
    if self.speed.zero?
      if wagon.match?(self) && !self.wagons.include?(wagon)
        attach_wagon!(wagon)
        puts "Вагон добавлен. Всего вагонов: #{self.wagons_count}"
      else
        puts "Некорректный тип вагона или он уже был добавлен ранее!"
      end
    else 
      puts "Для добавления вагона поезд должен быть остановлен"
    end
  end

  def detach_wagon
    if self.speed.zero?
      wagon = self.wagons.last
      detach_wagon!(wagon)
      puts "Вагон отцеплен! Всего вагонов: #{self.wagons_count}"
    else 
      puts "Нельзя отцеплять вагон на ходу!"
    end
  end

  def go(direction = :forward)
    if self.route
      new_station = direction == :back ? prev_station : next_station
      if new_station
        go!(new_station)
      else 
        puts "Конечная станция, движение возможно только в обратную сторону"
      end
    else 
      puts "Маршрут не назначен."
    end
  end

  def info
    puts "Тип: #{TYPE[self.type]}, вагонов: #{self.wagons_count}"
  end

  def locate
    if self.route
      puts "Поезд следует по маршруту #{self.route}."
      puts "Текущая станция — #{self.current_station}."
      puts "Предыдущая станция — #{prev_station}." if prev_station
      puts "Следующая станция — #{next_station}." if next_station
    else 
      puts "Маршрут не назначен."
    end
  end

  def to_s
    "Поезд №#{self.number}"
  end

  private

  def go!(new_station)
    self.current_station.let_out(self)
    speed_up(70)
    self.current_station = new_station
    stop
  end

  def stop
    @speed = 0
    puts "Поезд остановился."
  end

  def current_station=(station)
    station.let_in(self)
    @current_station = station
  end

  def attach_wagon!(wagon)
    self.wagons << wagon
    self.wagons_count += 1
  end

  def detach_wagon!(wagon)
    self.wagons.delete(wagon)
    self.wagons_count -= 1
  end

  def wagons_count=(count)
    @wagons_count = count
  end

  def speed_up(value)
    @speed = value
    puts "Поезд набрал скорость #{value} км/ч."
  end

end