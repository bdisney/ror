class Station
  include InstanceCounter

  NAME_PATTERN = /^[[:alpha:]]{1}[[:print:]]{2,19}$/
  
  @@stations = {}

  attr_reader :name, :trains

  def self.find(name)
    @@stations[name.to_sym]
  end

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
    @@stations[name.to_sym] = self
  end

  def is_valid?
    validate!
  rescue
    false
  end

  def let_in(train)
    self.trains << train
  end

  def let_out(train)
    self.trains.delete(train)
  end

  def show_trains_by_type(type)
    trains_by_type = []
    self.trains.each { |train| trains_by_type.push(train) if train.type == type }
    trains_by_type
  end

  def to_s
    "#{self.name}"
  end

  protected

  def validate!
    raise "Название должно начинаться с буквы, длина 3..20!" if NAME_PATTERN.match(self.name).nil?
    raise "Станция с таким именем уже существует" if @@stations.has_key?(self.name.to_sym)
  end

end