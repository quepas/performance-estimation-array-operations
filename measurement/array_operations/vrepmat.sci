// Replicate row-vector two form a square matrix
function vrepmat(V)
   N = length(V); // (!) lookup function discarded
   R = repmat(V, N, 1);
endfunction
