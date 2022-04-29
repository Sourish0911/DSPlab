%Declare the Matrix
A = [1 2 3 6 3;2 5 4 1 3;1 3 5 1 5;3 2 1 4 2; 4 5 6 4 2];

%Calculate the Inverse of the MAtrix Using MATLAB Built in Function 
B = inv(A);

%Call the Blockwise Inversion function to calculate the inverse
Ainv = BlockwiseInv(A);

%Display the Inverse Matrix
disp(Ainv)

%%
%%Function Starts for Blockwise Inversion%%
function Ainv = BlockwiseInv(A)
[m,n]=size(A);
%Check if the matrix is sqaure matrix or not if not show error in inverting the matrix%
    if m ~= n || rank(A) < n
        fprintf("Inverse not posssible");
    
    %If the Inverse Matrix is of Size 1 then Calculate inverse using below operation
    elseif m == n  && m == 1
        Ainv = 1/A;
        
    %If the matrix is 2x2 then invert it using the function made to invert the 2x2 matrix%
    elseif m == 2 && n == 2
        Ainv = TwoxTwo(A);
        
    %Devide the Matrix into blocks and then Perform the inverse on it
    elseif m == n && m>=2
        %Devide the Matrix Block 1 into MAtrix of n-1 x n-1 Called A
        for i = 1:n-1
            for j = 1:n-1
                A1(i,j) = A(i,j); 
            end
        end
        %Divide the Matrix Block into Matrix B of size of n-1 x 1
        for i=1:n-1
            A2(i,1)=A(i,n);
        end
        %Divide the Matrix Block into Matrix C of size of 1 x n-1
        for i=1:n-1
            A3(1,i)=A(n,i);
        end
        
        %Final Element of n x n Matrix into D
        A4 = A(n,n);
        
        %Calculation of inverse of A
        A1inv = BlockwiseInv(A1);
        
        %Calculate the Schur Complement using A B C D blocks of the Matrix
        SchurComp1 = SchurComp(A1,A2,A3,A4);
        
        %Calculation of the Blockwise Inverse using the Formula shown in
        %Above Explanation
        B1 = A1inv+A1inv*A2*SchurComp1*A3*A1inv;
        B2 = -1*A1inv*A2*SchurComp1;
        B3 = -1*SchurComp1*A3*A1inv;
        B4 = SchurComp1;
        
        %Concatenate the Matrix to retrun the final Inverse Matrix
        B12 = [B1 B2];
        B34 = [B3 B4];
        Ainv = [B12;B34]; 
    end
end


%%
%Calculation of Achur Complement of the Matrix Based on Blocks ABCD
function Sch = SchurComp(A,B,C,D)
Sch1 = D - C*BlockwiseInv(A)*B;
Sch = BlockwiseInv(Sch1);
end

%%
%Inverse calculation of 2x2 MAtrix
function a = TwoxTwo(A)
temp = 1/det(A);
if det(A) == 0
    fprintf("Non Invertible matrix");
    return
end
a(1,1) = A(2,2);
a(1,2) = -A(1,2);
a(2,1) = -A(2,1);
a(2,2) = A(1,1);
a = temp*a;
 end