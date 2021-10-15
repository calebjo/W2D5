class Item
    attr_reader :deadline
    attr_accessor :title, :description, :done

    def self.valid_date?(date_string)
        valid_format = date_string.split("-")

        valid_length = valid_format.length == 3
        valid_year = valid_format[0].length == 4
        valid_month = valid_format[1].length == 2 && valid_format[1].to_i <= 12
        valid_day = valid_format[2].length == 2 && valid_format[2].to_i  <= 31

        valid_length && valid_year && valid_month && valid_day
    end

    def initialize(title, deadline, description)
        @title = title
        @deadline = deadline
        @description = description
        @done = false

        if !Item.valid_date?(deadline)
            raise Exception.new("Invalid date format.")
        end
    end

    def toggle
        if @done == false
            @done = true
        else
            @done = false
        end
    end

end