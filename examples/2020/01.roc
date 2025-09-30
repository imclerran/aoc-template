app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br",
    aoc: "../../package/main.roc",
}

import pf.Stdin
import pf.Stdout
import pf.Utc
import aoc.AoC {
    stdin!: Stdin.read_to_end!,
    stdout!: Stdout.write!,
    time!: |{}| Utc.now!({}) |> Utc.to_millis_since_epoch,
}

main! = |_|
    AoC.solve!(
        {
            year: 2020,
            day: 1,
            title: "Report Repair",
            part1,
            part2,
        },
    )

part1 : Str -> Result Str [NoValidPairs(Str)]
part1 = |input|
    numbers = parse_numbers(input)

    combined =
        List.join_map(numbers, |x|
            List.map(numbers, |y|
                { x, y, sum: x + y, mul: x * y }
            )
        )

    when List.keep_if(combined, |c| c.sum == 2020) is
        [first, ..] -> Ok("${Num.to_str(first.x)} * ${Num.to_str(first.y)} = ${Num.to_str(first.mul)}")
        _ -> Err(NoValidPairs("expected at least one pair to have sum of 2020"))

part2 : Str -> Result Str [NoValidPairs(Str)]
part2 = |input|
    numbers = parse_numbers(input)

    combined =
        List.join_map(numbers, |x|
            List.join_map(numbers, |y|
                List.map(numbers, |z|
                    { x, y, z, sum: x + y + z, mul: x * y * z }
                )
            )
        )

    when List.keep_if(combined, |c| c.sum == 2020) is
        [first, ..] -> Ok("${Num.to_str(first.x)} * ${Num.to_str(first.y)} * ${Num.to_str(first.z)} = ${Num.to_str(first.mul)}")
        _ -> Err(NoValidPairs("expected at least one triple to have sum of 2020"))

parse_numbers = |input| input |> Str.split_on("\n") |> List.keep_oks(Str.to_u64)

expect
    result = part1(example)
    result == Ok("1721 * 299 = 514579")

expect
    result = part2(example)
    result == Ok("979 * 366 * 675 = 241861950")

expect parse_numbers(example) == [1721, 979, 366, 299, 675, 1456]

example =
    """
    1721
    979
    366
    299
    675
    1456
    """
