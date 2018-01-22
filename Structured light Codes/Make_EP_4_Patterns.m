%Total number of columns = 1920
%Period = 4
%Total number of edges in one period =6; Total number of edges =24;

EP_Code4_1= zeros(1,1920);
EP_Code4_2= zeros(1,1920);
EP_Code4_3= zeros(1,1920);
EP_Code4_4= zeros(1,1920);

% ie=0:0.0125:1;
% de=1:-0.0125:0;
ie=0.01:0.0123:0.99;   %range array from 0.01 to 0.99
de=0.99:-0.0123:0.01;
zero=zeros(1,80);
one=ones(1,80);

first(1,1:80)= zero;
first(1,81:160)= zero;
first(1,161:240)= zero;  
first(1,241:320)= one;
first(1,321:400)= one;
first(1,401:480)= one;

second(1,1:80)= zero;
second(1,81:160)= one;
second(1,161:240)= one;  
second(1,241:320)= one;
second(1,321:400)= zero;
second(1,401:480)= zero;

third(1,1:80)= one;
third(1,81:160)= one;
third(1,161:240)= zero;  
third(1,241:320)= zero;
third(1,321:400)= zero;
third(1,401:480)= one;

first_comp(1,1:80)= one;
first_comp(1,81:160)= one;
first_comp(1,161:240)= one;  
first_comp(1,241:320)= zero;
first_comp(1,321:400)= zero;
first_comp(1,401:480)= zero;

second_comp(1,1:80)= one;
second_comp(1,81:160)= zero;
second_comp(1,161:240)= zero;  
second_comp(1,241:320)= zero;
second_comp(1,321:400)= one;
second_comp(1,401:480)= one;

third_comp(1,1:80)= zero;
third_comp(1,81:160)= zero;
third_comp(1,161:240)= one;  
third_comp(1,241:320)= one;
third_comp(1,321:400)= one;
third_comp(1,401:480)= zero;

fourth_ie(1,1:80)= ie;
fourth_ie(1,81:160)= de;
fourth_ie(1,161:240)= ie;  
fourth_ie(1,241:320)= de;
fourth_ie(1,321:400)= ie;
fourth_ie(1,401:480)= de;

fourth_de(1,1:80)= de;
fourth_de(1,81:160)= ie;
fourth_de(1,161:240)= de;  
fourth_de(1,241:320)= ie;
fourth_de(1,321:400)= de;
fourth_de(1,401:480)= ie;

EP_Code4_1(1,1:480)=fourth_ie;
EP_Code4_1(1,481:960)=first;
EP_Code4_1(1,961:1440)=first_comp;
EP_Code4_1(1,1441:1920)=first;

EP_Code4_2(1,1:480)=first;
EP_Code4_2(1,481:960)=fourth_de;
EP_Code4_2(1,961:1440)=second_comp;
EP_Code4_2(1,1441:1920)=third;

EP_Code4_3(1,1:480)=second;
EP_Code4_3(1,481:960)=second;
EP_Code4_3(1,961:1440)=fourth_ie;
EP_Code4_3(1,1441:1920)=second;

EP_Code4_4(1,1:480)=third;
EP_Code4_4(1,481:960)=third;
EP_Code4_4(1,961:1440)=third_comp;
EP_Code4_4(1,1441:1920)=fourth_ie;
