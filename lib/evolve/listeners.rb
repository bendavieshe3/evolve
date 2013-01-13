class Listener

    def receive_event(event_type, event)
    
        if self.respond_to? event_type
            self.send(event_type, event) 
        end
        
    end

    def simulation_start(event)
    
    end

    def simulation_end(event)
    
    end

    def iteration_start(event)

    end
    
    def iteration_end(event)
    
    end

end

class ConsoleListener < Listener

    DEBUG = 1
    INFO = 2
    WARNING = 3
    ERROR = 4

    def initialize(options)
        puts "hello"
    
        @defaults = { 
            :logging_level => WARNING
        }
        @options = @defaults.merge(options)
    end

    def options
        @options
    end

    def iteration_start(event)
        STDOUT.puts "Starting Iteration #{event[:iteration_number]}"
    end

    def iteration_end(event)
        STDOUT.puts "Ending Iteration #{event[:iteration_number]}"
    end
    
    def simulation_start(event)
        STDOUT.puts "Simulation starting"
    end


end
