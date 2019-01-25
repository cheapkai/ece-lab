function y = doFilter1(x)
%DOFILTER Filters input x and returns output y.

% MATLAB Code
% Generated by MATLAB(R) 9.2 and the DSP System Toolbox 9.4.
% Generated on: 28-Feb-2018 14:55:07

%#codegen

% To generate C/C++ code from this function use the codegen command.
% Type 'help codegen' for more information.

persistent Hd;

if isempty(Hd)
    
    % The following code was used to design the filter coefficients:
    %
    % N     = 30;    % Order
    % F3dB1 = 48;    % First
    % F3dB2 = 52;    % Second
    % Fs    = 1000;  % Sampling Frequency
    %
    % h = fdesign.bandstop('n,f3db1,f3db2', N, F3dB1, F3dB2, Fs);
    %
    % Hd = design(h, 'butter', ...
    %     'SystemObject', true);
    
    Hd = dsp.BiquadFilter( ...
        'Structure', 'Direct form II', ...
        'SOSMatrix', [1 -1.90226322729797 1 1 -1.89166232359204 ...
        0.99727585726699; 1 -1.90226322729797 1 1 -1.90728115674503 ...
        0.997477414441532; 1 -1.90226322729797 1 1 -1.88700866662714 ...
        0.991980836586822; 1 -1.90226322729797 1 1 -1.90226322822367 ...
        0.992547830642406; 1 -1.90226322729797 1 1 -1.88308437514916 ...
        0.987097174839075; 1 -1.90226322729797 1 1 -1.89724335424046 ...
        0.987928819923776; 1 -1.90226322729797 1 1 -1.88006260756108 ...
        0.982848148831446; 1 -1.90226322729797 1 1 -1.892414848671 ...
        0.983799508481867; 1 -1.90226322729797 1 1 -1.87806628654633 ...
        0.979418481473896; 1 -1.90226322729797 1 1 -1.88796769675621 ...
        0.980325438309331; 1 -1.90226322729797 1 1 -1.8771644117306 ...
        0.976946615881604; 1 -1.90226322729797 1 1 -1.88408367165404 ...
        0.977653693010017; 1 -1.90226322729797 1 1 -1.87737213793083 ...
        0.975520664708658; 1 -1.90226322729797 1 1 -1.8809303666796 ...
        0.975907126021301; 1 -1.90226322729797 1 1 -1.87865412061548 ...
        0.97517787618065], ...
        'ScaleValues', [0.998610324470048; 0.998610324470048; ...
        0.996061004719662; 0.996061004719662; 0.993697603727432; ...
        0.993697603727432; 0.991618610568776; 0.991618610568776; ...
        0.989908918570854; 0.989908918570854; 0.988637128496061; ...
        0.988637128496061; 0.987853565625136; 0.987853565625136; ...
        0.987588938090325; 1]);
end

s = double(x);
y = step(Hd,s);
