function i --description 'Manage todo list: add, show, delete, or clear'
    set -l todo_file $HOME/.todo

    # Show the list if no arguments
    if test (count $argv) -eq 0
        if not test -s $todo_file
            echo "Todo list is empty"
            return
        end

        cat -n $todo_file
        return
    end

    # Clear the list
    if test "$argv[1]" = 99
        read -l -P "Are you sure you want to clear the entire todo list? (y/N) " confirm
        if test "$confirm" != y -a "$confirm" != Y
            echo "Operation cancelled"
            return
        end

        echo -n >$todo_file
        echo "Todo list cleared"
        return
    end

    # Delete an item
    if test "$argv[1]" -gt 0 2>/dev/null
        set -l line_count (wc -l < $todo_file)
        if test "$argv[1]" -gt $line_count
            echo "Error: Item number $argv[1] does not exist"
            return
        end

        set -l line_to_delete (sed -n "$argv[1]p" $todo_file)
        echo "Deleted: $line_to_delete"
        sed -i "$argv[1] d" $todo_file
        return
    end

    # Add a new item
    echo $argv >>$todo_file
    echo "Added: $argv"
end
