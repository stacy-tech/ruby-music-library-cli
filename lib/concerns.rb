module Concerns

    module Findable

        def find_by_name(name)
            self.all.select{|class_instance| class_instance.name == name}[0]
        end 

        def find_or_create_by_name(name)
            found = find_by_name(name)
            if found.nil?
                self.create(name)
            else
                found
            end 
        end 

    end 

end 