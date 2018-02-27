// Triad over multi-dimensional arrays (N x 2 x 4 x 8)
// Array opeations (all in multi-dimensional context):
//  * vadd2 (x1)
//  * vmul2 (x1)
////////
function MD_triad(MD1, MD2, MD3)
   R = MD1 + (MD2 .* MD3);
endfunction
