program puzzle.aleo {
    // We consider a 4x4 Sudoku puzzle as a 32-bit integer, or 
    // a 16-digit number in base 4. 
    struct Puzzle {
        bits: u32
    }

    // Extracts the row at "index" from the puzzle, and returns it as a
    // 32-bit integer which will always be between 0 and 33 (base 4)
    function get_row (puzzle: Puzzle, index: u8) -> u32 {
        // masks
        // 0x00FF
        const ROW0 : u32 = 255u32;
        // 0xFF00
        const ROW1 : u32 = 65280u32;
        // 0xFF0000
        const ROW2: u32 = 16711680u32;
        //FF000000
        const ROW3: u32 = 4278190080u32;

        let index_in_bounds : bool = false;

        if index == 0u8 {
            index_in_bounds = true;
            return puzzle.bits & ROW0; 
        } else if index == 1u8 {
            index_in_bounds = true;
            return puzzle.bits & ROW1;
        } else if index == 2u8 {
            index_in_bounds = true;
            return puzzle.bits & ROW2;
        }   else if index == 3u8 {
            index_in_bounds = true;
            return puzzle.bits & ROW3;
        }
        // Index should always be 0-3: raises an error if not
        console.assert_eq(index_in_bounds, true);
        return 0u32;
    }

    // Extracts the column at "index" from the puzzle, and returns it as a
    // 32-bit integer which will always be between 0 and 33 (base 4)
    function get_column (puzzle: Puzzle, index: u8) -> u32 {
        // masks
        // 0003,0003,0003,0003 (base 4)
        const COL0 : u32 = 50529027u32;
        // 0030,0030,0030,0030 (base 4)
        const COL1 : u32 = 202116108u32;
        // 0300,0300,0300,0300 (base 4)
        const COL2: u32 = 808464432u32;
        // 3000,3000,3000,3000 (base 4)
        const COL3: u32 = 3233857728u32;

        let index_in_bounds : bool = false;

        if index == 0u8 {
            index_in_bounds = true;
            return puzzle.bits & COL0; 
        } else if index == 1u8 {
            index_in_bounds = true;
            return puzzle.bits & COL1;
        } else if index == 2u8 {
            index_in_bounds = true;
            return puzzle.bits & COL2;
        }   else if index == 3u8 {
            index_in_bounds = true;
            return puzzle.bits & COL3;
        }
        // Index should always be 0-3: raises an error if not
        console.assert_eq(index_in_bounds, true);
        return 0u32;
    }

    // Extracts the 2x2 box at "index" from the puzzle, and returns it as a
    // 32-bit integer which will always be between 0 and 33 (base 4)
    function get_box (puzzle: Puzzle, index: u8) -> u32 {
        // masks
        // 3300,3300,0000,0000 (base 4)
        const BOX0 : u32 = 4042260480u32;
        // 0033, 0033,0000,0000 (base 4)
        const BOX1 : u32 = 252641280u32;
        // 0000,0000,3300,3300 (base 4)
        const BOX2: u32 = 61680u32;
        // 0000,0000,0033,0033 (base 4)
        const BOX3: u32 = 3855u32;

        let index_in_bounds : bool = false;

        if index == 0u8 {
            index_in_bounds = true;
            return puzzle.bits & BOX0; 
        } else if index == 1u8 {
            index_in_bounds = true;
            return puzzle.bits & BOX1;
        } else if index == 2u8 {
            index_in_bounds = true;
            return puzzle.bits & BOX2;
        }   else if index == 3u8 {
            index_in_bounds = true;
            return puzzle.bits & BOX3;
        }
        // Index should always be 0-3: raises an error if not
        console.assert_eq(index_in_bounds, true);
        return 0u32;
    }

// Thinking of a 32-bit integer as a 16-digit number in base 4, checks to see if each of the digits
// 0, 1, 2, 3 are present, each exactly once. Returns true if this condition is met. 
// h/t to SPWorley on StackOverflow (https://stackoverflow.com/questions/289537/a-cool-algorithm-to-check-a-sudoku-field)
// for this cool hack!

function no_duplicates(vec: u32) -> bool {
    let result: u32 = 0u32; 
    // how many non-zero digits are present: should be exactly 3
    let digit_count: u32 = 0u32;

    // result will be a number from 0000 to 1111 (base 2), 
    // and will be 1111 (base 2) = 15 (base 10) exactly when 
    // each of the digits 0, 1, 2, 3 are present
    for i: u32 in 0u32..16u32 {
        // a number from 0 to 3 
        let base_4_digit: u32 = (vec >> (2u32 * i)) & 3u32; 
        if base_4_digit != 0u32 {
            digit_count += 1u32;
            }
        result |= (1u32 << base_4_digit);
    }
    return (result == 15u32) && (digit_count == 3u32);
}

// Checks if 'puzzle' is a valid 4x4 Sudoku solution: that is, that each row, column, and 
// 2x2 box contains the digits 0, 1, 2, 3. 
transition check_puzzle(puzzle: Puzzle) -> bool {
    let result: bool = true;

    for i: u8 in 0u8..4u8 {
        result &= no_duplicates(get_row(puzzle, i));
        result &= no_duplicates(get_column(puzzle, i));
        result &= no_duplicates(get_box(puzzle, i));
    }

    return result;
}

}
