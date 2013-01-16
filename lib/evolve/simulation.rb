
class Simulation
    
    INITIAL_NUMBER_OF_CRITTERS = 10
    
    def initialize()
        
        @critters = []
        @listeners = []
        @world = nil
        @iteration = 0
        STDOUT.puts 'Preparing Simulation'

    end
        
    def attach_listener(listener)
        @listeners << listener
    end
    
    def initialize_world
        send_event(:info, "Initialising World")
    
        @world = OnePlaceWorld.new(self)
    
        #create initial critter population
        for c in 1..INITIAL_NUMBER_OF_CRITTERS
            @world.population << Critter.at_start(@world)
        end 
        send_event(:info, "Created #{INITIAL_NUMBER_OF_CRITTERS} critters")
    end
    
    def simulate(number_of_iterations)

        send_event(:simulation_start)
        send_event(:status, "Iterating #{number_of_iterations} times!")    

        for i in 1..number_of_iterations
            @iteration += 1
            send_event(:iteration_start)
            perform_iteration
            send_event(:iteration_end)
            
        end

        send_event(:simulation_end)
    end
    
    def perform_iteration
        @world.turn #prompt world to conduct natural processes
    end
    
    def send_event(event_type, payload=nil)
        event = {
            event_type: event_type,
            payload: payload,
            iteration_number: @iteration,
            world: @world
            }
        dispatch_event(event)
    end

    def receive_event(event)
        #simulation logic here
        
        #redispatch the event to listeners
        dispatch_event(event)
    end
    
    def dispatch_event(event)
        @listeners.each do | l |
            l.receive_event(event)
        end
    end

end