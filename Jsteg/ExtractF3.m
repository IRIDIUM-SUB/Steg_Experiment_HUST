%Read image
originobj= jpeg_read('kinkakuji-F3.jpg');
I=imread('kinkakuji-Jsteg.jpg');
activedobj=originobj;
ran=rng(7742085);%Seed No repeat in this seed
result="";%Store 0-1 string
randtable=randperm(256*400);%Shuffle
FrequencyStatic=tabulate(randtable(:));
RandTableIndex=1;
Index=1;

%Debug


while Index<=576%Len of plain
    %Get Location
    location=randtable(RandTableIndex);
    %Try to Resolve
    row=ceil(location/400);
    column=mod(location,400)+1;
    %Try
    if activedobj.coef_arrays{1,1}(row,column)==0
        %Fail to Fetch, Throw
        RandTableIndex=RandTableIndex+1;%Fetch the Next One
        continue
    end
    %For any vavild cell
    steg=activedobj.coef_arrays{1,1}(row,column);
    %Debug

    fprintf("%d-%d-RandTableIndex%d\tLocation%d\n",steg,mod(steg,2),RandTableIndex,location);
    %Recover
    %steg=odd->1
    %steg=even->0
    result=result+int2str(mod(steg,2));
    
    RandTableIndex=RandTableIndex+1;
    Index=Index+1; 
end
plain="010000010110001101110010011011110111001101110011001000000111010001101000011001010010000001000111011100100110010101100001011101000010000001010111011000010110110001101100001000000101011101100101001000000110001101100001011011100010000001010010011001010110000101100011011010000010000001000101011101100110010101110010011110010010000001000011011011110111001001101110011001010111001000100000011011110110011000100000011101000110100001100101001000000101011101101111011100100110110001100100001000000101010100110010001100000011000100110110001100010011010000111000001101000011100000001010";%Across the Great Wall We can Reach Every Corner of the World U201614848
kp=isequal(plain,result);%Final Comparison
