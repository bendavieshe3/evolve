
class Simulation
    
    INITIAL_NUMBER_OF_CRITTERS = 10
    CHANCE_OF_ENTROPY_DAMAGE = 5
    
    def initialize()
        puts "Initialising simulation"
        
        @critters = []
        @listeners = []
        @world = nil
        @iteration = 0
        
        puts "Creating #{INITIAL_NUMBER_OF_CRITTERS} critters"
        for c in 1..INITIAL_NUMBER_OF_CRITTERS
            @critters << Critter.at_start 
        end
        
    end
    
    def attach_listener(listener)
        @listeners << listener
    end
    
    def iterate(number_of_iterations)

        send_event(:simulation_start)
            
            
        puts "Iterating #{number_of_iterations} times"
        for i in 1..number_of_iterations
            @iteration += 1
            send_event(:iteration_start)
            perform_iteration
            send_event(:iteration_end)
            
        end

        send_event(:simulation_end)
    end
    
    def perform_iteration
        
        puts "There are #{@critters.length} critters"
        
        #check for entropy damage against each critter
        for critter in @critters
            entropy_role = 1 + rand(100)
            if entropy_role <= CHANCE_OF_ENTROPY_DAMAGE
                critter.damage 1
            end
        end
        
        #check for and remove dead critters
        @critters.delete_if { |critter| critter.dead? }
        
    end
    
    def send_event(event_type)
        event = {}
        case event_type
        when :iteration_start, :iteration_end
            event.merge!( { 
                iteration_number: @iteration,
                world: @world
            } )
        end
 
        @listeners.each do | l | 
            l.receive_event(event_type, event)
        end       
        
    end
    
end