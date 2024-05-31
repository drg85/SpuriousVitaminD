%This code allows us to predict false positive rates with 5 thresholds... 

au = 13.3934;
bu = 4.1355;
muus = 3.21637;
sigus = 0.247837;
muuk = log(au);
siguk = 1/bu;  
pduk = makedist('Loglogistic','mu',muuk,'sigma',siguk);
pdus = makedist('Loglogistic','mu',muus,'sigma',sigus);
n = 1000; 
p = 0.5;
vc = 1:n;

i = 1;

griduk = zeros(5,10000);
gridus = zeros(5,10000);

while i < 10001

f= round(n.*p); 
y = randsample(n,f); 
yc = setdiff(vc,y); %complmement



%if population is like uk
xuk = random(pduk,n,1);


%if populatio is like us
xus = random(pdus,n,1);
 

% 10 ng cut off
xuk10 = xuk(y);
xuk10c = xuk(yc); 
nvec(1) = length(find(xuk10 <= 10));
nvec(2) = length(find(xuk10 > 10));
nvec(3) = length(find(xuk10c <= 10));
nvec(4) = length(find(xuk10c > 10));
griduk(1,i) = chisyst(nvec);

clear nvec xuk10 xuk10c 

xus10 = xus(y);
xus10c = xus(yc); 
nvec(1) = length(find(xus10 <= 10));
nvec(2) = length(find(xus10 > 10));
nvec(3) = length(find(xus10c <= 10));
nvec(4) = length(find(xus10c > 10));
gridus(1,i) = chisyst(nvec);

clear nvec xus10 xus10c 

% 12 ng cut off
xuk12 = xuk(y);
xuk12c = xuk(yc); 
nvec(1) = length(find(xuk12 <= 12));
nvec(2) = length(find(xuk12 > 12));
nvec(3) = length(find(xuk12c <= 12));
nvec(4) = length(find(xuk12c > 12));
griduk(2,i) = chisyst(nvec);

clear nvec xuk12 xuk12c 

xus12 = xus(y);
xus12c = xus(yc); 
nvec(1) = length(find(xus12 <= 12));
nvec(2) = length(find(xus12 > 12));
nvec(3) = length(find(xus12c <= 12));
nvec(4) = length(find(xus12c > 12));
gridus(2,i) = chisyst(nvec);

clear nvec xus12 xus12c 

% 15 ng cut off
xuk15 = xuk(y);
xuk15c = xuk(yc); 
nvec(1) = length(find(xuk15 <= 15));
nvec(2) = length(find(xuk15 > 15));
nvec(3) = length(find(xuk15c <= 15));
nvec(4) = length(find(xuk15c > 15));
griduk(3,i) = chisyst(nvec);

clear nvec xuk15 xuk15c 

xus15 = xus(y);
xus15c = xus(yc); 
nvec(1) = length(find(xus15 <= 15));
nvec(2) = length(find(xus15 > 15));
nvec(3) = length(find(xus15c <= 15));
nvec(4) = length(find(xus15c > 15));
gridus(3,i) = chisyst(nvec);

clear nvec xus15 xus15c 

% 20 ng cut off
xuk20 = xuk(y);
xuk20c = xuk(yc); 
nvec(1) = length(find(xuk20 <= 20));
nvec(2) = length(find(xuk20 > 20));
nvec(3) = length(find(xuk20c <= 20));
nvec(4) = length(find(xuk20c > 20));
griduk(4,i) = chisyst(nvec);

clear nvec xuk20 xuk20c 

xus20 = xus(y);
xus20c = xus(yc); 
nvec(1) = length(find(xus20 <= 20));
nvec(2) = length(find(xus20 > 20));
nvec(3) = length(find(xus20c <= 20));
nvec(4) = length(find(xus20c > 20));
gridus(4,i) = chisyst(nvec);

clear nvec xus20 xus20c 

% 30 ng cut off
xuk30 = xuk(y);
xuk30c = xuk(yc); 
nvec(1) = length(find(xuk30 <= 30));
nvec(2) = length(find(xuk30 > 30));
nvec(3) = length(find(xuk30c <= 30));
nvec(4) = length(find(xuk30c > 30));
griduk(5,i) = chisyst(nvec);

clear nvec xuk30 xuk30c 

xus30 = xus(y);
xus30c = xus(yc); 
nvec(1) = length(find(xus30 <= 30));
nvec(2) = length(find(xus30 > 30));
nvec(3) = length(find(xus30c <= 30));
nvec(4) = length(find(xus30c > 30));
gridus(5,i) = chisyst(nvec);

clear nvec xus30 xus30c 

i = i +1;

end

ukcount = 0;
uscount = 0;

for j = 1:10000;
    
   ukv = griduk(:,j);
   if double(any(ukv < 0.05)) > 0       
       ukcount = ukcount +1;
   end
    clear ukv
    
    usv = gridus(:,j);
   if double(any(usv < 0.05)) > 0        
       uscount = uscount +1;
   end
    
   clear usv
    
end