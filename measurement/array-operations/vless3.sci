// Element-wise comparision of three vectors (less then)
function vless3(V1, V2, V3)
   R = double(V1 < V2) < V3; // Required conversion from boolean to double
endfunction