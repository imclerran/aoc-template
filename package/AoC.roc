module {read!, stdout!, time!} -> [Solution, solve!]

Solution err : {
    year : U64,
    day : U64,
    title : Str,
    part1 : Str -> Result Str [SomeErr]err,
    part2 : Str -> Result Str [SomeErr]err,
} where err implements Inspect

solve! : Solution err => Result {} _
solve! = |{year, day, title, part1, part2}|
    stdout!(
        Str.join_with(
            [
                green("--- ADVENT OF CODE "),
                green("${Num.to_str(year)}-${Num.to_str(day)}: ${title}"),
                green(" ---\n\n"),
                blue("INPUT:\n"),
                "Reading input from STDIN...\n\n"
            ],
            ""
        )
    )?

    start_read = time!({})

    input: Str
    input = 
        read!({})?
        |> Str.from_utf8
        |> Result.map_err(|_| InvalidUtf8Input)?

    end_read = time!({})
    start_part1 = end_read

    solution_part1: Result Str _
    solution_part1 = part1(input)
    end_part1 = time!({})

    part_one_task! = |{}|
        when solution_part1 is
            Ok(str)->
                caption = blue("PART 1:\n")
                solution = "${str}\n\n"
                Str.join_with([caption, solution], "") |> stdout!

            Err(err) ->
                caption = red("PART 1 ERROR:\n")
                error = "${Inspect.to_str(err)}\n\n"
                Str.join_with([caption, error], "") |> stdout!
                
    part_one_task!({})?
    start_part2 = time!({})

    solution_part2: Result Str _
    solution_part2 = part2(input)
    end_part2 = time!({})

    part_two_task! = |{}|
        when solution_part2 is
            Ok(str) ->
                caption = blue("PART 2:\n")
                solution = "${str}\n\n"
                Str.join_with([caption, solution], "") |> stdout!

            Err(err) ->
                caption = red("PART 2 ERROR:\n")
                error = "${Inspect.to_str(err)}\n\n"
                Str.join_with([caption, error], "") |> stdout!

    part_two_task!({})?

    read_millis =
        if (end_read - start_read) < 1 then
            "<1"
        else
            Num.to_str(end_read - start_read)

    part1_millis = 
        if (end_part1 - start_part1) < 1 then
            "<1"
        else
            Num.to_str(end_part1 - start_part1)

    part2_millis = 
        if (end_part2 - start_part2) < 1 then
            "<1"
        else
            Num.to_str((end_part2 - start_part2))

    Str.join_with(
        [
            blue("TIMING:\n"),
            "READING INPUT:  ",
            blue("${read_millis}ms\n"),
            "SOLVING PART 1: ",
            blue("${part1_millis}ms\n"),
            "SOLVING PART 2: ",
            blue("${part2_millis}ms\n"),
            green("---\n")
        ],
        ""
    ) |> stdout!

blue = |str| "\u(001b)[0;34m${str}\u(001b)[0m"
green = |str| "\u(001b)[0;32m${str}\u(001b)[0m"
red = |str| "\u(001b)[0;31m${str}\u(001b)[0m"
