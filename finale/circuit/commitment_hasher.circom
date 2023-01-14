pragma circom 2.0.0;

include "./utils/pedersen.circom";

template CommitmentHasher() {
    signal input secret[256];
    signal input nullifier[256];
    signal output commitment;
    signal output nullifierHash;

    component cHasher = Pedersen(512);
    component nHasher = Pedersen(256);

    for(var i = 0; i < 256; i++){
        cHasher.in[i] <== nullifier[i];
        cHasher.in[i + 256] <== secret[i];
        nHasher.in[i] <== nullifier[i];
    }

    commitment <== cHasher.o;
    nullifierHash <== nHasher.o;
}