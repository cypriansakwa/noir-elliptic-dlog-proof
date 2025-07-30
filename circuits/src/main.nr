use noir_bigcurve::curves::secp256k1::Secp256k1;
use noir_bigcurve::curves::secp256k1::Secp256k1Scalar;
use noir_bigcurve::scalar_field::ScalarFieldTrait;
use noir_bigcurve::BigCurveTrait;
use bignum::{Secp256k1_Fq, Secp256k1_Fr, BigNum};

fn check_scalar_mul(
    point_x: Secp256k1_Fq,
    point_y: Secp256k1_Fq,
    scalar: Secp256k1_Fr,
    result_x: Secp256k1_Fq,
    result_y: Secp256k1_Fq
) {
    let P = Secp256k1 { x: point_x, y: point_y, is_infinity: false };
    assert(!P.is_infinity);
    P.validate_on_curve();

    let Q = Secp256k1 { x: result_x, y: result_y, is_infinity: false };
    Q.validate_on_curve();

    let k: Secp256k1Scalar = Secp256k1Scalar::from_bignum(scalar);
    let computed_Q = P.mul(k);

    let valid = (computed_Q.x == result_x) * (computed_Q.y == result_y);
    assert(valid);
}

// main is the entrypoint for proving/verifying
pub fn main(
    point_x: pub Secp256k1_Fq,
    point_y: pub Secp256k1_Fq,
    scalar: Secp256k1_Fr,
    result_x: pub Secp256k1_Fq,
    result_y: pub Secp256k1_Fq
) {
    check_scalar_mul(point_x, point_y, scalar, result_x, result_y);
}

#[test]
fn test_secp256k1_scalar_mul() {
    let g_x = Secp256k1_Fq::from_limbs([809934545436666192144300149831112600, 532189659306663695932703699144214274, 31166]);
    let g_y = Secp256k1_Fq::from_limbs([123079417438355278731207347528586424, 1134337383257087261818981465599813885, 18490]);

    // Example scalar k
    let k = Secp256k1_Fr::from_limbs([2,0,0]);

    // Known k*G result (x, y) coordinates
    let q_x = Secp256k1_Fq::from_limbs([620769414058672675662360539292540645, 662428720985405666719129047941306460, 50692]);
    let q_y = Secp256k1_Fq::from_limbs([1278327165322711450801813382677652778, 545163776316525295403132726738087671, 6881]);

    // Call your circuit's main function (if using Noir integration test harness)
    check_scalar_mul(g_x, g_y, k, q_x, q_y);
}
#[test(should_fail)]
fn test_secp256k1_scalar_mul_wrong_result() {
    let g_x = Secp256k1_Fq::from_limbs([809934545436666192144300149831112600, 532189659306663695932703699144214274, 31166]);
    let g_y = Secp256k1_Fq::from_limbs([123079417438355278731207347528586424, 1134337383257087261818981465599813885, 18490]);

    // Example scalar k
    let k = Secp256k1_Fr::from_limbs([2,0,0]);

    // Known k*G result (x, y) coordinates
    let q_x = Secp256k1_Fq::from_limbs([258484535409603203050605737993582329, 716568843669635254349561846039718325, 63792]);
    let q_y = Secp256k1_Fq::from_limbs([3439865459799723184042666981123698, 638964607539318458049780617139410533, 14479]);

    // Call your circuit's main function (if using Noir integration test harness)
    check_scalar_mul(g_x, g_y, k, q_x, q_y);
}

#[test(should_fail)]
fn test_secp256k1_scalar_mul_wrong_point() {
    // Deliberately choose a point NOT on secp256k1
    let bad_x = Secp256k1_Fq::from_limbs([258484535409603203050605737993582330, 716568843669635254349561846039718325, 63792]);
    let bad_y = Secp256k1_Fq::from_limbs([3439865459799723184042666981123699, 638964607539318458049780617139410533, 14479]);
    let k = Secp256k1_Fr::from_limbs([2,0,0]);
    let q_x = Secp256k1_Fq::from_limbs([516969070819206406101211480282132933, 103909691554354635795316631799092074, 62049]);
    let q_y = Secp256k1_Fq::from_limbs([6879730919599446368085333962247398, 1277929215078636916099561234278821066, 28958]);

    check_scalar_mul(bad_x, bad_y, k, q_x, q_y);
}