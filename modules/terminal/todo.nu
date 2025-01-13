def "i del" [index: int] {
    let todo_file = $"($env.HOME)/.todo"
    let lines = (open $todo_file | lines)
    let line_count = ($lines | length)

    if $index > $line_count {
        return $"Error: Item number ($index) does not exist"
    }

    let line_to_delete = ($lines | get $index)
    $lines | enumerate | where index != $index | get item | str join "\n" | str trim | $"($in)\n" | save -f $todo_file

    print $"Deleted: ($line_to_delete)\nCurrent list:"

    if not ($todo_file | path exists) or ($todo_file | open | is-empty) {
        return "Todo list is empty"
    }
    open $todo_file | lines
}

def "i clear" [] {
    let todo_file = $"($env.HOME)/.todo"
    let confirm = input "Are you sure you want to clear the entire todo list? (y/N) "
    if not ($confirm =~ '^[yY]$') {
        return "Operation cancelled"
    }
    "" | save -f $todo_file
    "Todo list cleared"
}

def i [...args: string] {
    let todo_file = $"($env.HOME)/.todo"
    # Show the list if no arguments
    if ($args | is-empty) {
        if not ($todo_file | path exists) or ($todo_file | open | is-empty) {
            return "Todo list is empty"
        }
        return (open $todo_file | lines)
    }

    # Add a new item
    let new_item = ($args | str join " ") + (char newline)
    $new_item | save --append $todo_file
    $"Added: ($new_item)"
}
