Picture=imread('kinkakuji01.bmp');
Double_Picture=Picture;
Double_Picture=double(Double_Picture);
%wen.txt_id=fopen('wen.txt','r');
%[msg,len]=fread(wen.txt_id,'ubit1');
msg='0100000101100011011100100110111101110011011100110010000001110100011010000110010100100000010001110111001001100101011000010111010000100000010101110110000101101100011011000010000001010111011001010010000001100011011000010110111000100000010100100110010101100001011000110110100000100000010001010111011001100101011100100111100100100000010000110110111101110010011011100110010101110010001000000110111101100110001000000111010001101000011001010010000001010111011011110111001001101100011001000010000001010101001100100011000000110001001101110011000100110100001110000011100000110110';%Across the Great Wall We can Reach Every Corner of the World U201714886
len=strlength(string(msg));
[m,n]=size(Double_Picture);
p=1;
for f2=1:n
    
    for f1=1:m
        fprintf("[LOG] Embedding %d %d\t%d\n",f1,f2,Double_Picture(f1,f2));
        Double_Picture(f1,f2)=Double_Picture(f1,f2)-mod(Double_Picture(f1,f2),2)+msg(p);
        if p==len
            break;
        end
        p=p+1;
    end
    if p==len
        break;
    end
end
Double_Picture=uint8(Double_Picture);
imwrite(Double_Picture,'kinkakuji01-steg.bmp');
subplot(121);imshow(Picture);title('Oroginal Pic');
subplot(122);imshow(Double_Picture);title('Embedded Pic');

