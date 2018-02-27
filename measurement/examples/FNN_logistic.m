% FNN-logistic > Logistic function used
%              > as an activation function in neural networks
% Array operations
%  * vneg (x1)
%  * vexp (x1)
%  * vadd2 (x1)
%  * vdiv2 (x1)
%%%%
function FNN_logistic(A)
   R = 1 ./ (1 + exp(-A));
end
