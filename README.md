# Noir Elliptic Curve Discrete Log Proof Circuit

This repository contains a Noir circuit for verifying elliptic curve scalar multiplication on the secp256k1 curve. The circuit can be used as a building block for zero-knowledge proofs involving discrete logarithms, ECDSA, or other elliptic curve protocols.

## Features

- **Verifies secp256k1 scalar multiplication:**  
  Given a point \( P = (x, y) \), a scalar \( k \), and a result point \( Q = (x', y') \), the circuit checks that \( Q = k \cdot P \).

- **Curve Membership Checks:**  
  Both the input and result points are asserted to be on the secp256k1 curve.

- **Flexible Test Suite:**  
  Includes positive and negative tests for:
  - Correct scalar multiplication
  - Incorrect result
  - Input or result points not on the curve
  - Edge cases (e.g., point at infinity, zero scalar)

## Structure

- `src/main.nr`  
  Main Noir circuit, containing the core logic and tests.
- `src/`  
  May contain additional helper or test files.
- `README.md`  
  This file.

## Usage

### Requirements

- [Noir](https://noir-lang.org/) (v0.18+ recommended)
- [nargo](https://noir-lang.org/docs/getting_started/quick_start#installation) (Noir package manager)
- Rust (for installing Noir)

### Running Tests

To run all tests:

```bash
nargo test
```

This will compile your circuit and run all `#[test]` functions.

### Proving and Verifying

1. **Provide inputs in TOML format** (see Noir documentation).
2. Prove with:

    ```bash
    nargo prove
    ```
3. Verify with:

    ```bash
    nargo verify
    ```

## Example Test

```rust
#[test]
fn test_secp256k1_scalar_mul() {
    let g_x = Secp256k1_Fq::from_limbs([...]);
    let g_y = Secp256k1_Fq::from_limbs([...]);
    let k = Secp256k1_Fr::from_limbs([2,0,0]);
    let q_x = Secp256k1_Fq::from_limbs([...]);
    let q_y = Secp256k1_Fq::from_limbs([...]);

    check_scalar_mul(g_x, g_y, k, q_x, q_y);
}
```

## Adding More Tests

- Test with invalid points, wrong results, zero scalar, or point at infinity.
- See the included test cases for examples.

## References

- [Noir documentation](https://noir-lang.org/docs/)
- [SEC secp256k1 standard](https://www.secg.org/sec2-v2.pdf)
- [Elliptic Curve Cryptography (Wikipedia)](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography)

---

