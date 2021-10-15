require_relative 'item.rb'
require_relative 'list.rb'

class TodoBoard
    def initialize
        @board = {}
        # @list = List.new(label)
    end

    def get_command
        print "\nEnter a command: "
        user_input = gets.chomp
        command, list_label, *args = user_input.split(" ")

        case command
        when 'mklist'
            @board[list_label] = List.new(list_label)
        when 'mktodo'
            @board[list_label].add_item(*args)
        when 'ls'
            @board.each_key {|label| puts label }
        when 'showall'
            @board.each_value {|list| list.print }
        when 'up'
            @board[list_label].up(args.map(&:to_i))
        when 'down'
            @board[list_label].down(args.map(&:to_i))
        when 'swap'
            @board[list_label].swap(args[0].to_i, args[1].to_i)
        when 'sort'
            @board[list_label].sort_by_date!
        when 'priority'
            @board[list_label].print_priority
        when 'toggle'
            @board[list_label].toggle_item(args[0].to_i)
        when 'rm'
            @board[list_label].remove_item(args[0].to_i)
        when 'purge'
            @board[list_label].purge
        when 'print'
            if !args.empty?
                @board[list_label].print_full_item(args[0].to_i)
            else
                @board[list_label].print
            end
        when 'quit'
            return false
        else
            print "That command isn't recognized."
        end
        true
    end

    def run
        flag = true
        while flag
            flag = get_command
        end
    end

end

TodoBoard.new.run