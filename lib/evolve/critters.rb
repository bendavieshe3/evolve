class Critter

    @@number_of_critters = 0 

    attr_accessor :name
    attr_accessor :hp

    def initialize(number_of_hitpoints, world)
        @@number_of_critters += 1
        self.name = "#{@@number_of_critters}"
        self.hp = number_of_hitpoints
        @world = world
    end

    def self.at_start(world)
        Critter.new(1, world)
    end
    
    def damage(hitpoints)
        self.hp -= hitpoints
        if dead? 
            send_event(:critter_dead, dead: self)
        end
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
