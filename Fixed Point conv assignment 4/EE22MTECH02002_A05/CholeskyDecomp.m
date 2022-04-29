%%
%Give the input as Matrix A of size n x n
%Obtain the length of A
%Declare the L matrix of size n x n filled with zeros
%Declare the U matrix of size n x n filled with zeros
%fill the first element of the A and L matrix equal to sqrt(A(1,1))
A = [1 2 3 6 3;2 5 4 1 3;1 3 5 1 5;3 2 1 4 2; 4 5 6 4 2];
N = length(A);
L = zeros(N,N);
U = zeros(N,N);
L(1,1) = sqrt(A(1,1));
U(1,1) = L(1,1);

%%
%Calculation of first row and first column of upper and lower matrices
for a=2:N
    L(a,1) = A(a,1)/L(1,1);
    U(1,a) = A(1,a)/L(1,1);
end

%%
%Use of the equation to calculate the other elements of L,U
for i=2:N
    for j = i:N
        if i == j
            L(i,j) = sqrt(A(j,i)-L(j,1:i-1)*U(1:i-1,i));
            U(j,i) = L(j,i);
        else
            L(j,i)=(A(j,i)-L(j,1:i-1)*U(1:i-1,i))/L(i,i);
        end
    end
    for k = i+1:N
        U(i,k) = (A(i,k)-L(i,1:i-1)*U(1:i-1,k))/L(i,i);
    end
end

%%
%calculating inverse
Linv = inv(L);
Uinv = inv(U);
Ainv = Uinv*Linv
