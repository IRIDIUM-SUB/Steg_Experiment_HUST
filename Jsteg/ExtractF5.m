%Read image
originobj= jpeg_read('kinkakuji-F5.jpg');
I=imread('kinkakuji-Jsteg.jpg');
activedobj=originobj;
ran=rng(7742085);%Seed No repeat in this seed
result="";%Store 0-1 string
randtable=randperm(256*400);%Shuffle
FrequencyStatic=tabulate(randtable(:));
RandTableIndex1=1;
RandTableIndex2=2;
RandTableIndex3=3;
Index=1;

%Debug

while Index<=576/2%Len of plain
    a1=randtable(RandTableIndex1);
    row1=ceil(a1/400);
    column1=mod(a1,400)+1;
    
    a2=randtable(RandTableIndex2);
    row2=ceil(a2/400);
    column2=mod(a2,400)+1;
    
    a3=randtable(RandTableIndex3);
    row3=ceil(a3/400);
    column3=mod(a3,400)+1;
    
    if activedobj.coef_arrays{1,1}(row1,column1)==0
        RandTableIndex1=RandTableIndex1+1;
        RandTableIndex2=RandTableIndex2+1;
        RandTableIndex3=RandTableIndex3+1;
        fprintf("[LOG] a1=0, move,%d-%d-%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3);
        continue;%Restart
    else
        if activedobj.coef_arrays{1,1}(row2,column2)==0
        RandTableIndex2=RandTableIndex2+1;
        RandTableIndex3=RandTableIndex3+1;
        fprintf("[LOG] a2=0, move,%d-%d-%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3);
        continue;%Restart
        else
            if activedobj.coef_arrays{1,1}(row3,column3)==0
                RandTableIndex3=RandTableIndex3+1;
                fprintf("[LOG] a3=0, move,%d-%d-%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3);
                continue;%Restart
            end
        end
    end
    %Now it should be 3 non-0 DCT coef
    fprintf("[READY] Current DCT Coef Group:%d-%d-%d\n",activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3));
    result=result+num2str(mod(bitxor(activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2));
    fprintf("[INFO] %d\tReveal[1]:%d\t%d->%d\n",Index,activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),mod(bitxor(activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2));
    result=result+num2str(mod(bitxor(activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2));
    fprintf("[INFO] %d\tReveal[2]:%d\t%d->%d\n",Index,activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),mod(bitxor(activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2));
    %Prepare for the next Group
    RandTableIndex1=RandTableIndex3+1;
    RandTableIndex2=RandTableIndex1+1;
    RandTableIndex3=RandTableIndex2+1;
    Index=Index+1;
    fprintf("[SUCCESS] Revaling Success:Next Group:%d-%d-%d\t%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3,Index);
end



plain="010000010110001101110010011011110111001101110011001000000111010001101000011001010010000001000111011100100110010101100001011101000010000001010111011000010110110001101100001000000101011101100101001000000110001101100001011011100010000001010010011001010110000101100011011010000010000001000101011101100110010101110010011110010010000001000011011011110111001001101110011001010111001000100000011011110110011000100000011101000110100001100101001000000101011101101111011100100110110001100100001000000101010100110010001100000011000100110110001100010011010000111000001101000011100000001010";%Across the Great Wall We can Reach Every Corner of the World U201614848
ifeuqal=isequal(plain,result);%Final Comparison