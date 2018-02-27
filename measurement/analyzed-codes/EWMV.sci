// EWMV > Element-wise matrix-vector multiplication
// Array operations:
//  * vrepmat (x1)
//  * vmul2 (x1)
////////
function EWMV(M, V)
   N = size(M, 1); // (!) simple lookup function discarded
   R = M .* repmat(V, N, 1); // vrepmat, vmul2
endfunction
