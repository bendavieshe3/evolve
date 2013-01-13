class Critter

    @@number_of_critters = 0 

    attr_accessor :name
    attr_accessor :hp

    def initialize(number_of_hitpoints)
        @@number_of_critters += 1
        self.name = "#{@@number_of_critters}"
        self.hp = number_of_hitpoints
    end

    def self.at_start
        Critter.new(1)
    end
    
    def damage(hitpoints)
        self.hp -= hitpoints
        if dead? 
            puts "Critter #{self} died"
        end
    end
    
    def dead?
        self.hp < 1
    end
    
    def to_s
        "Critter(#{self.name})"
    end
    

end
