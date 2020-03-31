A=imread('kinkakuji01.jpg');
I=rgb2gray(A); %RGB图转化为灰度图
imwrite(I,'kinkakuji01g.jpg','quality',100);
originobj= jpeg_read('kinkakuji01g.jpg');
activedobj=originobj;
subplot(2,2,1);


histogram(originobj.coef_arrays{1,1});%display Frequency distribution histogram
title("Original Frequency distribution histogram");
plain='010000010110001101110010011011110111001101110011001000000111010001101000011001010010000001000111011100100110010101100001011101000010000001010111011000010110110001101100001000000101011101100101001000000110001101100001011011100010000001010010011001010110000101100011011010000010000001000101011101100110010101110010011110010010000001000011011011110111001001101110011001010111001000100000011011110110011000100000011101000110100001100101001000000101011101101111011100100110110001100100001000000101010100110010001100000011000100110110001100010011010000111000001101000011100000001010';%Across the Great Wall We can Reach Every Corner of the World U201614848
ran=rng(7742085);%Seed No repeat in this seed
uosedindex=[];
throwedindex=[];
%DCT Table's Size=256*400
randtable=randperm(256*400);
FrequencyStatic=tabulate(randtable(:));
RandTableIndex1=1;
RandTableIndex2=2;
RandTableIndex3=3;
index=1;

% For Each 3 DCT coef and 2 plain
while index<=length(plain)/2

    a1=randtable(RandTableIndex1);
    row1=ceil(a1/400);
    column1=mod(a1,400)+1;
    
    a2=randtable(RandTableIndex2);
    row2=ceil(a2/400);
    column2=mod(a2,400)+1;
    
    a3=randtable(RandTableIndex3);
    row3=ceil(a3/400);
    column3=mod(a3,400)+1;
    
    
    x1=str2num(plain((index-1)*2+1));
    x2=str2num(plain((index-1)*2+2));

    %Check and Drop
    %Pretty Slow But Readable
    if activedobj.coef_arrays{1,1}(row1,column1)==0
        RandTableIndex1=RandTableIndex1+1;
        RandTableIndex2=RandTableIndex2+1;
        RandTableIndex3=RandTableIndex3+1;
        fprintf("[LOG] a1=0, move,%d\t%d\t%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3);
        continue;%Restart
    else
        if activedobj.coef_arrays{1,1}(row2,column2)==0
        RandTableIndex2=RandTableIndex2+1;
        RandTableIndex3=RandTableIndex3+1;
        fprintf("[LOG] a2=0, move,%d\t%d\t%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3);
        continue;%Restart
        else
            if activedobj.coef_arrays{1,1}(row3,column3)==0
                RandTableIndex3=RandTableIndex3+1;
                fprintf("[LOG] a3=0, move,%d\t%d\t%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3);
                continue;%Restart
            end
        end
    end

    %Now it should be 3 non-0 DCT coef
    fprintf("[READY] Current DCT Coef Group:%d\t%d\t%d\n",activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3));
    if mod(bitxor(activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)==x1&&mod(bitxor(activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)==x2%p && q?keep:pass;
        fprintf("[LOG] No Change,%d\t%d\t%d \t %d\t%d\n",activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),x1,x2);
    else
        if mod(bitxor(activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)~=x1&&mod(bitxor(activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)==x2%!p&&q?Change a1:pass;
            fprintf("[LOG] Change a1,%d\t%d\t%d \t %d\t%d\n",activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),x1,x2);
            if activedobj.coef_arrays{1,1}(row1,column1)>0
               activedobj.coef_arrays{1,1}(row1,column1)=activedobj.coef_arrays{1,1}(row1,column1)-1;
           else
               activedobj.coef_arrays{1,1}(row1,column1)=activedobj.coef_arrays{1,1}(row1,column1)+1;
           end
        else
            if mod(bitxor(activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)==x1&&mod(bitxor(activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)~=x2%p&&!q?Change a2:pass;
              fprintf("[LOG] Change a2,%d\t%d\t%d \t %d\t%d\n",activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),x1,x2);
              if activedobj.coef_arrays{1,1}(row2,column2)>0
               activedobj.coef_arrays{1,1}(row2,column2)=activedobj.coef_arrays{1,1}(row2,column2)-1;
              else
               activedobj.coef_arrays{1,1}(row2,column2)=activedobj.coef_arrays{1,1}(row2,column2)+1;
              end  
            else
                if mod(bitxor(activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)~=x1&&mod(bitxor(activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),'int16'),2)~=x2%!p&&!q?Change a3:pass;
                    fprintf("[LOG] Change a3,%d\t%d\t%d \t %d\t%d\n",activedobj.coef_arrays{1,1}(row1,column1),activedobj.coef_arrays{1,1}(row2,column2),activedobj.coef_arrays{1,1}(row3,column3),x1,x2);
                    if activedobj.coef_arrays{1,1}(row3,column3)>0
                        activedobj.coef_arrays{1,1}(row3,column3)=activedobj.coef_arrays{1,1}(row3,column3)-1;
                    else
                        activedobj.coef_arrays{1,1}(row3,column3)=activedobj.coef_arrays{1,1}(row3,column3)+1;
                    end
                end
            end
        end
    end
    
    %Shrinkage
    if activedobj.coef_arrays{1,1}(row1,column1)==0
        fprintf("[LOG] %d\tShrinkage a1,%d\t%d\t%d\n",index,RandTableIndex1,RandTableIndex2,RandTableIndex3);
        RandTableIndex1=RandTableIndex2;
        RandTableIndex2=RandTableIndex3;
        RandTableIndex3=RandTableIndex3+1;
        continue;
    else
        if activedobj.coef_arrays{1,1}(row2,column2)==0
            fprintf("[LOG] %d\tShrinkage a2,%d\t%d\t%d\n",index,RandTableIndex1,RandTableIndex2,RandTableIndex3);
            RandTableIndex2=RandTableIndex3;
            RandTableIndex3=RandTableIndex3+1; 
            continue;
        else
            if  activedobj.coef_arrays{1,1}(row3,column3)==0
                fprintf("[LOG] %d\tShrinkage a3%d\t%d\t%d\n",index,RandTableIndex1,RandTableIndex2,RandTableIndex3);
                RandTableIndex3=RandTableIndex3+1; 
                continue;
            end
        end
    end
    %Adjust DCT Coef Index
    %Start Over
    RandTableIndex1=RandTableIndex3+1;
    RandTableIndex2=RandTableIndex1+1;
    RandTableIndex3=RandTableIndex2+1;
    index=index+1;
    fprintf("[SUCCESS] Embedding Success:Next Group:%d\t%d\t%d\t%d\n",RandTableIndex1,RandTableIndex2,RandTableIndex3,index);
end
subplot(2,2,2)
histogram(activedobj.coef_arrays{1,1});%display Frequency distribution histogram
title("Current Frequency distribution histogram");

result=isequal(originobj.coef_arrays{1,1},activedobj.coef_arrays{1,1});
jpeg_write(activedobj,'kinkakuji-F5.jpg');
%Show DCT coefficient histogram
Aft=imread('kinkakuji-F5.jpg');
subplot(2,2,3)
imhist(I);
title("DCT coefficient histogram-Original");

subplot(2,2,4)
imhist(Aft);
title("DCT coefficient histogram-F5");
            
    
