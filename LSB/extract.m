Picture=imread('kinkakuji01-steg.bmp');
Picture=double(Picture);
[m,n]=size(Picture);
result="";
len=568;
p=1;
for f2=1:n
    for f1=1:m
        if bitand(Picture(f1,f2),1)==1
            
            result=result+"1";
        else
            
            result=result+"0";
        end
        if p==len
            break;
        end
        if p<len
            p=p+1;
        end
    end
    if p==len
        break;
    end
end
fprintf("[SUCCESS] Msg=%s\n",result);
