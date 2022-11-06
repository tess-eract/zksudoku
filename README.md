## ZK Commitments for atomic Sudoku swaps with Leo

Quoting from the Aleo bounty page from the Network Effects Hackathon:

While Aleo’s blockchain is designed from the bottom up to work with Zero Knowledge Proofs, it is possible to hack in a type of ZK functionality into any blockchain using Greg Maxwell’s concept of Zero Knowledge Contingent Payments. The scheme works as follows:

Peter wants to sell Vanessa a solution to a hard sudoku puzzle she has been working on for 1 Bitcoin in an atomic manner. They do the following:

1. Peter encrypts his solution S to the puzzle with key K to produce ciphertext C.
2. Peter creates a hash H of decryption key K.
3. Peter creates a ZKP that proves:
    1. the plaintext for C is a valid solution to the given puzzle (S)
    2. the preimage of H is the decryption key K for C
4. Peter sends H, C, and the ZKP to Vanessa, keeping K and S secret.
5. Vanessa verifies the ZKP against H and C and if she is convinced, she works with Peter to construct a timelocked multisig contract for 1 Bitcoin with the following properties:
    1. for the first n blocks of the contract’s confirmation, the only 2 spend conditions for the 1 Bitcoin is to publish the preimage of the Hash H, or for a cooperative signature from both Peter and Vanessa.
    2. after the first n blocks, the only valid spend condition for the 1 Bitcoin is a signature from Vanessa.
    
    Since the preimage to H is the decryption key K for the ciphertext C of the sudoku solution which Vanessa has, the only way for Peter to claim his funds is to publish K on-chain, which Vanessa can then use to decrypt C and solve her sudoku Puzzle!


## Build Guide

To compile this Aleo program, run:

```bash
leo build
```

## Usage Guide
To generate (C, H) as described in the above protocol, run:
```bash
leo run commit {SOLUTION} {KEY}
```
Here, KEY can be an arbitrary u32 value, and SOLUTION should be a solution to a 4x4 Sudoku puzzle. This should be encoded as a u32: the solution is
a 4x4 grid of integers 0-3, so it can be viewed as a 16-digit base 4 numeral. leo only accepts numeric literals in base 10, so this should be converted 
to base 10. 

## Example

4x4 Sudoku solution: 
```
0 1 2 3
2 3 0 1 
3 0 1 2
1 2 3 0

=> 0123,2301,3012,1230 (base 4) = 464635500 (base 10)
```

```bash
leo run commit 464635500u32 8675309u32
```

Output:
```bash
Leo Compiled 'main.leo' into Aleo instructions
       Leo Compiled 'puzzle.leo' into Aleo instructions
       Leo ✅ Built 'zksudoku.aleo' (in "/Users/danieldore/aleo/hackathon/zksudoku/build")

🚀 Executing 'zksudoku.aleo/commit'...

 • Executing 'zksudoku.aleo/commit'...
 • Executed 'check_puzzle' (in 2007 ms)
 • Executed 'commit' (in 1686 ms)

➡️  Outputs

 • 456497537u32
 • 1507841951419850460722016533061361042665270357788835473424582010073641644174field

       Leo ✅ Executed 'zksudoku.aleo/commit'
```

