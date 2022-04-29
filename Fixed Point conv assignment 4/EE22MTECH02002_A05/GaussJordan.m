A = [1 2 3 6 3;2 5 4 1 3;1 3 5 1 5;3 2 1 4 2; 4 5 6 4 2];
n = 5;
B = A;
%Augment Identity Matrix of Order n to Matrix A

for i=1:n
    for j=1:n
        if i == j
            A(i,j+n)=1;
        else
            A(i,j+n)=0;
        end
    end
end

%Apply Gauss Jordan Elimination on Augmented Matrix (A)

for i = 1:n
    if A(i,i) == 0
        fprintf("Mathematical Error");
        break;
    end
    for j = 1:n
        if i~=j
            Ratio = A(j,i)/A(i,i);
            for k=1:2*n
                A(j,k) = A(j,k) - Ratio*A(i,k);
            end
        end
    end
end

%Row Operation to Convert Principal Diagonal to 1
for i = 1:n
    for j=n+1:2*n
        A(i,j)=A(i,j)/A(i,i);
    end
end
% Writing the whole Display Inverse Matrix
for i = 1:n
    for j = n+1:2*n
        C(i,j) = A(i,j);
    end
end
Y = inv(B);
disp(C)
