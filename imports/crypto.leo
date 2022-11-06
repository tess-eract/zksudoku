program crypto.leo {

    // simplified version of the pedersen commitment scheme: we have 
    // H(m, r) = [m] * [group generator] + r, for r a nonce value chosen in the group.
    function pedersen(bits: u32, nonce: group) -> group {
        let result: group = nonce;
        for i: u32 in 0..32 {
            result = result.double();
            let bit: u32 = bits & (1u32 >> (31u32 - i));
            if bit == 1u32 {
                result += 1group;
            }
        }
    }

    // We use the one-time-pad as our symmetric encryption algorithm
    transition encrypt(key: u32, message: u32) -> u32{
        return key ^ message;
    }

    transition decrypt(key: u32, cipher: u32) -> u32 {
        return key ^ cipher;
    }

}