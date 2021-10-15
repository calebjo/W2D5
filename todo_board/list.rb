require_relative 'item.rb'

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = nil)
        no_descrip = description
        no_descrip = "" if description == nil

        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, no_descrip)
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index >= 0 && index < @items.length
    end

    def swap(index_1, index_2)
        if self.valid_index?(index_1) && self.valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def [](index)
        if self.valid_index?(index)
            @items[index]
        else
            return nil
        end
    end

    def priority
        @items[0]
    end

    def print
        puts "-------------------------------------------------------"
        puts label.rjust(35)
        puts "-------------------------------------------------------"
        puts "Index".ljust(5) + " | " + "Item".ljust(20) + " | " + "Deadline".ljust(12) + " | " + "Done?".ljust(6)
        puts "-------------------------------------------------------"
        # print list items with | in between and ljust
        @items.each_with_index do |item, i|
            puts "#{i.to_s.ljust(5)} | #{item.title.ljust(20)} | #{item.deadline.ljust(12)} | #{item.done.to_s.ljust(6)}"
        end
        puts "-------------------------------------------------------"
    end

    def print_full_item(index)
        if self.valid_index?(index)
            item = @items[index]
            puts "------------------------------------------"
            puts item.deadline.ljust(30) + item.title
            puts item.description.ljust(30) + item.done.to_s
            puts "------------------------------------------"
        end
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount = 1)
        if self.valid_index?(index)
            i = index  # index of element to be swapped up
            target_idx = index - amount
            while i > target_idx
                self.swap(i, i - 1)
                # @items[i], @items[i - 1] = @items[i - 1], @items[i]
                i -= 1
            end
            return true
        else
            return false
        end
    end

    def down(index, amount = 1)
        if self.valid_index?(index)
            i = index # index of element to be swapped down
            target_idx = index + amount
            while i < target_idx && i < @items.length - 1
                self.swap(i, i + 1)
                # @items[i], @items[i + 1] = @items[i + 1], @items[i]
                i += 1
            end
            return true
        else
            return false
        end
    end

    # CHECKPOINT ------------------------------------------------------

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        if self.valid_index?(index)
            @items.delete_at(index)
            return true
        else
            return false
        end
    end

    def purge
        @items.delete_if(&:done)
    end

    # CHECKPOINT ------------------------------------------------------

    # LIST TEST
    # load 'list.rb'
    # my_list = List.new('Groceries')
    # my_list.add_item('cheese', '2019-10-25', 'Get American and Feta for good measure.')
    # my_list.add_item('toothpaste', '2019-10-25')
    # my_list.add_item('shampoo', '2019-10-24')
    # my_list.add_item('candy', '2019-10-31', '4 bags should be enough')
end