# Advent of Code Template

Solve AoC puzzles using [Roc](https://www.roc-lang.org) 🤘

Roc is a [fast](https://www.roc-lang.org/fast), [friendly](https://www.roc-lang.org/friendly), and [functional](https://www.roc-lang.org/functional) language which makes it ideal for AoC.

You can find my solutions to previous years at [lukewilliamboswell/aoc](https://github.com/lukewilliamboswell/aoc). I try to keep these up to date with the latest version of roc as a resource for others, but also to test roc language features and help me find potential issues.

## Getting Started

To get started, make sure you have [installed roc](https://www.roc-lang.org/install).

This package provides a helper function `AoC.solve` that reads the problem input from STDIN, and runs your provided solutions for part 1 and part 2, and then prints the results with some helpful timing information.

```sh
$ roc 2020/01.roc < input/2020_01.txt
--- ADVENT OF CODE 2020-1: Report Repair ---

INPUT:
Reading input from STDIN...

PART 1:
462 * 1558 = 719796

PART 2:
277 * 1359 * 384 = 144554112

TIMING:
READING INPUT:  1ms
SOLVING PART 1: <1ms
SOLVING PART 2: 209ms
---
```

A starter solution:

```roc
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br",
    aoc: "../package/main.roc",
}

import pf.Stdin
import pf.Stdout
import pf.Utc
import aoc.AoC {
    read!: Stdin.read_to_end!,
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

## Implement your part1 and part2 solutions here
part1 : Str -> Result Str _
part1 = |_| Err TODO

part2 : Str -> Result Str _
part2 = |_| Err TODO
```

Example implementation:
```roc
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
```
