program puzzle.leo {

    struct Puzzle {
        bits: u32
    }

    // index for a row, column, or box in the puzzle: a 2-bit integer
    struct u2 {
        bit0: bool,
        bit1: bool,
    }

    function get_row (puzzle: Puzzle, index: u2) -> u32 {
        // masks
        // 0x00FF
        const ROW0 : u32 = 255u32;
        // 0xFF00
        const ROW1 : u32 = 65280u32;
        // 0xFF0000
        const ROW2: u32 = 16711680u32;
        //FF000000
        const ROW3: u32 = 4278190080u32;

        let result = index == 0u32 ? ROW0 : (index == 1 ? ROW1 : (index == 2 ? ROW2 : (index == 3 ? ROW3 : 0u32)));
        return result;
    }
}
