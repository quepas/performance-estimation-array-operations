% Replicate row-vector two form a square matrix
function vrepmatneg(V)
   N = length(V); % (!) lookup function discarded
   R = -(repmat(V, N, 1));
end
