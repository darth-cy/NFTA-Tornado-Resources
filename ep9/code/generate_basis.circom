pragma circom 2.0.0;

include "./utils/montgomery.circom";

template generate_basis() {
    signal input x;
    signal input y;

    signal basis[51][2];
    signal basis2[51][2];
    signal basis3[51][2];
    signal basis4[51][2];
    signal basis5[51][2];
    signal basis6[51][2];
    signal basis7[51][2];
    signal basis8[51][2];

    signal output oPoints[50][2];
    signal output o2Points[50][2];
    signal output o3Points[50][2];
    signal output o4Points[50][2];
    signal output o5Points[50][2];
    signal output o6Points[50][2];
    signal output o7Points[50][2];
    signal output o8Points[50][2];

    component base2[50];
    component base4[50];
    component base8[50];
    component base16[50];
    component base32[50];

    component e2m = Edwards2Montgomery();
    e2m.in[0] <== x;
    e2m.in[1] <== y;

    basis[0][0] <== e2m.out[0];
    basis[0][1] <== e2m.out[1];

    for(var i = 0; i < 50; i++){
        base2[i] = MontgomeryDouble();
        base4[i] = MontgomeryDouble();
        base8[i] = MontgomeryDouble();
        base16[i] = MontgomeryDouble();
        base32[i] = MontgomeryDouble();

        base2[i].in[0] <== basis[i][0];
        base2[i].in[1] <== basis[i][1];

        base4[i].in[0] <== base2[i].out[0];
        base4[i].in[1] <== base2[i].out[1];
        basis2[i][0] <== base2[i].out[0];
        basis2[i][1] <== base2[i].out[1];

        base8[i].in[0] <== base4[i].out[0];
        base8[i].in[1] <== base4[i].out[1];
        basis4[i][0] <== base4[i].out[0];
        basis4[i][1] <== base4[i].out[1];

        base16[i].in[0] <== base8[i].out[0];
        base16[i].in[1] <== base8[i].out[1];
        basis8[i][0] <== base8[i].out[0];
        basis8[i][1] <== base8[i].out[1];

        base32[i].in[0] <== base16[i].out[0];
        base32[i].in[1] <== base16[i].out[1];

        basis[i + 1][0] <== base32[i].out[0];
        basis[i + 1][1] <== base32[i].out[1];
    }

    component adders3[50];
    for(var i3 = 0; i3 < 50; i3++){
        adders3[i3] = MontgomeryAdd();
        adders3[i3].in1[0] <== basis[i3][0];
        adders3[i3].in1[1] <== basis[i3][1];
        adders3[i3].in2[0] <== basis2[i3][0];
        adders3[i3].in2[1] <== basis2[i3][1];

        basis3[i3][0] <== adders3[i3].out[0];
        basis3[i3][1] <== adders3[i3].out[1];
    }

    component adder5[50];
    for(var i5 = 0; i5 < 50; i5++){
        adder5[i5] = MontgomeryAdd();
        adder5[i5].in1[0] <== basis[i5][0];
        adder5[i5].in1[1] <== basis[i5][1];
        adder5[i5].in2[0] <== basis4[i5][0];
        adder5[i5].in2[1] <== basis4[i5][1];

        basis5[i5][0] <== adder5[i5].out[0];
        basis5[i5][1] <== adder5[i5].out[1];
    }

    component adder6[50];
    for(var i6 = 0; i6 < 50; i6++){
        adder6[i6] = MontgomeryAdd();
        adder6[i6].in1[0] <== basis[i6][0];
        adder6[i6].in1[1] <== basis[i6][1];
        adder6[i6].in2[0] <== basis5[i6][0];
        adder6[i6].in2[1] <== basis5[i6][1];

        basis6[i6][0] <== adder6[i6].out[0];
        basis6[i6][1] <== adder6[i6].out[1];
    }

    component adder7[50];
    for(var i7 = 0; i7 < 50; i7++){
        adder7[i7] = MontgomeryAdd();
        adder7[i7].in1[0] <== basis[i7][0];
        adder7[i7].in1[1] <== basis[i7][1];
        adder7[i7].in2[0] <== basis6[i7][0];
        adder7[i7].in2[1] <== basis6[i7][1];

        basis7[i7][0] <== adder7[i7].out[0];
        basis7[i7][1] <== adder7[i7].out[1];
    }


    for(var j = 0; j < 50; j++){
        oPoints[j][0] <== basis[j][0];
        oPoints[j][1] <== basis[j][1];

        o2Points[j][0] <== basis2[j][0];
        o2Points[j][1] <== basis2[j][1];

        o3Points[j][0] <== basis3[j][0];
        o3Points[j][1] <== basis3[j][1];

        o4Points[j][0] <== basis4[j][0];
        o4Points[j][1] <== basis4[j][1];

        o5Points[j][0] <== basis5[j][0];
        o5Points[j][1] <== basis5[j][1];

        o6Points[j][0] <== basis6[j][0];
        o6Points[j][1] <== basis6[j][1];

        o7Points[j][0] <== basis7[j][0];
        o7Points[j][1] <== basis7[j][1];

        o8Points[j][0] <== basis8[j][0];
        o8Points[j][1] <== basis8[j][1];
    }
}

component main = generate_basis();