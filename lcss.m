% Longest Common Subsequence : Similarity measure between two 2-D time series
% signals
% Similarity ~ 1/ (Distance), small distance == high similarity and
% vice-versa
% Author: Murali Pasupuleti , 2017 Copyright
function d=lcss(refSignal,Signal,epsilon, sigma)
% refSig: Reference signal , array of length n
% Signal: Incoming Signal for matching, array of length m
% epsilon: space bounding parameter epsilon
% sigma : time bounding parameter (can be optional)
% d: resulting distance
if nargin<3
    epsilon= 0.2; % space window in amplitude
    sigma = 20; % time window in cycles
end
if nargin<4
    sigma = 20; % time window in cycles
end
refLength=size(refSignal,1);
sigLength=size(Signal,1);

%% initialization
D=zeros(refLength+1,sigLength+1); % LCSS matrix
%% begin dynamic programming
for i=1:refLength
    for j= 1: sigLength     
        dx = i - j ;
        dy = refSignal(i)-Signal(j);
        % restrict search length using sigma 
        if norm(dy) < epsilon && norm(dx) <=sigma
            D(i+1,j+1)= 1 + D(i,j);
        else
            D(i+1,j+1)= max( [D(i,j+1), D(i+1,j) ]);
        end
    end
end
d= 1 - (D(refLength+1,sigLength+1)/min(refLength,sigLength));
end