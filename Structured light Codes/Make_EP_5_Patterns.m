%Total number of edges =70; Total edges in one choice = 14;
%Total number of columns = 1960 (Multiple of 70)

EP_Code5_1= zeros(1,1960);
EP_Code5_2= zeros(1,1960);
EP_Code5_3= zeros(1,1960);
EP_Code5_4= zeros(1,1960);
EP_Code5_5= zeros(1,1960);

% ie=0:0.037:1;
% de=1:-0.037:0;
ie=0.035:0.035: 0.98;
de=0.98:-0.035:0.035;
zero=zeros(1,28);
one=ones(1,28);

first(1,1:28)=zero;
first(1,29:56)=zero;
first(1,57:84)=zero;
first(1,85:112)=zero;
first(1,113:140)=zero;
first(1,141:168)=zero;
first(1,169:196)=zero;
first(1,197:224)=one;
first(1,225:252)=one;
first(1,253:280)=one;
first(1,281:308)=one;
first(1,309:336)=one;
first(1,337:364)=one;
first(1,365:392)=one;

second(1,1:28)=zero;
second(1,29:56)=zero;
second(1,57:84)=zero;
second(1,85:112)=one;
second(1,113:140)=one;
second(1,141:168)=one;
second(1,169:196)=one;
second(1,197:224)=one;
second(1,225:252)=one;
second(1,253:280)=zero;
second(1,281:308)=zero;
second(1,309:336)=zero;
second(1,337:364)=zero;
second(1,365:392)=one;

third(1,1:28)=zero;
third(1,29:56)=one;
third(1,57:84)=one;
third(1,85:112)=one;
third(1,113:140)=one;
third(1,141:168)=zero;
third(1,169:196)=zero;
third(1,197:224)=zero;
third(1,225:252)=zero;
third(1,253:280)=zero;
third(1,281:308)=zero;
third(1,309:336)=one;
third(1,337:364)=one;
third(1,365:392)=one;

fourth(1,1:28)=one;
fourth(1,29:56)=one;
fourth(1,57:84)=zero;
fourth(1,85:112)=zero;
fourth(1,113:140)=one;
fourth(1,141:168)=one;
fourth(1,169:196)=zero;
fourth(1,197:224)=zero;
fourth(1,225:252)=one;
fourth(1,253:280)=zero;
fourth(1,281:308)=one;
fourth(1,309:336)=one;
fourth(1,337:364)=zero;
fourth(1,365:392)=zero;

first_comp(1,1:28)=one;
first_comp(1,29:56)=one;
first_comp(1,57:84)=one;
first_comp(1,85:112)=one;
first_comp(1,113:140)=one;
first_comp(1,141:168)=one;
first_comp(1,169:196)=one;
first_comp(1,197:224)=zero;
first_comp(1,225:252)=zero;
first_comp(1,253:280)=zero;
first_comp(1,281:308)=zero;
first_comp(1,309:336)=zero;
first_comp(1,337:364)=zero;
first_comp(1,365:392)=zero;

second_comp(1,1:28)=one;
second_comp(1,29:56)=one;
second_comp(1,57:84)=one;
second_comp(1,85:112)=zero;
second_comp(1,113:140)=zero;
second_comp(1,141:168)=zero;
second_comp(1,169:196)=zero;
second_comp(1,197:224)=zero;
second_comp(1,225:252)=zero;
second_comp(1,253:280)=one;
second_comp(1,281:308)=one;
second_comp(1,309:336)=one;
second_comp(1,337:364)=one;
second_comp(1,365:392)=zero;

third_comp(1,1:28)=one;
third_comp(1,29:56)=zero;
third_comp(1,57:84)=zero;
third_comp(1,85:112)=zero;
third_comp(1,113:140)=zero;
third_comp(1,141:168)=one;
third_comp(1,169:196)=one;
third_comp(1,197:224)=one;
third_comp(1,225:252)=one;
third_comp(1,253:280)=one;
third_comp(1,281:308)=one;
third_comp(1,309:336)=zero;
third_comp(1,337:364)=zero;
third_comp(1,365:392)=zero;

fourth_comp(1,1:28)=zero;
fourth_comp(1,29:56)=zero;
fourth_comp(1,57:84)=one;
fourth_comp(1,85:112)=one;
fourth_comp(1,113:140)=zero;
fourth_comp(1,141:168)=zero;
fourth_comp(1,169:196)=one;
fourth_comp(1,197:224)=one;
fourth_comp(1,225:252)=zero;
fourth_comp(1,253:280)=one;
fourth_comp(1,281:308)=zero;
fourth_comp(1,309:336)=zero;
fourth_comp(1,337:364)=one;
fourth_comp(1,365:392)=one;


fifth_ie(1,1:28)=ie;
fifth_ie(1,29:56)=de;
fifth_ie(1,57:84)=ie;
fifth_ie(1,85:112)=de;
fifth_ie(1,113:140)=ie;
fifth_ie(1,141:168)=de;
fifth_ie(1,169:196)=ie;
fifth_ie(1,197:224)=de;
fifth_ie(1,225:252)=ie;
fifth_ie(1,253:280)=de;
fifth_ie(1,281:308)=ie;
fifth_ie(1,309:336)=de;
fifth_ie(1,337:364)=ie;
fifth_ie(1,365:392)=de;


fifth_de(1,1:28)=de;
fifth_de(1,29:56)=ie;
fifth_de(1,57:84)=de;
fifth_de(1,85:112)=ie;
fifth_de(1,113:140)=de;
fifth_de(1,141:168)=ie;
fifth_de(1,169:196)=de;
fifth_de(1,197:224)=ie;
fifth_de(1,225:252)=de;
fifth_de(1,253:280)=ie;
fifth_de(1,281:308)=de;
fifth_de(1,309:336)=ie;
fifth_de(1,337:364)=de;
fifth_de(1,365:392)=ie;

EP_Code5_1(1,1:392)=fifth_ie;
EP_Code5_1(1,393:784)=first_comp;
EP_Code5_1(1,785:1176)=first;
EP_Code5_1(1,1177:1568)=first_comp;
EP_Code5_1(1,1569:1960)=first;

EP_Code5_2(1,1:392)=first;
EP_Code5_2(1,393:784)=fifth_de;
EP_Code5_2(1,785:1176)=second;
EP_Code5_2(1,1177:1568)=second_comp;
EP_Code5_2(1,1569:1960)=second;

EP_Code5_3(1,1:392)=second;
EP_Code5_3(1,393:784)=second_comp;
EP_Code5_3(1,785:1176)=fifth_ie;
EP_Code5_3(1,1177:1568)=third_comp;
EP_Code5_3(1,1569:1960)=third;

EP_Code5_4(1,1:392)=third;
EP_Code5_4(1,393:784)=third_comp;
EP_Code5_4(1,785:1176)=third;
EP_Code5_4(1,1177:1568)=fifth_de;
EP_Code5_4(1,1569:1960)=fourth;

EP_Code5_5(1,1:392)=fourth;
EP_Code5_5(1,393:784)=fourth_comp;
EP_Code5_5(1,785:1176)=fourth;
EP_Code5_5(1,1177:1568)=fourth_comp;
EP_Code5_5(1,1569:1960)=fifth_ie;
