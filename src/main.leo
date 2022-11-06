// Import the sudoku and crypto libraries 

import puzzle.leo;
import crypto.leo;

// The 'zksudoku' program.
program zksudoku.aleo {

    transition commit(puzzle: Puzzle, key: u32) -> (u32, group) {
        // Check and prove that the puzzle is valid 
        let puzzle_is_valid: bool = puzzle.leo/check_puzzle(puzzle);
        console.assert_eq(puzzle_is_valid, true);

        let cipher: u32 = crypto.leo/encrypt(puzzle.bits, key);

        let hash: group = crypto.leo/pedersen(key, 0group);

        return (cipher, hash);
    }
}
