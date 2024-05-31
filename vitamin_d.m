%read in US data
data = xptread("VID_J.XPT");
lvl = data(:,2);
lvl = table2array(lvl); %nmol / l
a = find(isnan(lvl));
lvl(a) = [];
clear a;
lvl = lvl*0.4; %convert to ng/ml

%From UK Study
ukdata_x = [25 50 75 100]; %nmol / l
ukdata_x = 0.4.*ukdata_x; 
ukdata_y = [0.23 0.84 0.96 0.99]; 

%produce a log-logistic fit for US data! 
pdus = fitdist(lvl,'Loglogistic');

x_values = 0:1:100;
y = pdf(pdus,x_values);
yc = cdf(pdus,x_values);
%plot(x_values,y)
figure()
%plot(x_values,yc)


%produce a log-logistic fit for US data! 
pdus = fitdist(lvl,'Loglogistic');

xv = 0:1:100;
y = pdf(pdus,xv);
%plot(xv,y)


%log logistic 

F = @(x) [ (10.^x(1))./(x(2).^x(1) + 10.^x(1)) - 0.23 ;
         (20.^x(1))./(x(2).^x(1) + 20.^x(1)) - 0.84];

%Solve to get co-effs
x0 = [-20 20];
[x,fval] = fsolve(F,x0)
au = x(2);
bu = x(1); 

%Probs US
othpd = ((bu/au).*((xv./au).^(bu-1)))./((1 + (xv./au).^bu).^2);
othcd = 1./(1 + (xv./au).^(-bu))


%make us levels?
u10 = length(find(lvl <= 10))/(7409);
u15 = length(find(lvl <= 15))/(7409);
u20 = length(find(lvl <= 20))/(7409);
u25 = length(find(lvl <= 25))/(7409);
u30 = length(find(lvl <= 30))/(7409);
u35 = length(find(lvl <= 35))/(7409);
u40 = length(find(lvl <= 40))/(7409);
u45 = length(find(lvl <= 45))/(7409);
u50 = length(find(lvl <= 50))/(7409);
u55 = length(find(lvl <= 55))/(7409);
u60 = length(find(lvl <= 60))/(7409);

amerdatay = [u10 u15 u20 u25 u30 u35 u40 u45 u50 u55 u60];
amerdatax = 10:5:60; 


%Plots and data

figure(1)
h1 = plot(x_values,yc); 
hold on
h2 = plot(x_values,othcd);
hold on
h3 = plot(amerdatax,amerdatay,'o');
hold on
h4 = plot(ukdata_x,ukdata_y,'o')
legend('US Fit','UK Fit','US data','UK data')
xlim([0 60])
xlabel('Vitamin D level (ng / mL)')
ylabel('cdf')


%and log-logistic paras:
muus = 3.21637;
sigus = 0.247837;
muuk = log(au);
siguk = 1/bu;   % https://uk.mathworks.com/matlabcentral/answers/428624-cdf-for-loglogistic-distribution

%zt = (log(x_values) -muuk)./siguk;
%checkpdf = (1/siguk).*(1./x_values).*exp(zt)./((1 + exp(zt)).^2);
%this works

%percentiles

aus = exp(muus);
bus = 1/sigus; 


%using quantile function! 
%average methods

for p = 1:99
pp = p/100; 
ppp = (p-1)./100; 
    
    puk(p) = au.*((pp./(1-pp)).^(1/bu) + (ppp./(1-ppp)).^(1./bu))/2;
     pus(p) = aus.*((pp./(1-pp)).^(1/bus) + (ppp./(1-ppp)).^(1./bus))/2;
       
          
end

RR = pus./puk;

figure(2)
plot(RR)
xlabel('Percentile')
ylabel('Relative Risk Ratio')


