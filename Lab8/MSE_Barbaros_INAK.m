function MSE = MSE_Barbaros_INAK(Message,Filtered_message)

[m,n]=size(Message);

sum=0;

for i=1:m;
    for j=1:n;
        
        sum=sum+(Message(i,j)-Filtered_message(i,j))^2;
        
    end
    
end

    MSE=sum/(m*n);

end