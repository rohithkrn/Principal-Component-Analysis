%% This script implements the principal component analysis.
%% It computes the prinicpal components of the input data Z
%% and does singular value decomposition. Principal components are 
%% found by largest eigen vectors

%% Training the data set

Zmean = mean(Z,2);
Zc = Z - Zmean;
[n,p] = size(Z);

[A,B,C] = svd(Zc/sqrt(p-1));
b = diag(B);
figure,plot(b);title 'Eigen values'; grid on;

%% Testing
Tmean = mean(T,2);

Ttest = T(:,1:2);
TtestC = Ttest - Zmean;

% r = 0,1,25,50,100, choosing the no. of principle components

U1 = A(:,1:1);
U25 = A(:,1:25);
U50 = A(:,1:50);
U100 = A(:,1:100);

Trecon0 = repmat(Zmean,[1,2]); % for 0 components it is just mean
Trecon1 = (U1*U1'*TtestC) + Zmean;
Trecon25 = (U25*U25'*TtestC) + Zmean;
Trecon50 = (U50*U50'*TtestC) + Zmean;
Trecon100 = (U100*U100'*TtestC) + Zmean;

test1 = reshape(Ttest(:,1),112,92);
test2 = reshape(Ttest(:,2),112,92);

% choose the variable TreconXX to plot the required plots in below reshape
% functions
R_test1 = reshape(Trecon100(:,1),112,92); 
R_test2 = reshape(Trecon100(:,2),112,92);

figure,subplot(1,2,1);imagesc(test1);title('original');colormap gray; 
subplot(1,2,2);imagesc(R_test1);title('Reconstructed');colormap gray; 

figure,subplot(1,2,1);imagesc(test2);title('original');colormap gray; 
subplot(1,2,2);imagesc(R_test2);title('Reconstructed');colormap gray; 
