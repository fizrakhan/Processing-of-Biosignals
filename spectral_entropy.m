function H = spectral_entropy(P, nfactor)
% P is the PDS of the window
% nfactor scaling factor, needed for normalization of spectral entropy
% You can rename the function variables if you want.

% Eq 1: Normalization of Power Spectrum

Cn = 1/sum(P); % Calculate normalization constant
normalized_P = Cn * P; % Normalize the power spectrum

% Eq 2: Computation of Spectral Entropy
S = -sum(normalized_P .* log(normalized_P)); % executing element wise multiplication

% % Eq 3: Normalization of Entropy
 N = length(P); % Total number of frequency components
 H = S / N; % Normalize the entropy

% Scale the entropy value using the provided scaling factor nfactor
H = S / nfactor;
end