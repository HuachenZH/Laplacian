x=10;   %longueur en x
y=5;   %longueur en y
h=.1;  %pas
m=0:h:x;
n=0:h:y;
flux_chaleur=-200; % -phi/k
T=zeros(length(n),length(m));
length(T);
Echelon=ones(length(n),length(m));


T(1,:)=10;
T(:,1)=10;
T(length(n),:)=10;
T(:,length(m))=10;
T(30:40,1)=100;
T1=T;
for i=1:20
    for j=75:101
        Echelon(i,j)=0;
    end
end
T=T.*Echelon;
[xq,yq] = meshgrid(m, n);

% M=moviein(length(n)-2);


accuracy=.0000001; count=0;
flag=zeros(length(n),length(m));
% error=zeros(length(n),length(m));
num=(length(n)-2)*(length(m)-2);
while count<=num
    for i=2:length(n)-1     %indice ligne
        for j=2:length(m)-1 %indice colonne
            if flag(i,j)==0
                temp_float=T(i,j);
                if(i==2||j==2)
                % -----N S W E -------%
                T(i,j)=(T(i-1,j) ...    %North
                +T(i+1,j) ...       %South
                +T(i,j-1) ...       %West
                +T(i,j+1))/4 ...    %East
                -(h^2*flux_chaleur)/4  ;       %complément si laplacien non nul 
                
                % -----/ N S W E -------%
                % -----N S W E -------%
                else
                T(i,j)=(T(i-1,j) ...    %North
                +T(i+1,j) ...       %South
                +T(i,j-1) ...       %West
                +T(i,j+1))/4;   %East
                % -----/ N S W E -------%
                end
                cur_err=(T(i,j)-temp_float)/T(i,j);
                T=T.*Echelon;
                %T=T1;
                
%                 M(i,j)=getframe(gcf);
            end
            if abs(cur_err)<=accuracy
                %error(i,j)=cur_err;
                 flag(i,j)=1;
                count=count+1;
            end
        end
    end    
end
count
% movie(M)


meshc(xq,yq,T)