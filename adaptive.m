function [e,H] = adaptive(S_chest, S_abdomen, delta, N, H)

e = zeros(length(S_chest));
y = zeros(1,N);

% N filter order, H start values
    for n = N:length(S_chest);

% Calculating the most recent samples 
        r_n = S_chest(n:-1:n-N+1);
        r_n = transpose(r_n);

% Calculating the output signal 
        y(n) = dot(H, r_n);

% Calculating the error signal 
        e(n) = S_abdomen(n-(N-1)/2) - (y(n));

% Updating the filter coefficients
        H = H + (delta * e(n) * r_n);


    end

end