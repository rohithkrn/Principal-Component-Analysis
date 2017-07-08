% gauss_scatter.m
%
% This file generates scatter plots of 3-dimensional Gaussian rv's.
% Here, the rank of the covariance matrix of the multivariate 
% Gaussian distribution can be specified (1, 2, or 3).

clear all
close all
clc

% r = rank of covariance matrix (1, 2, or 3)
r = 2;

% number of realizations
num_realizations = 5000;

% *****************************************
% First generate a rank-r covariance matrix
% *****************************************

% (Randomly) Generate orthogonal eigenvectors
A = randn(3,3);
U = orth(A);

% Specify (nonnegative!) eigenvalues deterministically
% evals = [ones(r,1); zeros(3-r,1)];
evals = [1 0.01 0];
% evals = [1 1 0.01];

% Could also randomly generate (nonzero) eigenvalues! 
% (uncomment the line below)
% evals = [rand(r,1); zeros(3-r,1)];
S = diag(evals);

% Assemble the covariance matrix
C = U*S*U';



% **********************************************
% Now generate 'num_realizations' draws from 
% a zero-mean multivariate Gaussian distribution
% having this covariance matrix
% **********************************************

% Generate num_realizations iid N(0,I_3) random vectors
X = randn(3,num_realizations);

% Generate 
Y = U*sqrt(S)*X;



% ******************
% Visualize the data
% ******************

figure(1)

% Create scatter plot of the data in 3 dimensions
scatter3(Y(1,:), Y(2,:), Y(3,:),'.');
axis equal

% This is a check to see that we're generating data 
% with the right covariance matrix
cov_mat = C
emp_cov_mat = cov(Y')

% ************************************************************

sing_val_orig = svd(cov_mat)
sing_val_emp = svd(emp_cov_mat)




