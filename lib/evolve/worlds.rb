class World 

    attr_accessor :population
    attr_accessor :simulation

    def turn
    
    end


    def receive_event(event)
    
        event_type = event[:event_type]
        payload = event[:payload] 
    
        case event_type
        when :critter_dead
            @population.delete payload[:dead]
        end
    
        send_event(event)
    
    end
    
    def send_event(event)
        @simulation.receive_event(event)
    end

end

class OnePlaceWorld < World

    CHANCE_OF_ENTROPY_DAMAGE = 5

    def initialize(simulation)
        @simulation = simulation
        @population = []
    end
    
    def turn
        
        #determine and inflict entropy damage
        for critter in @population
            entropy_role = 1 + rand(100)
            if entropy_role <= CHANCE_OF_ENTROPY_DAMAGE
                critter.damage 1
            end
        end        
        
    end

end