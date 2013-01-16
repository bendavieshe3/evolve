module Listeners

DEBUG = 1
INFO = 2
STATUS = 3
WARNING = 4
ERROR = 5


class Listener

    def receive_event(event)
        event_type = event[:event_type]    
    
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
    
    def population_change(event)
    
    end
    
    def info(event)
    
    end

end

class ConsoleListener < Listener

    def initialize(options = {})
    
        @defaults = { 
            logging_level: STATUS,
            interim_report_frequency: 5           
        }
        @options = @defaults.merge(options)
        
        if not (DEBUG..ERROR).include? logging_level
          raise "Logging level `#{logging_level}` is not valid"
        end
    end

    def options
        @options
    end
    
    def logging_level 
        @options[:logging_level]
    end

    def iteration_start(event)
        iteration_number = event[:iteration_number]
        population = event[:world].population
        if reporting_iteration? iteration_number
            status "#{iteration_number}: #{population.length} critters"
        end
        info "Starting Iteration #{iteration_number}"
    end

    def iteration_end(event)
        iteration_number = event[:iteration_number]
        info "Ending Iteration #{iteration_number}"
    end
    
    def simulation_start(event)
        status "Simulation Starting"
        info "Showing Information Messages"
    end

    def simulation_end(event)
        status "Simulation Complete"
        status "Critter Report"
        status "Critter\tHP\tfood"
        for c in event[:world].population
          STDOUT.puts "#{c.name}\t#{c.hp}/#{c.max_hp}\t#{c.food}/#{c.max_food}"
        end
    end

    def critter_dead(event)
        dead_critter = event[:payload][:dead]
        info "Critter #{dead_critter.name} has died"
    end
    
    def critter_fed(event)
        fed_critter = event[:payload][:critter]
        food = event[:payload][:food]
        info "Critter #{fed_critter.name} has fed (#{food})"
    end    

    def info(event_or_message)
        log(INFO, "\t" + message_from(event_or_message))
    end
    
    def status(event_or_message)
        log(STATUS, message_from(event_or_message))
    end

    def message_from(event_or_message)
        event_or_message.is_a?(Hash) ? event_or_message[:payload] : event_or_message
    end

    def log(message_level, message)
        if logging_level <= message_level
            STDOUT.puts message
        end
    end

    def reporting_iteration?(iteration_number)
        iteration_number == 1 or iteration_number % options[:interim_report_frequency] == 0
    end
end #ConsoleListener

end #module
