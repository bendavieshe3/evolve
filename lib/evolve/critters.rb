class Critter

    @@number_of_critters = 0 

    attr_accessor :name
    attr_accessor :max_hp
    attr_accessor :hp
    attr_accessor :max_food
    attr_accessor :food
    

    def initialize(number_of_hitpoints, food, world)
        @@number_of_critters += 1
        self.name = "#{@@number_of_critters}"
        self.hp = self.max_hp = number_of_hitpoints
        self.food = self.max_food = food
        @world = world
    end

    def self.at_start(world)
      Critter.new(1, 1, world)
    end
    
    def feed(food)
      if self.food + food <= self.max_food
        self.food += food
      else
        self.food = self.max_food
      end
      send_event(:critter_fed, critter: self, food: food)
    end
    
    def damage(hitpoints)
      self.hp -= hitpoints
      if dead? 
        send_event(:critter_dead, dead: self)
      end
    end
    
    def turn()
      send_event(:critter_turn_start, critter: self)
      
      send_event(:critter_action, critter: self, action: :eat)
      
      send_event(:critter_turn_end, critter: self)
    end
    
    def dead?
        self.hp < 1
    end
    
    def to_s
        "Critter #{self.name}"
    end
    
    def send_event(event_type, payload=nil)
        event = { event_type: event_type, payload: payload }
        @world.receive_event(event)
    end

end

class stat

  attr_accessor :current
  attr_accessor :maximum
  
  def initialize(maximum, current=nil)
    @maximum = maximum.to_i
    @current = current.to_i if current
    @current = maximum.to_i unless current
  end
  
  def to_i()
    @maximum
  end
  
  def to_s()
    "#{@current}/#{@maximum}"
  end
  
  def +(i)
    if @current + i <= @maximum
      @current += i
    else
      @current = @maximum
    end
  end
  
  def -(i)
    if @current - i >= 0 
      @current -= i
    else
      @current = 0
    end
  end

end
